import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:money_hacker/app_router.dart';
import 'package:money_hacker/models/furusato_page_state.dart';
import 'package:money_hacker/models/income_tax.dart';
import 'package:money_hacker/pages/common/app_scaffold.dart';
import 'package:money_hacker/utils/currency_value_accessor.dart';
import 'package:money_hacker/widgets/text_widgets.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uri/uri.dart';

class FurusatoRoutePath with RoutePath {
  FurusatoRoutePath({this.id});

  final String? id;

  factory FurusatoRoutePath.fromJson(Map<String, dynamic> data) {
    return FurusatoRoutePath(id: data['id']);
  }

  @override
  Map<String, dynamic> toArgument() => {'id': id};

  @override
  RouteSettings get routeSettings => RouteSettings(name: UriTemplate('/furusato/{id}').expand(toArgument()));

  @override
  Widget generate() => FurusatoPage();
}

class FurusatoPage extends HookWidget {
  FurusatoPage({Key? key, this.state = const FurusatoPageState()})
      : form = _generateFormGroup(state),
        super(key: key);

  final FormGroup form;

  final FurusatoPageState state;

  static FormGroup _generateFormGroup(FurusatoPageState state) {
    return FormGroup({
      'incomeTaxRate': FormControl<int>(
        value: state.incomeTaxRate,
      ),
      'residentTaxAmount': FormControl<num>(
        value: state.residentTaxAmount,
        validators: [Validators.number, Validators.required],
      ),
      'limitOfHometownTaxAmount': FormControl<int>(
        value: state.limitOfHometownTaxAmount,
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      form.valueChanges.listen((e) {
        final state = FurusatoPageState.fromJson(e!);
        form.control('limitOfHometownTaxAmount').updateValue(state.limitOfHometownTaxAmount);
      });
    }, []);

    return AppScaffold(
      child: ReactiveForm(
        formGroup: form,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Headline1('ふるさと納税'),
              _inputRow(label: '所得税率', child: _incomeTaxField(context, 'incomeTaxRate'), inputWidth: 100),
              _inputRow(label: '住民税均等割額', child: _residentTaxAmountField('residentTaxAmount')),
              SizedBox(height: 64),
              _inputRow(label: 'ふるさと納税限度額', child: _buildLimit('limitOfHometownTaxAmount')),
            ],
          ),
        ),
      ),
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

  Widget _residentTaxAmountField(String name) {
    return ReactiveTextField<num>(
      formControlName: name,
      textAlign: TextAlign.end,
      valueAccessor: CurrencyValueAccessor(),
      inputFormatters: [ThousandsFormatter()],
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        hintText: '住民税所得割額',
        suffix: UnitLabel('円'),
      ),
    );
  }

  Widget _incomeTaxField(BuildContext context, String name) {
    return ReactiveDropdownField<int>(
      formControlName: name,
      isExpanded: true,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        hintText: '所得税率',
        suffix: UnitLabel('%'),
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

  Widget _buildLimit(String name) {
    return ReactiveTextField(
      formControlName: name,
      textAlign: TextAlign.end,
      valueAccessor: CurrencyValueAccessor(),
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        suffix: UnitLabel('円'),
      ),
    );
  }
}
