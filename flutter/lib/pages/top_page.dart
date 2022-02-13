import 'package:flutter/material.dart';
import 'package:money_hacker/app_router.dart';
import 'package:money_hacker/pages/common/app_scaffold.dart';
import 'package:money_hacker/pages/furusato_page.dart';
import 'package:money_hacker/pages/tax_exempted_compare_page.dart';

class TopRoutePath with RoutePath {
  @override
  Widget generate() => TopPage();

  @override
  RouteSettings get routeSettings => RouteSettings(name: '/');

  @override
  Map<String, dynamic> toArgument() => {};
}

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Text('MONEY HACKER'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => AppNavigator.pushPath(context, path: FurusatoRoutePath()),
              child: Text('ふるさと納税'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => AppNavigator.pushPath(context, path: TaxExemptedCompareRoutePath()),
              child: Text('消費税免税事業者<->課税事業者の比較'),
            ),
          ),
        ],
      ),
    );
  }
}
