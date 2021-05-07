import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_hacker/models/income_tax.dart';

part 'tax_exempted_compare_page_state.freezed.dart';
part 'tax_exempted_compare_page_state.g.dart';

@freezed
class TaxExemptedComparePageState with _$TaxExemptedComparePageState {
  const factory TaxExemptedComparePageState({
    String? id,

    /// 税込み収入
    @Default(7000000) int taxIncludedIncome,
    @Default(0) int taxIncludedExpenses,
  }) = _TaxExemptedComparePageState;

  factory TaxExemptedComparePageState.fromJson(Map<String, dynamic> json) =>
      _$TaxExemptedComparePageStateFromJson(json);

  factory TaxExemptedComparePageState.fromSnapshot(DocumentSnapshot<Map<String, Object?>> snapshot) =>
      TaxExemptedComparePageState.fromJson({
        'id': snapshot.id,
        ...?snapshot.data(),
      });
}

extension TaxExemptedComparePageStateExtension on TaxExemptedComparePageState {
  /// 基礎控除
  int get baseRemoval => 480000;

  /// 所得税控除合計
  int get totalRemoval => baseRemoval;

  /// 住民税基礎控除
  int get baseRemovalForResident => 430000;

  /// 住民税控除合計
  int get totalRemovalForResident => baseRemovalForResident;

  /// 課税事業者所得
  int get income => ((taxIncludedIncome / 1.1) - (taxIncludedExpenses / 1.1)).toInt();

  /// 免税事業者所得
  int get exIncome => taxIncludedIncome - taxIncludedExpenses;

  /// 所得税課税所得
  int get taxableIncome => max(0, income - totalRemoval);
  int get exTaxableIncome => max(0, exIncome - totalRemoval);

  /// 住民税課税所得
  int get taxableIncomeForResidentTax => income - totalRemovalForResident;
  int get exTaxableIncomeForResidentTax => exIncome - totalRemovalForResident;

  /// 所得税
  int get incomeTax => IncomeTax.taxAmountWithSpecial(taxableIncome);
  int get exIncomeTax => IncomeTax.taxAmountWithSpecial(exTaxableIncome);

  /// 住民税
  int get residentTax => (taxableIncomeForResidentTax * 0.1).toInt();
  int get exResidentTax => (exTaxableIncomeForResidentTax * 0.1).toInt();

  /// 租税合計
  int get totalTax => residentTax + incomeTax + vatPaid;
  int get exTotalTax => exResidentTax + exIncomeTax;

  /// 消費税
  int get vat => (income * 0.1).toInt();

  /// 消費税支払額
  int get vatPaid => (vat * vatRate * 0.01).toInt();

  /// 簡易課税率
  int get vatRate => 50;

  /// 手取り額
  int get netIncome => exIncome - totalTax;
  int get exNetIncome => exIncome - exTotalTax;

  /// 手取り差額
  int get netIncomeDiff => exNetIncome - netIncome;

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
