import 'package:flutter/material.dart';
import 'package:uni_trade/bindings/general_bindings.dart';
import 'package:uni_trade/utils/features/authentication/screens/login/login.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // inilialize firebase

  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      home: const LoginScreen(), // Use the LoginScreen widget from login.dart
    );
  }
}
