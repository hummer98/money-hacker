import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_hacker/pages/furusato_page.dart';
import 'package:money_hacker/pages/top_page.dart';

part 'app_router.freezed.dart';

@freezed
class AppPage with _$AppPage {
  const factory AppPage.top() = _Top;
  const factory AppPage.furusato() = _Furusato;
}

extension AppPageExtension on AppPage {
  static Widget pages(AppPage appPage) {
    return appPage.map(
      top: (_) => TopPage(),
      furusato: (_) => FurusatoPage(),
    );
  }

  static AppPage byRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return AppPage.top();
    }
    if (settings.name == '/furusato') {
      return AppPage.furusato();
    }
    throw Exception(); // 404 Not Found?
  }
}

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    // TODO: routeSettings.nameのオーバーライド機構がほしいところ
    final appPage = AppPageExtension.byRoute(routeSettings);
    final page = AppPageExtension.pages(appPage);
    return PageRouteBuilder(pageBuilder: (_, __, ___) => page, settings: routeSettings);
  }
}
