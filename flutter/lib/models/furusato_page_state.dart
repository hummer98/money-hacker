import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_hacker/services/hometown_tax_service.dart';

part 'furusato_page_state.freezed.dart';
part 'furusato_page_state.g.dart';

@freezed
class FurusatoPageState with _$FurusatoPageState {
  const factory FurusatoPageState({
    @Default(0) int incomeTaxRate,
    @Default(0) residentTaxAmount,
  }) = _FurusatoPageState;

  factory FurusatoPageState.fromJson(Map<String, dynamic> json) => _$FurusatoPageStateFromJson(json);
}

extension FurusatoPageStateExtension on FurusatoPageState {
  double get rawRate => incomeTaxRate * 0.01;

  int get limitOfHometownTaxAmount => HometownTaxService.limitOfHometownTaxAmount(incomeTaxRate, residentTaxAmount);
}
