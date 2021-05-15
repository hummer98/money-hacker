// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_exempted_compare_page_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaxExemptedComparePageState _$_$_TaxExemptedComparePageStateFromJson(Map json) {
  return _$_TaxExemptedComparePageState(
    id: json['id'] as String?,
    taxIncludedIncome: json['taxIncludedIncome'] as int? ?? 10000000,
    taxIncludedExpenses: json['taxIncludedExpenses'] as int? ?? 0,
    amountOfSocialInsurancePremiums: json['amountOfSocialInsurancePremiums'] as int? ?? 0,
    otherRemoval: json['otherRemoval'] as int? ?? 0,
    age: json['age'] as int? ?? 35,
    typeOfDeclaration:
        _$enumDecodeNullable(_$TypeOfDeclarationEnumMap, json['typeOfDeclaration']) ?? TypeOfDeclaration.blue65,
  );
}

Map<String, dynamic> _$_$_TaxExemptedComparePageStateToJson(_$_TaxExemptedComparePageState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taxIncludedIncome': instance.taxIncludedIncome,
      'taxIncludedExpenses': instance.taxIncludedExpenses,
      'amountOfSocialInsurancePremiums': instance.amountOfSocialInsurancePremiums,
      'otherRemoval': instance.otherRemoval,
      'age': instance.age,
      'typeOfDeclaration': _$TypeOfDeclarationEnumMap[instance.typeOfDeclaration],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source || EnumToString.convertToString(source) == e.value,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$TypeOfDeclarationEnumMap = {
  TypeOfDeclaration.white: 'white',
  TypeOfDeclaration.blue10: 'blue10',
  TypeOfDeclaration.blue55: 'blue55',
  TypeOfDeclaration.blue65: 'blue65',
};
