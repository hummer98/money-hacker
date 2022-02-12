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
    return FormGroup({
      'taxIncludedIncome': FormControl<int>(
        value: state.taxIncludedIncome,
        validators: [Validators.number, Validators.required],
      ),
      'taxIncludedExpenses': FormControl<int>(
        value: state.taxIncludedExpenses,
        validators: [Validators.number, Validators.required],
      ),
      'otherRemoval': FormControl<int>(
        value: state.otherRemoval,
        validators: [Validators.number, Validators.required],
      ),
      'amountOfSocialInsurancePremiums': FormControl<int>(
        value: state.amountOfSocialInsurancePremiums,
        validators: [Validators.number, Validators.required],
      ),
      'typeOfDeclaration': FormControl<TypeOfDeclaration>(
        value: state.typeOfDeclaration,
        validators: [Validators.required],
      ),
      'typeOfDeclarationAmount': FormControl<int>(
        value: state.typeOfDeclaration.removal,
      ),
      'age': FormControl<int>(
        value: state.age,
        validators: [Validators.number, Validators.required],
      ),

      'baseRemoval': FormControl<int>(value: state.baseRemoval),

      'declarationRemoval': FormControl<int>(value: state.declarationRemoval),

      /// 課税事業者

      'income': FormControl<int>(value: state.income),
      'taxableIncome': FormControl<int>(value: state.taxableIncome),
      'incomeTaxRate': FormControl<int>(value: state.incomeTaxRate.rate),
      'residentTax': FormControl<int>(
        value: state.residentTax,
      ),
      'incomeTax': FormControl<int>(value: state.incomeTax),
      'nationalHealthInsuranceTax': FormControl<int>(value: state.nationalHealthInsuranceTax),
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
      'exNationalHealthInsuranceTax': FormControl<int>(value: state.exNationalHealthInsuranceTax),
      'exNetIncome': FormControl<int>(value: state.exNetIncome),

      'exTotalTax': FormControl<int>(value: state.exTotalTax),
      'netIncomeDiff': FormControl<int>(value: state.netIncomeDiff),
    });
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _form.valueChanges.listen((e) {
        try {
          final state = TaxExemptedComparePageState.fromJson(e!);
          _form.control('typeOfDeclarationAmount').updateValue(state.typeOfDeclaration.removal);

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

          _form.control('nationalHealthInsuranceTax').updateValue(state.nationalHealthInsuranceTax);
          _form.control('exNationalHealthInsuranceTax').updateValue(state.exNationalHealthInsuranceTax);

          _form.control('totalTax').updateValue(state.totalTax);
          _form.control('exTotalTax').updateValue(state.exTotalTax);

          _form.control('netIncome').updateValue(state.netIncome);
          _form.control('exNetIncome').updateValue(state.exNetIncome);

          _form.control('vatRate').updateValue(state.vatRate);
          _form.control('vatPaid').updateValue(state.vatPaid);
          _form.control('vatIncome').updateValue(state.vatIncome);
          _form.control('netIncomeDiff').updateValue(state.netIncomeDiff);
        } catch (e) {
          debugPrint('$e');
        }
      });
      return;
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
              child: Headline1('免税事業者 と 課税事業者の税額を比較'),
            )),
            _inputRow(
              label: '年齢',
              child: _buildCurrencyTextField('age', unitLabel: '歳'),
              inputWidth: 80,
              tooltip: '40歳以上だと介護保険料が加算されます。',
            ),
            _inputRow(
              label: '税込事業収入',
              child: _buildCurrencyTextField('taxIncludedIncome'),
              tooltip: '免税事業者の方は確定申告書Bの(ア)の欄を入力します。課税事業者の方は(ア)を1.1倍した金額を入力します。実際の銀行への入金額を入力と等しくなります。',
            ),
            _inputRow(
              label: '税込経費',
              child: _buildCurrencyTextField('taxIncludedExpenses'),
              tooltip: '青色申告決算書の(32)を入力します。青色申告特別控除額を含まない金額を入力してください',
            ),
            _inputRow(
              label: '社会保険料控除',
              child: _buildCurrencyTextField('amountOfSocialInsurancePremiums'),
              tooltip: '確定申告書Bの(13)を入力します',
            ),
            _inputRow(
              label: 'その他控除',
              child: _buildCurrencyTextField('otherRemoval'),
              tooltip:
                  '確定申告書Bの(14)〜(23)と(28)の合計を入力します。医療費控除・生命保険料控除・寄付金控除(ふるさと納税)・確定拠出年金(iDeco)・小規模企業共済の掛金・経営セーフティネット共済の掛金が含まれます',
            ),
            _inputRow(label: '青色申告控除', child: _buildCurrencyTextField('typeOfDeclarationAmount', readOnly: true)),
            SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildTaxExempt()),
                SizedBox(width: 64),
                Expanded(child: _buildTaxable()),
              ],
            ),
            SizedBox(height: 64),
            _inputRow(
              label: '課税所得者になったときの差額',
              child: _buildCurrencyTextField('netIncomeDiff', readOnly: true),
              inputWidth: _defaultWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  '注意事項: すべての入力値はブラウザ上で計算され、サーバー等に送信されることはありません。',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
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
        _inputRow(
            label: '事業所得',
            child: _buildCurrencyTextField(
              'ex-income',
              readOnly: true,
            ),
            tooltip: '= 税込事業収入 - 税込経費 - 申告種別による控除',
            inputWidth: _defaultWidth),
        _inputRow(
            label: '課税所得',
            child: _buildCurrencyTextField('exTaxableIncome', readOnly: true),
            inputWidth: _defaultWidth),
        SizedBox(height: 24),
        _inputRow(
            label: '所得税',
            child: _buildCurrencyTextField(
              'exIncomeTax',
              readOnly: true,
              prefix: ReactiveFormField<int, int>(
                formControlName: 'incomeTaxRate',
                builder: (state) => Tooltip(
                  message: '所得税率',
                  child: UnitLabel('${state.value}%'),
                ),
              ),
            ),
            inputWidth: _defaultWidth),
        _inputRow(
          label: '住民税',
          child: _buildCurrencyTextField('ex-residentTax', readOnly: true),
          inputWidth: _defaultWidth,
        ),
        _inputRow(
            label: '国民健康保険税',
            child: _buildCurrencyTextField('exNationalHealthInsuranceTax', readOnly: true),
            inputWidth: _defaultWidth),
        SizedBox(height: 48),
        SizedBox(height: 16),
        _inputRow(
            label: '租税合計', child: _buildCurrencyTextField('exTotalTax', readOnly: true), inputWidth: _defaultWidth),
        SizedBox(height: 16),
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
        _inputRow(
            label: '事業所得',
            child: _buildCurrencyTextField('income', readOnly: true),
            tooltip: '= (税込事業収入 - 税込経費)/1.1 - 申告種別による控除\n ※消費税分は減算して計算',
            inputWidth: _defaultWidth),
        _inputRow(
          label: '課税所得',
          child: _buildCurrencyTextField('taxableIncome', readOnly: true),
          inputWidth: _defaultWidth,
          tooltip: '実際に課税される所得です。\n\n課税所得 = 所得 - 社会保険料控除 - その他控除 - 基礎控除',
        ),
        SizedBox(height: 24),
        _inputRow(
          label: '所得税',
          child: _buildCurrencyTextField(
            'incomeTax',
            readOnly: true,
            prefix: ReactiveFormField<int, int>(
              formControlName: 'incomeTaxRate',
              builder: (state) => Tooltip(
                message: '所得税率',
                child: UnitLabel('${state.value}%'),
              ),
            ),
          ),
          inputWidth: _defaultWidth,
          tooltip: '左の%が所得税率。 所得税額 = 課税所得 * 所得税率 * 102.1%(復興特別加算税2.1%)',
        ),
        _inputRow(
          label: '住民税',
          child: _buildCurrencyTextField('residentTax', readOnly: true),
          inputWidth: _defaultWidth,
          tooltip: '基礎控除を43万円にしただけの簡易計算です。ふるさと納税の減額分については考慮されません。市区町村によっては1000円程度上下します。',
        ),
        _inputRow(
          label: '国民健康保険税',
          child: _buildCurrencyTextField('nationalHealthInsuranceTax', readOnly: true),
          inputWidth: _defaultWidth,
          tooltip: '市区町村によって若干上下します。この計算のモデルは東京都中野区です',
        ),
        _inputRow(
          label: '消費税支払額',
          child: _buildCurrencyTextField(
            'vatPaid',
            readOnly: true,
            prefix: ReactiveFormField<int, int>(
              formControlName: 'vatRate',
              builder: (state) => Tooltip(
                message: '簡易課税率',
                child: UnitLabel('${state.value}%'),
              ),
            ),
          ),
          inputWidth: _defaultWidth,
          tooltip: '簡易課税事業者第5種として50%の簡易課税率として計算します',
        ),
        SizedBox(height: 16),
        _inputRow(label: '租税合計', child: _buildCurrencyTextField('totalTax', readOnly: true), inputWidth: _defaultWidth),
        // _inputRow(label: '消費税益税', child: _buildCurrencyTextField('vatIncome', readOnly: true), inputWidth: _defaultWidth),
        SizedBox(height: 16),
        _inputRow(
            label: '手取り額', child: _buildCurrencyTextField('netIncome', readOnly: true), inputWidth: _defaultWidth),
      ],
    );
  }

  Widget _inputRow({required String label, required Widget child, double inputWidth = 200, String? tooltip}) {
    return Row(
      children: [
        Headline6(label),
        if (tooltip != null)
          Tooltip(
            height: 40,
            message: tooltip,
            child: Icon(Icons.info, color: Colors.blueGrey),
          ),
        Spacer(),
        Container(
          width: inputWidth,
          child: child,
        ),
      ],
    );
  }

  Widget _buildCurrencyTextField(String name,
      {String? label, bool readOnly = false, String unitLabel = '円', Widget? prefix}) {
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
        prefix: prefix,
        suffix: UnitLabel(unitLabel),
        fillColor: readOnly ? Color(0xFFBBBBBB) : Colors.white,
        filled: true,
      ),
    );
  }

  Widget _declarationRemovalField(String name) {
    return ReactiveDropdownField<int>(
      formControlName: name,
      isExpanded: true,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
      ),
      items: IncomeTax.rates
          .map(
            (i) => DropdownMenuItem(
              value: i.rate,
              child: Align(alignment: Alignment.centerRight, child: Text('${i.rate}')),
            ),
          )
          .toList(),
    );
  }
}
