import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_hacker/app_router.dart';
import 'package:money_hacker/app_theme.dart';

class MyApp extends StatelessWidget {
  final locale = const Locale('ja', 'JP');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MONEY HACKER',
      theme: AppTheme.theme,
      initialRoute: '/',
      locale: locale,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [locale],
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
