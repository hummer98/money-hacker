import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_hacker/pages/furusato_page.dart';
import 'package:money_hacker/pages/tax_exempted_compare_page.dart';
import 'package:money_hacker/pages/top_page.dart';
import 'package:money_hacker/pages/user_page.dart';
import 'package:uri/uri.dart';

extension AppNavigator on Navigator {
  static Future<T?> pushPath<T>(BuildContext context, {required RoutePath path}) {
    return Navigator.push(context, path.route<T>());
  }
}

class AppRouter {
  // RouteSettings -> Route

  static RoutePath parse(String name) {
    final templates = <String, RoutePath Function(Map<String, dynamic>)>{
      '/user/{uid}': (data) => UserRoutePath(data['uid']),
      '/furusato/{id}': (data) => FurusatoRoutePath.fromJson(data),
      '/furusato': (data) => FurusatoRoutePath.fromJson(data),
      '/taxExemptedCompare/{id}': (data) => TaxExemptedCompareRoutePath(id: data['id']),
      '/taxExemptedCompare': (data) => TaxExemptedCompareRoutePath(),
      '/': (_) => TopRoutePath(),
    };

    final pair = templates.entries.firstWhereOrNull((templates) => match(templates.key, name));
    if (pair == null) {
      throw Exception(); // 404 Not Found
    }
    return pair.value(params(pair.key, name));
  }

  static Route onGenerateRoute(RouteSettings routeSettings) {
    return parse(routeSettings.name!).route();
  }

  static bool match(String template, String uriString) {
    final uri = Uri.parse(uriString);
    final parser = UriParser(UriTemplate(template));
    return parser.matches(uri);
  }

  static Map<String, String?> params(String template, String uriString) {
    final uri = Uri.parse(uriString);
    final parser = UriParser(UriTemplate(template));
    final match = parser.match(uri);
    return match!.parameters;
  }
}

// やりたきこと
// * URIをRoute<T>にしたい
//   Route<T> onGenerateRoute(RouteSettings)
// PATHINFO -> RouteSettingsで来るので, Route<T> onGenerateRoute(RouteSettings)
// PathInfoParserは一箇所に集約する(探索順序がわかりやすいように)
// * Typed Navigationしたい
//   Future<T?> pushPage<T>(AppPage)
// * AppPageをRouteにしたい -> AppPageをRouteSettings.name & argumentsにしたい
//   Route<T> AppPage.route()

/// RouteSettings -> RoutePathはAppRouteの責務
mixin RoutePath {
  RouteSettings get routeSettings;

  Widget generate();

  Map<String, dynamic> toArgument();

  Route<T> route<T>() {
    return PageRouteBuilder<T>(pageBuilder: (_, __, ___) => generate(), settings: routeSettings);
  }
}

// class DynamicRoutePath with RoutePath {
//   DynamicRoutePath({required this.name, required this.generate});
//
//   final Widget Function() generate;
//
//   final String name;
//
//   @override
//   Widget _generate() {
//     return generate();
//   }
//
//   @override
//   // TODO: implement routeSettings
//   RouteSettings get routeSettings => throw UnimplementedError();
// }
