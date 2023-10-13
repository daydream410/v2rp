// ignore_for_file: avoid_print

import 'dart:async';
// import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/mainScreen/login_screen4.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  static String? finalEmail;
  static String? finalUsername;
  static String? finalPassword;

  static String? finalKulonuwun;
  static String? finalMonggo;
  // static String? finalTime;
  // late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   print("New connectivity status: $result");
    // });
    _controller = VideoPlayerController.asset(
      'images/newsplash.mp4',
    )
      ..initialize().then((value) {
        setState(() {});
      })
      ..setVolume(0.0);

    _playVideo();

    getValidationData().whenComplete(() async {
      Timer(
          const Duration(seconds: 3),
          () => Get.to(
              finalKulonuwun == null ? const LoginPage4() : const Navbar()));
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   subscription.cancel();
  // }

  // void checkStatus() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     print("connected to a mobile network");
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     print("connected to a wifi network");
  //   }
  // }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    var obtainUsername = sharedPreferences.getString('username');
    var obtainPassword = sharedPreferences.getString('password');
    var obtainKulonuwun = sharedPreferences.getString('kulonuwun');
    var obtainMonggo = sharedPreferences.getString('monggo');
    // // var obtainTime = sharedPreferences.getString('datetime');

    setState(() {
      finalEmail = obtainEmail;
      finalUsername = obtainUsername;
      finalPassword = obtainPassword;
      finalKulonuwun = obtainKulonuwun;
      finalMonggo = obtainMonggo;
      // finalTime = obtainTime;
    });
    print(finalEmail);
    print(finalUsername);
    print(finalPassword);
    print(finalKulonuwun);
    print(finalMonggo);
    // print(finalTrx);
  }

  void _playVideo() async {
    _controller.play();

    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ));
  }
}
