import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_hacker/myapp.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());

  await FirebaseAuth.instance.signInAnonymously();
  runApp(MyApp());
}
