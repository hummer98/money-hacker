import 'package:flutter_test/flutter_test.dart';
import 'package:money_hacker/services/hometown_tax_service.dart';

void main() {
  test('limitOfHometownTaxAmount', () {
    expect(HometownTaxService.limitOfHometownTaxAmount(23, 1000000), 302675);
  });

  test('FurusatoControlAmounts', () {
    final f = FurusatoControlAmounts.withHometownTaxAmount(incomeTaxRate: 23, hometownTaxAmount: 304000);
    expect(f.incomeTax, 70918);
    expect(f.residentTax, 30200);
    expect(f.residentTaxAtSpecial, 200881);
  });
}
