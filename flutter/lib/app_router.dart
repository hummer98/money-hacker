import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_router.freezed.dart';

@freezed
abstract class AppPage with _$AppPage {
  const factory AppPage.top() = _Top;
  const factory AppPage.furusato() = _Furusato;

  factory AppPage.fromJson(Map<String, dynamic> json) => _$AppPageFromJson(json);
}

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    Widget page = Scaffold();
    RouteSettings settings = routeSettings;
    switch (routeSettings.name) {
      case '/':
        break;
    }
    return PageRouteBuilder(pageBuilder: (_, __, ___) => page, settings: settings);
  }
}
