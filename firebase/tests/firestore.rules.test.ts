import {
  apps,
  clearFirestoreData,
  initializeTestApp,
  initializeAdminApp,
  assertFails,
  assertSucceeds,
  loadFirestoreRules
} from "@firebase/rules-unit-testing";
import type firebase from 'firebase/app'
import * as fs from "fs";

const PROJECT_ID = "money-hacker";
const RULES_PATH = "firestore.rules";

// 認証付きのFreistore appを作成する
// Custom User Claimを使いたいときは、FirebaseIdTokenで予約されてないキーをそのまま入れる
// { 'uid': '...', 'isAdmin': true } => ruleでの評価方法は`response.auth.token.isAdmin`
//
const createAuthApp = (auth?: object) => {
  return initializeTestApp({ projectId: PROJECT_ID, auth: auth })
    .firestore();
};

const createUnAuthApp = () => {
  return initializeTestApp({ projectId: PROJECT_ID }).firestore();
};

// 管理者権限で操作できるFreistore appを作成する
const createAdminApp = () => {
  return initializeAdminApp({ projectId: PROJECT_ID }).firestore();
};

// user情報への参照を作る
const taxExemptedCompareRef = (db: firebase.firestore.Firestore) => db.collection("taxExemptedCompare/1/saved");

describe("Firestoreセキュリティルール", () => {
  // ルールファイルの読み込み
  beforeAll(async () => {
    const rules = fs.readFileSync(RULES_PATH, "utf8")
    await loadFirestoreRules({
      projectId: PROJECT_ID,
      rules: rules
    });
  });

  // Firestoreデータのクリーンアップ
  afterEach(async () => {
    await clearFirestoreData({ projectId: PROJECT_ID });
  });

  // Firestoreアプリの削除
  afterAll(async () => {
    await Promise.all(apps().map(app => app.delete()));
  });

  const validTaxExemptedCompareJSON = {
    "taxIncludedIncome": 123456,
    "taxIncludedExpenses": 123456,
    "otherRemoval": 10000,
    "age": 40,
    "typeOfDeclaration": "Hoge"
  }

  const invalidJSON = {
    "hoge": "1",
    "hoge1": "1",
    "hoge2": "1",
    "hoge3": "1",
    "hoge4": "1",
  }

  // Authorization
  test("ゲストはtaxExemptedCompareに書き込めない/読めない", async () => {
    const db = createUnAuthApp()
    const collection = taxExemptedCompareRef(db)
    const doc = collection.doc("test")
    await assertFails(collection.get());             // list
    await assertFails(doc.get());              // get
    await assertFails(doc.set(validTaxExemptedCompareJSON))  // create
    await assertFails(doc.set(validTaxExemptedCompareJSON))  // update
    await assertFails(doc.delete())            // delete
  })
  
  test("認証ユーザはtaxExemptedCompareに書き込める/読める", async () => {
    const db = createAuthApp({'uid': 'hoge'})
    const collection = taxExemptedCompareRef(db)
    const doc = collection.doc("test")
    // await assertFails(collection.get());             // list
    await assertSucceeds(doc.set(validTaxExemptedCompareJSON))  // create
    await assertSucceeds(doc.get());              // get
    // await assertFails(doc.set(validTaxExemptedCompareJSON))  // update
    // await assertFails(doc.delete())            // delete
  })

  // Data Validation

  test("認証ユーザはtaxExemptedCompareに正しくないJSONは書き込めない", async () => {
    const db = createAuthApp({'uid': 'hoge'})
    const collection = taxExemptedCompareRef(db)
    const doc = collection.doc("test")
    await assertFails(doc.set(invalidJSON))  // create
  })

})