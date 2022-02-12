// ふるさと納税の計算ロジッククラス

class FurusatoControlAmounts {
  FurusatoControlAmounts({required this.incomeTax, required this.residentTax, required this.residentTaxAtSpecial});

  /// ふるさと納税額から、所得税、住民税基本分、住民税得例分のそれぞれの金額を算出する
  factory FurusatoControlAmounts.withHometownTaxAmount({required int incomeTaxRate, required int hometownTaxAmount}) {
    final h = hometownTaxAmount - 2000;
    final i = incomeTaxRate * 1.021;
    return FurusatoControlAmounts(
      incomeTax: (h * i * 0.01).toInt(),
      residentTax: (h * 0.1).toInt(),
      residentTaxAtSpecial: (h * (100 - 10 - i) * 0.01).toInt(),
    );
  }

  final int incomeTax;
  final int residentTax;
  final int residentTaxAtSpecial;
}

// Input
// 住民税均等割額
// 所得税率
class HometownTaxService {
  /// 所得税率と住民税所得割額より、ふるさと納税の上限額を求めるアルゴリズム
  static int limitOfHometownTaxAmount(int incomeTaxRate, int residentTaxAmount) {
    final specialLimit = residentTaxAmount * 0.2;
    final incomeTaxRateWithSpecial = incomeTaxRate * 1.021;
    return specialLimit ~/ ((100 - 10 - incomeTaxRateWithSpecial) * 0.01) + 2000;
  }
}
