// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/mainScreen/login_screen4.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;

  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _loadingFadeAnimation;

  static String? finalEmail;
  static String? finalUsername;
  static String? finalPassword;
  static String? finalKulonuwun;
  static String? finalMonggo;

  @override
  void initState() {
    super.initState();

    // Logo Animation Controller - smooth entrance
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Fade Controller for sequential animations
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Logo Fade & Scale Animations - smooth and professional
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    // Text fade animation
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    // Loading fade animation
    _loadingFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    // Start animations sequentially
    _logoController.forward().then((_) {
      _fadeController.forward();
    });

    // Get validation data and navigate
    getValidationData().whenComplete(() async {
      Timer(
        const Duration(seconds: 3),
        () => Get.to(
          finalKulonuwun == null ? const LoginPage4() : const Navbar(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    var obtainUsername = sharedPreferences.getString('username');
    var obtainPassword = sharedPreferences.getString('password');
    var obtainKulonuwun = sharedPreferences.getString('kulonuwun');
    var obtainMonggo = sharedPreferences.getString('monggo');

    setState(() {
      finalEmail = obtainEmail;
      finalUsername = obtainUsername;
      finalPassword = obtainPassword;
      finalKulonuwun = obtainKulonuwun;
      finalMonggo = obtainMonggo;
    });
    print(finalEmail);
    print(finalUsername);
    print(finalPassword);
    print(finalKulonuwun);
    print(finalMonggo);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HexColor("#F4A62A"), // Primary orange/amber color
              HexColor("#F4A62A").withOpacity(0.9), // Slightly lighter
              HexColor("#F4A62A").withOpacity(0.8), // Even lighter
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with smooth animations
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _logoFadeAnimation,
                      child: ScaleTransition(
                        scale: _logoScaleAnimation,
                        child: Container(
                          width: isTablet ? 200 : 160,
                          height: isTablet ? 200 : 160,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 40,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'images/v2rpLogo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: isTablet ? 48 : 32),

                // App name with fade animation
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _textFadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'V2RP MOBILE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 36 : 28,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: 80,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: isTablet ? 64 : 48),

                // Modern loading indicator
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _loadingFadeAnimation,
                      child: SizedBox(
                        width: isTablet ? 48 : 40,
                        height: isTablet ? 48 : 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          backgroundColor: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
