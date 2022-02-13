import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.child,
    this.scaffoldKey,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    required this.title,
  }) : super(key: key);

  final Widget child;
  final Key? scaffoldKey;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      key: scaffoldKey,
      backgroundColor: Color(0xFFDDDDDD),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: child,
    );
  }
}
