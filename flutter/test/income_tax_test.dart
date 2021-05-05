import 'package:flutter_test/flutter_test.dart';
import 'package:money_hacker/models/income_tax.dart';

void main() {
  test('floor test', () {
    expect(floor(0, 10), 0);
    expect(floor(12345, 10), 12340);
    expect(floor(12345, 1000), 12000);
  });

  test('income tax', () {
    expect(IncomeTax.taxAmount(-10000), 0);
    expect(IncomeTax.taxAmount(0), 0);
    expect(IncomeTax.taxAmount(1950000), 97500);
    expect(IncomeTax.taxAmount(5164000), 605300);
    expect(IncomeTax.taxAmount(5580000), 688500);
    expect(IncomeTax.taxAmount(7496000), 1088080);
  });

  test('income tax with special', () {
    expect(IncomeTax.taxAmountWithSpecial(-10000), 0);
    expect(IncomeTax.taxAmountWithSpecial(0), 0);
    expect(IncomeTax.taxAmountWithSpecial(1950000), 99500);
    expect(IncomeTax.taxAmountWithSpecial(5164000), 618000);
    expect(IncomeTax.taxAmountWithSpecial(5580000), 702900);
    expect(IncomeTax.taxAmountWithSpecial(7496000), 1110900);
  });
}
