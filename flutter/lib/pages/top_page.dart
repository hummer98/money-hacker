import 'package:flutter/material.dart';
import 'package:money_hacker/app_router.dart';
import 'package:money_hacker/pages/common/app_scaffold.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Container(
        child: ElevatedButton(
          onPressed: () {
            AppNavigator.pushPage(context, appPage: AppPage.furusato());
          },
          child: Text('ふるさと納税'),
        ),
      ),
    );
  }
}
