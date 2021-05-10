import 'dart:math';

/// 地方自治体別の設定
class LocalAuthority {
  const LocalAuthority(
    this.name, {
    required this.nationalHealthInsuranceData,
    this.updateYear,
  });

  final String name;
  final NationalHealthInsuranceData nationalHealthInsuranceData;
  final int? updateYear;
}

/// 国民健康保険料データ
class NationalHealthInsuranceData {
  const NationalHealthInsuranceData({
    required this.base,
    required this.support,
    required this.care,
  });

  final NationalHealthInsuranceSection base;
  final NationalHealthInsuranceSection support;
  final NationalHealthInsuranceSection care;

  /// 課税所得を元に国民健康保険税を算出する
  int amountOfTax(int taxableIncome, int age) {
    if (age >= 40 && 65 > age) {
      return base.amountOfTax(taxableIncome) + support.amountOfTax(taxableIncome) + care.amountOfTax(taxableIncome);
    } else {
      return base.amountOfTax(taxableIncome) + support.amountOfTax(taxableIncome);
    }
  }
}

const nakanoAuthority = LocalAuthority(
  '中野区',
  nationalHealthInsuranceData: NationalHealthInsuranceData(
    base: NationalHealthInsuranceSection(36600, 7.13, 630000),
    support: NationalHealthInsuranceSection(12000, 2.41, 190000),
    care: NationalHealthInsuranceSection(18600, 2.18, 170000),
  ),
  updateYear: 2021,
);

/// 国民健康保険料区分毎データ
class NationalHealthInsuranceSection {
  const NationalHealthInsuranceSection(this.capitation, this.incomeBasedLevyTaxRate, this.limit);

  /// 均等割額
  final int capitation;

  /// 所得割額の率
  final double incomeBasedLevyTaxRate;

  /// 最高限度額
  final int limit;

  int amountOfTax(int taxableIncome) {
    return min(limit, (taxableIncome * incomeBasedLevyTaxRate * 0.01 + capitation).toInt());
  }
}

/// 国民健康保険料の計算クラス
class NationalHealthInsuranceService {
  NationalHealthInsuranceService({this.localAuthority = nakanoAuthority});

  final LocalAuthority localAuthority;

  int amountOfTax(int taxableIncome, int age) =>
      localAuthority.nationalHealthInsuranceData.amountOfTax(taxableIncome, age);
}
