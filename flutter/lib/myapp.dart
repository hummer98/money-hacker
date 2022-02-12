import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:money_hacker/app_router.dart';
import 'package:money_hacker/app_theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MONEY HACKER',
      theme: AppTheme.theme,
      initialRoute: '/',
      onGenerateRoute: AppRouter.onGenerateRoute,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
    );
  }
}
