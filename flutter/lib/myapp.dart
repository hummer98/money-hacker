import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_hacker/app_router.dart';
import 'package:money_hacker/app_theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontFamily: 'Noto Sans JP'),
      child: MaterialApp(
        title: 'MONEY HACKER',
        theme: AppTheme.theme,
        initialRoute: '/',
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
