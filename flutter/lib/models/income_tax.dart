import 'package:collection/collection.dart';

// 所得税のモデル
// List<String> 課税所得範囲 : 税率 : 控除額の早見表リスト
// List<int> 税率の一覧
// (int) -> int 課税所得 -> 税額の計算

int floor(int value, int floorValue) {
  assert(floorValue != 0);
  return (value ~/ floorValue) * floorValue;
}

class IncomeTaxRate {
  const IncomeTaxRate(this.rate, this.min, this.max, this.controlAmount);

  final int rate;
  final int? min;
  final int? max;

  /// 控除額
  final int controlAmount;

  double get rawRate => rate * 0.01;

  bool match(int taxableIncome) {
    final value = floor(taxableIncome, 1000);
    if (min == null) {
      return value < max!;
    }
    if (max == null) {
      return value >= min!;
    }
    return min! <= value && max! >= value;
  }

  int? tax(int taxableIncome) {
    return match(taxableIncome) ? (floor(taxableIncome, 1000) * rawRate).toInt() - controlAmount : null;
  }

  int? taxWithSpecial(taxableIncome) {
    if (match(taxableIncome)) {
      final taxAmount = (floor(taxableIncome, 1000) * rawRate).toInt() - controlAmount;
      // 復興特別所得税(所得税の2.1%)を加算する
      return floor(taxAmount + (taxAmount * 0.021).toInt(), 100);
    } else {
      return null;
    }
  }
}

class IncomeTax {
  /// 所得税
  static int taxAmount(int taxableIncome) {
    if (taxableIncome < 0) {
      return 0;
    }
    for (final rate in rates) {
      final value = rate.tax(taxableIncome);
      if (value == null) continue;
      return value;
    }
    throw Exception();
  }

  /// 復興特別税込みの所得税
  static int taxAmountWithSpecial(int taxableIncome) {
    if (taxableIncome < 0) {
      return 0;
    }
    for (final rate in rates) {
      final value = rate.taxWithSpecial(taxableIncome);
      if (value == null) continue;
      return value;
    }
    throw Exception();
  }

  /// 所得税率
  static IncomeTaxRate withIncome(int income) {
    return rates.firstWhereOrNull((element) => element.match(income))!;
  }

  ///
  static IncomeTaxRate? withTaxRate(int taxRate) {
    return rates.firstWhereOrNull((e) => e.rate == taxRate);
  }

  static List<IncomeTaxRate> get rates => [
        IncomeTaxRate(0, null, 1000, 0),
        IncomeTaxRate(5, 1000, 1949000, 0),
        IncomeTaxRate(10, 1950000, 3299000, 97500),
        IncomeTaxRate(20, 3300000, 6949000, 427500),
        IncomeTaxRate(23, 6950000, 89990000, 636000),
        IncomeTaxRate(33, 9000000, 17999000, 1536000),
        IncomeTaxRate(40, 18000000, 39999000, 2796000),
        IncomeTaxRate(45, 40000000, null, 4796000),
      ];
}
