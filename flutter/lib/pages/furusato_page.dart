import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:money_hacker/models/income_tax.dart';
import 'package:money_hacker/pages/common/app_scaffold.dart';
import 'package:money_hacker/services/hometown_tax_service.dart';
import 'package:money_hacker/widgets/text_widgets.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FurusatoPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final form = FormGroup({
    'incomeTaxRate': FormControl<int>(value: 0),
    'residentTaxAmount': FormControl<int>(
      value: 0,
      // TODO: number
      //  _formatのValidatorが必要
      validators: [Validators.required],
    ),
    'limitOfHometownTaxAmount': FormControl<int>(value: 0),
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: ReactiveForm(
        formGroup: form,
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Headline1('ふるさと納税'),
              _inputRow(label: '所得税率', child: _incomeTaxField(context, 'incomeTaxRate'), inputWidth: 100),
              _inputRow(label: '住民税均等割額', child: _residentTaxAmountField('residentTaxAmount')),
              SizedBox(height: 64),
              _inputRow(
                label: 'ふるさと納税限度額',
                child: StreamBuilder<dynamic>(
                    stream: form.valueChanges,
                    builder: (context, snapshot) {
                      debugPrint('rebuild! $snapshot');
                      if (!form.valid) {
                        return Text('-');
                      }
                      final incomeTaxRate = form.value['incomeTaxRate'] as int;
                      final residentTaxAmount = form.value['residentTaxAmount'] as int;
                      final l = HometownTaxService.limitOfHometownTaxAmount(incomeTaxRate, residentTaxAmount);
                      return Text('${NumberFormat('#,##0', 'ja_JP').format(l)}');
                    }),
              ),
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
    return ReactiveTextField<int>(
      formControlName: name,
      textAlign: TextAlign.end,
      // TODO
      valueAccessor: IntValueAccessor(),
      // inputFormatters: [ThousandsFormatter()],
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        hintText: '住民税均等割額',
        suffix: UnitLabel('円'),
      ),
    );
  }

  Widget _incomeTaxField(BuildContext context, String name) {
    return ReactiveDropdownField<int>(
      formControlName: name,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        hintText: '所得税率',
      ),
      items: IncomeTax.rates
          .map((i) => DropdownMenuItem(
                value: i.rate,
                child: Text('${i.rate}%', textAlign: TextAlign.end),
              ))
          .toList(),
    );
  }
}
