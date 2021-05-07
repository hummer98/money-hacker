import 'package:flutter/material.dart';
import 'package:money_hacker/app_router.dart';
import 'package:uri/uri.dart';

class UserRoutePath with RoutePath {
  UserRoutePath(this.uid);

  final String uid;

  @override
  Map<String, dynamic> toArgument() => {'uid': uid};

  @override
  RouteSettings get routeSettings => RouteSettings(name: UriTemplate('/user/{uid}').expand(toArgument()));

  @override
  Widget generate() => UserPage(uid: uid);
}

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserPage'),
      ),
      body: Container(),
    );
  }
}
