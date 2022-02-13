import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CurrencyValueAccessor extends ControlValueAccessor<num, String> {
  final formatter = NumberFormat('#,###', 'ja_JP');

  @override
  String? modelToViewValue(num? modelValue) {
    return modelValue == null ? '' : formatter.format(modelValue);
  }

  @override
  num? viewToModelValue(String? viewValue) {
    try {
      return formatter.parse(viewValue!);
    } catch (e) {
      return 0;
    }
  }
}
