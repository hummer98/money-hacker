import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_hacker/pages/furusato_page.dart';
import 'package:money_hacker/pages/top_page.dart';
import 'package:money_hacker/pages/user_page.dart';

part 'app_router.freezed.dart';

class UserPagePath {
  const UserPagePath(this.uid);

  final String uid;
}

@freezed
class AppPage with _$AppPage {
  const factory AppPage.top([@Default('/') String name]) = _Top;
  const factory AppPage.furusato([@Default('/furusato') String name]) = _Furusato;
  const factory AppPage.user(UserPagePath path, [@Default('/user') String name]) = _User;
}

extension AppPageExtension on AppPage {
  static Widget pages(AppPage appPage) {
    return appPage.map(
      top: (_) => TopPage(),
      furusato: (_) => FurusatoPage(),
      user: (_user) => UserPage(uid: _user.path.uid),
    );
  }

  RouteSettings get routeSettings {
    // TODO: maybeWhenでdefaultパーサーを使う
    return maybeMap(
      user: (_user) => RouteSettings(name: '/user', arguments: _user),
      orElse: () => RouteSettings(name: name),
    );
  }

  static AppPage byRoute(RouteSettings settings) {
    // TODO: PATHINFOの場合 URIを適切にname & argumentsにパースする何か
    if (settings.name == '/') {
      return AppPage.top();
    }
    if (settings.name == '/furusato') {
      return AppPage.furusato();
    }
    if (settings.name == '/user') {
      return AppPage.user(settings.arguments as UserPagePath);
    }
    throw Exception(); // 404 Not Found?
  }
}

extension AppNavigator on Navigator {
  static Future pushPage(BuildContext context, {required AppPage appPage}) {
    return Navigator.push(context, AppRouter.byAppPage(appPage));
  }
}

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    final appPage = AppPageExtension.byRoute(routeSettings);
    return byAppPage(appPage);
  }

  static Route<T> byAppPage<T>(AppPage appPage) {
    final page = AppPageExtension.pages(appPage);
    // routeSettingsを書き換えたいときはAppPage.routeSettingsをオーバーライドすれば良い
    return PageRouteBuilder<T>(pageBuilder: (_, __, ___) => page, settings: appPage.routeSettings);
  }
}
