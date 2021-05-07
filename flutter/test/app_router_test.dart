import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_hacker/app_router.dart';
import 'package:money_hacker/pages/tax_exempted_compare_page.dart';
import 'package:money_hacker/pages/top_page.dart';
import 'package:money_hacker/pages/user_page.dart';
import 'package:uri/uri.dart';

void main() {
  test('user match', () {
    final parser = UriParser(UriTemplate('/user/{uid}'));
    final uri = Uri.parse('/user/1');
    expect(parser.matches(uri), true);
    expect(parser.parse(uri), {'uid': '1'});
  });

  test('user match', () {
    final parser = UriParser(UriTemplate('/user'));
    final uri = Uri.parse('/user');
    expect(parser.matches(uri), true);
    expect(parser.parse(uri), {});
  });

  test('standard route path', () {
    expect(AppRouter.parse('/') is TopRoutePath, true);
    expect(AppRouter.parse('/taxExemptedCompare') is TaxExemptedCompareRoutePath, true);
  });

  test('taxExemptedCompare/1', () {
    final routePath = AppRouter.parse('/taxExemptedCompare/1');
    expect(routePath is TaxExemptedCompareRoutePath, true);
    expect(routePath.toArgument(), {'id': '1'});
  });

  test('user/1', () {
    final routePath = AppRouter.parse('/user/1');
    expect(routePath is UserRoutePath, true);
    expect(routePath.toArgument(), {'uid': '1'});
  });

  test('revert /user/abc', () {
    final routePath = UserRoutePath('abc');
    expect(routePath.routeSettings.name, '/user/abc');
  });

  test('revert /', () {
    final routePath = TopRoutePath();
    expect(routePath.routeSettings.name, '/');
  });

  test('revert /taxExemptedCompare', () {
    final routePath = TaxExemptedCompareRoutePath();
    expect(routePath.routeSettings.name, '/taxExemptedCompare/');
  });

  test('revert /taxExemptedCompare/abc', () {
    final routePath = TaxExemptedCompareRoutePath(id: 'abc');
    expect(routePath.routeSettings.name, '/taxExemptedCompare/abc');
  });
}
