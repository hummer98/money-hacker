import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_hacker/myapp.dart';

Future<void> main() async {
  await FirebaseAuth.instance.signInAnonymously();
  runApp(MyApp());
}
