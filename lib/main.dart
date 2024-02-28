import 'package:flutter/material.dart';
import 'package:uni_trade/utils/features/authentication/screens/login/login.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: LoginScreen(), // Use the LoginScreen widget from login.dart
    );
  }
}
