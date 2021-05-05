import 'package:flutter/material.dart';
import 'package:money_hacker/app_router.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.from(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
      ),
      // textTheme: _textTheme(),
    );
    return MaterialApp(
      title: 'MONEY HACKER',
      theme: theme,
      initialRoute: '/',
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
