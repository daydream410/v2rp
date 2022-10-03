// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

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

  static String? finalUsername;
  // static String? finalIp;
  static String? finalConve;
  static String? finalTrx;
  static String? finalTime;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'images/v2rp.mp4',
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
              finalUsername == null ? const LoginPage4() : const Navbar()));
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainUsername = sharedPreferences.getString('username');
    // var obtainIp = sharedPreferences.getString('ip');
    var obtainConve = sharedPreferences.getString('conve');
    var obtainTrx = sharedPreferences.getString('trxid');
    var obtainTime = sharedPreferences.getString('datetime');

    setState(() {
      finalUsername = obtainUsername;
      // finalIp = obtainIp;
      finalConve = obtainConve;
      finalTrx = obtainTrx;
      finalTime = obtainTime;
    });
    print(finalUsername);
    print(finalTime);
    print(finalConve);
    print(finalTrx);
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
