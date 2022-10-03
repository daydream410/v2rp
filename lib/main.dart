// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:v2rp1/FE/mainScreen/login_screen4.dart';

import 'additional/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//hai test aja
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
      // AnimatedSplashScreen.withScreenFunction(
      //   duration: 3000,
      //   splash: 'images/kctgroupasli.png',
      //   screenFunction: () async {
      //     //--------------------------------------------------------
      // Future getValidationData() async {
      //   final SharedPreferences sharedPreferences =
      //       await SharedPreferences.getInstance();
      //   var obtainUsername = sharedPreferences.getString('username');
      //   finalUsername = obtainUsername;
      //   print(finalUsername);
      // }

      //     return finalUsername == null ? const LoginPage4() : const Navbar();
      //   },
      //   // nextScreen: const LoginPage4(),
      //   splashTransition: SplashTransition.scaleTransition,
      //   backgroundColor: Colors.white,
      //   pageTransitionType: PageTransitionType.fade,
      // ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
