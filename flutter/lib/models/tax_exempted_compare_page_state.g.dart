// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_exempted_compare_page_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaxExemptedComparePageState _$_$_TaxExemptedComparePageStateFromJson(
    Map json) {
  return _$_TaxExemptedComparePageState(
    id: json['id'] as String?,
    taxIncludedIncome: json['taxIncludedIncome'] as int? ?? 7000000,
    taxIncludedExpenses: json['taxIncludedExpenses'] as int? ?? 0,
    age: json['age'] as int? ?? 35,
  );
}

Map<String, dynamic> _$_$_TaxExemptedComparePageStateToJson(
        _$_TaxExemptedComparePageState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taxIncludedIncome': instance.taxIncludedIncome,
      'taxIncludedExpenses': instance.taxIncludedExpenses,
      'age': instance.age,
    };
