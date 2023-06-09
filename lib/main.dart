// ignore_for_file: unrelated_type_equality_checks, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v2rp1/FE/mainScreen/login_screen4.dart';
import 'additional/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String? finalUsername;

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'V2RP',
      initialRoute: '/',
      routes: {
        '/Login': (context) => const LoginPage4(),
        // '/Second': (context) => const SecondScreen()
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

//test github baru