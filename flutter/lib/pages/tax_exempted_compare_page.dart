import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:money_hacker/app_router.dart';
import 'package:money_hacker/models/income_tax.dart';
import 'package:money_hacker/models/tax_exempted_compare_page_state.dart';
import 'package:money_hacker/pages/common/app_scaffold.dart';
import 'package:money_hacker/utils/currency_value_accessor.dart';
import 'package:money_hacker/widgets/text_widgets.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uri/uri.dart';

class TaxExemptedCompareRoutePath with RoutePath {
  TaxExemptedCompareRoutePath({this.id});

  final String? id;

  factory TaxExemptedCompareRoutePath.fromJson(Map<String, dynamic> data) {
    return TaxExemptedCompareRoutePath(id: data['id']);
  }

  @override
  Map<String, dynamic> toArgument() => {'id': id};

  @override
  Widget generate() => TaxExemptedComparePage(path: this);

  @override
  RouteSettings get routeSettings => RouteSettings(name: UriTemplate('/taxExemptedCompare/{id}').expand(toArgument()));
}

class TaxExemptedComparePage extends HookWidget {
  const TaxExemptedComparePage({Key? key, required this.path}) : super(key: key);

  final TaxExemptedCompareRoutePath path;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        child: FutureBuilder<TaxExemptedComparePageState>(
      future: path.id == null
          ? Future.value(TaxExemptedComparePageState())
          : TaxExemptedComparePageStateExtension.read(path.id!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data!;
          return TaxExemptedCompareForm(state: state);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}

// フォームの初期値をFirestoreから取得するためにPageから遅延してフォームをロードする
class TaxExemptedCompareForm extends HookWidget {
  TaxExemptedCompareForm({
    Key? key,
    this.state = const TaxExemptedComparePageState(),
  })  : _form = _generateFormGroup(state),
        super(key: key);

  final FormGroup _form;

  final TaxExemptedComparePageState state;

  final double _defaultWidth = 160;

  static FormGroup _generateFormGroup(TaxExemptedComparePageState state) {
    // FIXME: 自動計算セクションは計算サービスのJSONから作るほうが早い?
    return FormGroup({
      'taxIncludedIncome': FormControl<int>(
        value: state.taxIncludedIncome,
        validators: [Validators.number, Validators.required],
      ),
      'taxIncludedExpenses': FormControl<int>(
        value: state.taxIncludedExpenses,
        validators: [Validators.number, Validators.required],
      ),
      'age': FormControl<int>(
        value: state.age,
        validators: [Validators.number, Validators.required],
      ),

      'baseRemoval': FormControl<int>(value: state.baseRemoval),

      /// 課税事業者

      'income': FormControl<int>(value: state.income),
      'taxableIncome': FormControl<int>(value: state.taxableIncome),
      'incomeTaxRate': FormControl<int>(value: state.incomeTaxRate.rate),
      'residentTax': FormControl<int>(
        value: state.residentTax,
      ),
      'incomeTax': FormControl<int>(value: state.incomeTax),
      'nationalHealthInsuranceTax': FormControl<int>(value: 0),
      'vatPaid': FormControl<int>(value: state.vatPaid),
      'vatRate': FormControl<int>(value: state.vatRate),
      'totalTax': FormControl<int>(value: state.totalTax),
      'netIncome': FormControl<int>(value: state.netIncome),
      'vatIncome': FormControl<int>(value: state.vatIncome),

      /// 免税事業者
      'ex-income': FormControl<int>(value: state.exIncome),
      'exTaxableIncome': FormControl<int>(value: state.exTaxableIncome),
      'ex-incomeTaxRate': FormControl<int>(
        value: state.exIncomeTaxRate.rate,
      ),
      'ex-residentTax': FormControl<int>(
        value: state.exResidentTax,
      ),
      'exIncomeTax': FormControl<int>(value: state.exIncomeTax),
      'ex-nationalHealthInsuranceTax': FormControl<int>(value: 0),
      'exNetIncome': FormControl<int>(value: state.exNetIncome),

      'exTotalTax': FormControl<int>(value: state.exTotalTax),
      'netIncomeDiff': FormControl<int>(value: state.netIncomeDiff),
    });
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _form.valueChanges.listen((e) {
        final state = TaxExemptedComparePageState.fromJson(e!);
        _form.control('residentTax').updateValue(state.residentTax);
        _form.control('ex-residentTax').updateValue(state.exResidentTax);

        _form.control('income').updateValue(state.income);
        _form.control('ex-income').updateValue(state.exIncome);

        _form.control('taxableIncome').updateValue(state.taxableIncome);
        _form.control('exTaxableIncome').updateValue(state.exTaxableIncome);

        _form.control('incomeTaxRate').updateValue(state.incomeTaxRate.rate);
        _form.control('ex-incomeTaxRate').updateValue(state.exIncomeTaxRate.rate);

        _form.control('incomeTax').updateValue(state.incomeTax);
        _form.control('exIncomeTax').updateValue(state.exIncomeTax);

        _form.control('totalTax').updateValue(state.totalTax);
        _form.control('exTotalTax').updateValue(state.exTotalTax);

        _form.control('netIncome').updateValue(state.netIncome);
        _form.control('exNetIncome').updateValue(state.exNetIncome);

        _form.control('vatRate').updateValue(state.vatRate);
        _form.control('vatPaid').updateValue(state.vatPaid);
        _form.control('vatIncome').updateValue(state.vatIncome);
        _form.control('netIncomeDiff').updateValue(state.netIncomeDiff);
      });
    }, []);

    return ReactiveForm(
      formGroup: _form,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Headline1('免税事業者 と 課税事業者比較'),
            )),
            _inputRow(label: '税込み収入', child: _buildCurrencyTextField('taxIncludedIncome')),
            _inputRow(label: '税込み経費', child: _buildCurrencyTextField('taxIncludedExpenses')),
            _inputRow(label: '年齢', child: _buildCurrencyTextField('age', unitLabel: '歳'), inputWidth: 80),
            _inputRow(label: '基礎控除', child: _buildCurrencyTextField('baseRemoval', readOnly: true)),
            SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildTaxable()),
                SizedBox(width: 64),
                Expanded(child: _buildTaxExempt()),
              ],
            ),
            SizedBox(height: 64),
            _inputRow(
              label: '手取り差額',
              child: _buildCurrencyTextField('netIncomeDiff', readOnly: true),
              inputWidth: _defaultWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxExempt() {
    return Column(
      children: [
        Headline5('免税事業者'),
        SizedBox(height: 8),
        _inputRow(label: '所得', child: _buildCurrencyTextField('ex-income', readOnly: true), inputWidth: _defaultWidth),
        _inputRow(
            label: '課税所得',
            child: _buildCurrencyTextField('exTaxableIncome', readOnly: true),
            inputWidth: _defaultWidth),
        _inputRow(
            label: '所得税率',
            child: _buildCurrencyTextField('ex-incomeTaxRate', readOnly: true, unitLabel: '%'),
            inputWidth: _defaultWidth),
        _inputRow(
            label: '所得税', child: _buildCurrencyTextField('exIncomeTax', readOnly: true), inputWidth: _defaultWidth),
        _inputRow(
            label: '住民税', child: _buildCurrencyTextField('ex-residentTax', readOnly: true), inputWidth: _defaultWidth),
        _inputRow(
            label: '国民健康保険税',
            child: _buildCurrencyTextField('ex-nationalHealthInsuranceTax', readOnly: true),
            inputWidth: _defaultWidth),
        SizedBox(height: 48),
        SizedBox(height: 32),
        _inputRow(
            label: '租税合計', child: _buildCurrencyTextField('exTotalTax', readOnly: true), inputWidth: _defaultWidth),
        _inputRow(
            label: '手取り額', child: _buildCurrencyTextField('exNetIncome', readOnly: true), inputWidth: _defaultWidth),
      ],
    );
  }

  Widget _buildTaxable() {
    return Column(
      children: [
        Headline5('課税事業者'),
        SizedBox(height: 8),
        _inputRow(label: '所得', child: _buildCurrencyTextField('income', readOnly: true), inputWidth: _defaultWidth),
        _inputRow(
            label: '課税所得', child: _buildCurrencyTextField('taxableIncome', readOnly: true), inputWidth: _defaultWidth),
        _inputRow(
            label: '所得税率',
            child: _buildCurrencyTextField('incomeTaxRate', readOnly: true, unitLabel: '%'),
            inputWidth: _defaultWidth),
        _inputRow(label: '所得税', child: _buildCurrencyTextField('incomeTax', readOnly: true), inputWidth: _defaultWidth),
        _inputRow(
            label: '住民税', child: _buildCurrencyTextField('residentTax', readOnly: true), inputWidth: _defaultWidth),
        _inputRow(
            label: '国民健康保険税',
            child: _buildCurrencyTextField('nationalHealthInsuranceTax', readOnly: true),
            inputWidth: _defaultWidth),
        _inputRow(
            label: '消費税支払額', child: _buildCurrencyTextField('vatPaid', readOnly: true), inputWidth: _defaultWidth),
        SizedBox(height: 32),
        _inputRow(label: '租税合計', child: _buildCurrencyTextField('totalTax', readOnly: true), inputWidth: _defaultWidth),
        // _inputRow(label: '消費税益税', child: _buildCurrencyTextField('vatIncome', readOnly: true), inputWidth: _defaultWidth),
        _inputRow(
            label: '手取り額', child: _buildCurrencyTextField('netIncome', readOnly: true), inputWidth: _defaultWidth),
      ],
    );
  }

  Widget _inputRow({required String label, required Widget child, double inputWidth = 200}) {
    return Row(
      children: [
        Headline6(label),
        Spacer(),
        Container(
          width: inputWidth,
          child: child,
        ),
      ],
    );
  }

  Widget _buildCurrencyTextField(String name, {String? label, bool readOnly = false, String unitLabel = '円'}) {
    return ReactiveTextField<num>(
      formControlName: name,
      textAlign: TextAlign.end,
      valueAccessor: CurrencyValueAccessor(),
      inputFormatters: [ThousandsFormatter()],
      readOnly: readOnly,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        hintText: label,
        suffix: UnitLabel(unitLabel),
        fillColor: readOnly ? Color(0xFFBBBBBB) : Colors.white,
        filled: true,
      ),
    );
  }
}
