import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.child,
    this.scaffoldKey,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.maxWidth = 768,
    this.minWidth = 320,
  }) : super(key: key);

  final Widget child;
  final double maxWidth;
  final double minWidth;
  final Key? scaffoldKey;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      key: scaffoldKey,
      backgroundColor: Color(0xFFDDDDDD),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth, minWidth: minWidth),
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
