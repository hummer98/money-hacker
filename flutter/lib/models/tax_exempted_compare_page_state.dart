import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_hacker/models/income_tax.dart';
import 'package:money_hacker/services/national_health_insurance_service.dart';

part 'tax_exempted_compare_page_state.freezed.dart';
part 'tax_exempted_compare_page_state.g.dart';

/// 確定申告種別
enum TypeOfDeclaration { white, blue10, blue55, blue65 }

extension TypeOfDeclarationExtension on TypeOfDeclaration {
  int get removal {
    switch (this) {
      case TypeOfDeclaration.white:
        return 0;
      case TypeOfDeclaration.blue10:
        return 100000;
      case TypeOfDeclaration.blue55:
        return 550000;
      case TypeOfDeclaration.blue65:
        return 650000;
    }
  }

  String get title {
    switch (this) {
      case TypeOfDeclaration.white:
        return '白色申告(0万円)';
      case TypeOfDeclaration.blue10:
        return '青色申告(控除額10万円)';
      case TypeOfDeclaration.blue55:
        return '青色申告(控除額55万円)';
      case TypeOfDeclaration.blue65:
        return '電子申告による青色申告(控除額65万円)';
    }
  }

  static List<TypeOfDeclaration> get allTypes {
    return [
      TypeOfDeclaration.white,
      TypeOfDeclaration.blue10,
      TypeOfDeclaration.blue55,
      TypeOfDeclaration.blue65,
    ];
  }
}

@freezed
class TaxExemptedComparePageState with _$TaxExemptedComparePageState {
  const factory TaxExemptedComparePageState({
    String? id,

    /// 税込み収入
    @Default(10000000) int taxIncludedIncome,

    /// 税込み経費
    @Default(0) int taxIncludedExpenses,

    /// 社会保険料
    @Default(0) int amountOfSocialInsurancePremiums,

    /// その他控除
    @Default(0) int otherRemoval,

    /// 年齢
    @Default(35) int age,

    /// 申告種別
    @Default(TypeOfDeclaration.blue65) TypeOfDeclaration typeOfDeclaration,
  }) = _TaxExemptedComparePageState;

  factory TaxExemptedComparePageState.fromJson(Map<String, dynamic> json) =>
      _$TaxExemptedComparePageStateFromJson(json);

  factory TaxExemptedComparePageState.fromSnapshot(DocumentSnapshot<Map<String, Object?>> snapshot) =>
      TaxExemptedComparePageState.fromJson({
        'id': snapshot.id,
        ...?snapshot.data(),
      });
}

/// FIXME: 自動計算はプロパティでなくJSONにしたほうが良い
extension TaxExemptedComparePageStateExtension on TaxExemptedComparePageState {
  /// 基礎控除
  int get baseRemoval => 480000;

  /// 所得税控除合計
  int get totalRemoval => baseRemoval - otherRemoval - amountOfSocialInsurancePremiums;

  /// 住民税基礎控除
  int get baseRemovalForResident => 430000;

  /// 住民税控除合計
  int get totalRemovalForResident => baseRemovalForResident - otherRemoval - amountOfSocialInsurancePremiums;

  /// 申告種別による控除額
  int get declarationRemoval => typeOfDeclaration.removal;

  /// 課税事業者売上額
  int get salesAmount => taxIncludedIncome ~/ 1.1;

  /// 課税事業者所得
  int get income => max(0, (salesAmount - (taxIncludedExpenses / 1.1)).toInt() - declarationRemoval);

  /// 免税事業者所得
  int get exIncome => max(0, taxIncludedIncome - taxIncludedExpenses - declarationRemoval);

  /// 所得税課税所得
  int get taxableIncome => max(0, income - totalRemoval);
  int get exTaxableIncome => max(0, exIncome - totalRemoval);

  /// 住民税課税所得
  int get taxableIncomeForResidentTax => max(0, income - totalRemovalForResident);
  int get exTaxableIncomeForResidentTax => max(0, exIncome - totalRemovalForResident);

  /// 所得税
  int get incomeTax => IncomeTax.taxAmountWithSpecial(taxableIncome);
  int get exIncomeTax => IncomeTax.taxAmountWithSpecial(exTaxableIncome);

  /// 住民税
  int get residentTax => (taxableIncomeForResidentTax * 0.1).toInt();
  int get exResidentTax => (exTaxableIncomeForResidentTax * 0.1).toInt();

  /// 国民健康保険税
  int get nationalHealthInsuranceTax => NationalHealthInsuranceService().amountOfTax(income, age);
  int get exNationalHealthInsuranceTax => NationalHealthInsuranceService().amountOfTax(exIncome, age);

  /// 租税合計
  int get totalTax => residentTax + incomeTax + nationalHealthInsuranceTax + vatPaid;
  int get exTotalTax => exResidentTax + exNationalHealthInsuranceTax + exIncomeTax;

  /// 消費税
  int get vat => (salesAmount * 0.1).toInt();

  /// 消費税支払額
  int get vatPaid => (vat * vatRate * 0.01).toInt();

  /// 簡易課税率
  int get vatRate => 50;

  /// 手取り額
  int get netIncome => exIncome - totalTax;
  int get exNetIncome => exIncome - exTotalTax;

  /// 手取り差額
  int get netIncomeDiff => netIncome - exNetIncome;

  /// 所得税率表
  IncomeTaxRate get incomeTaxRate => IncomeTax.withIncome(income);
  IncomeTaxRate get exIncomeTaxRate => IncomeTax.withIncome(exIncome);

  /// 租税差額
  int get totalTaxDiff => totalTax - exTotalTax;

  /// 消費税益税
  int get vatIncome => (vat * (100 - vatRate) * 0.01).toInt();

  Map<String, Object?> toSnapshot() => toJson()..remove('id');

  static DocumentReference<Map<String, Object?>> ref(String? id) =>
      FirebaseFirestore.instance.collection('taxExemptedComparePageState').doc(id);

  static Future<TaxExemptedComparePageState> read(String id) =>
      ref(id).get().then((s) => TaxExemptedComparePageState.fromSnapshot(s));

  Future<void> save() {
    return TaxExemptedComparePageStateExtension.ref(id).set(toSnapshot());
  }
}
