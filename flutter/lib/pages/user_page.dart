import 'package:flutter/material.dart';

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
