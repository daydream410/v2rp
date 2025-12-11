// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_field, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/reqip.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:v2rp1/FE/mainScreen/otp_verification_screen.dart';
import 'package:v2rp1/main.dart' show getAndSaveFcmToken;

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({Key? key}) : super(key: key);

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animatedController;
  late Animation<double> _animation;

  bool _isLoading = false;
  List<Map<String, dynamic>> _roles = [];

  @override
  void initState() {
    super.initState();
    _animatedController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animation = CurvedAnimation(
      parent: _animatedController,
      curve: Curves.linear,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          _animatedController.reset();
          _animatedController.forward();
        }
      });
    _animatedController.forward();
    _loadRoles();
  }

  Future<void> _loadRoles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? rolesJson = prefs.getString('otp_roles');

    if (rolesJson != null) {
      try {
        var decoded = jsonDecode(rolesJson);
        if (decoded is List) {
          setState(() {
            _roles = List<Map<String, dynamic>>.from(
                decoded.map((role) => role as Map<String, dynamic>));
          });
        }
      } catch (e) {
        print('Error loading roles: $e');
      }
    }

    // Also try to get from MsgHeader if available
    if (_roles.isEmpty && MsgHeader.rolesData != null) {
      try {
        if (MsgHeader.rolesData is List) {
          setState(() {
            _roles = List<Map<String, dynamic>>.from(
                (MsgHeader.rolesData as List)
                    .map((role) => role as Map<String, dynamic>));
          });
        }
      } catch (e) {
        print('Error loading roles from MsgHeader: $e');
      }
    }
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  Future<void> _chooseRole(Map<String, dynamic> role) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fcmToken = prefs.getString('fcm_token');

      // If FCM token is not available, get it first
      if (fcmToken == null || fcmToken.isEmpty) {
        fcmToken = await getAndSaveFcmToken();
      }

      String seckey = role['seckey'] ?? '';

      // Get platform dynamically
      String platform = Platform.isAndroid ? 'android' : 'ios';

      await MsgHeader.chooseRole(
        seckey,
        fcmToken ?? '',
        platform,
      );

      if (MsgHeader.roleSuccess == true) {
        // Save kulonuwun and monggo
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('kulonuwun', MsgHeader.kulonuwun ?? '');
        await prefs.setString('monggo', MsgHeader.monggo ?? '');

        if (mounted) {
          Get.snackbar(
            "Success",
            "Role selected successfully",
            colorText: Colors.white,
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            isDismissible: true,
            dismissDirection: DismissDirection.vertical,
            duration: const Duration(seconds: 2),
          );

          // Navigate to main screen
          Get.offAll(const Navbar());
        }
      } else {
        if (mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Failed',
            text: MsgHeader.roleMessage ??
                'Failed to select role. Please try again.',
            barrierDismissible: true,
            confirmBtnColor: HexColor("#F4A62A"),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Connection Error',
          text:
              'Failed to select role. Please check your internet connection and try again.',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
      }
      print('Choose role error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isTablet = size.width > 600;
    double responsivePadding = isTablet ? 32.0 : 16.0;
    double logoHeight = size.height * 0.20;
    double titleFontSize = isTablet ? 32.0 : 24.0;
    double subtitleFontSize = isTablet ? 18.0 : 16.0;
    double maxCardWidth = isTablet ? 600.0 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset(
            'images/vessel.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          SafeArea(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Navigate back to OTP verification screen
                  Get.offAll(const OtpVerificationScreen());
                },
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: isTablet ? 28.0 : 24.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsivePadding),
            child: ListView(
              children: [
                SizedBox(height: size.height * 0.05),
                SizedBox(
                  height: logoHeight.clamp(150.0, 280.0),
                  child: Image.asset('images/v2rpLogo.png'),
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.badge,
                      color: HexColor("#F4A62A"),
                      size: isTablet ? 36.0 : 32.0,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Choose Role',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.015),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: responsivePadding),
                  child: Text(
                    'Select your role to continue',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: subtitleFontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                if (_roles.isEmpty)
                  Container(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Loading roles...',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: subtitleFontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ..._roles.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> role = entry.value;
                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxCardWidth),
                        child: Padding(
                          padding:
                              EdgeInsets.only(bottom: isTablet ? 20.0 : 16.0),
                          child: Card(
                            color: Colors.white.withOpacity(0.95),
                            elevation: 6,
                            shadowColor: Colors.black.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: HexColor("#F4A62A").withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:
                                    _isLoading ? null : () => _chooseRole(role),
                                borderRadius: BorderRadius.circular(16),
                                splashColor:
                                    HexColor("#F4A62A").withOpacity(0.1),
                                highlightColor:
                                    HexColor("#F4A62A").withOpacity(0.05),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0.95),
                                      ],
                                    ),
                                  ),
                                  padding:
                                      EdgeInsets.all(isTablet ? 24.0 : 20.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: isTablet ? 60.0 : 50.0,
                                        height: isTablet ? 60.0 : 50.0,
                                        decoration: BoxDecoration(
                                          color: HexColor("#F4A62A")
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          Icons.business_center,
                                          color: HexColor("#F4A62A"),
                                          size: isTablet ? 32.0 : 28.0,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              role['role'] ?? '',
                                              style: TextStyle(
                                                fontSize:
                                                    isTablet ? 22.0 : 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: HexColor("#F4A62A"),
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              role['companyname'] ?? '',
                                              style: TextStyle(
                                                fontSize:
                                                    isTablet ? 17.0 : 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.domain,
                                                  size: 14,
                                                  color: Colors.black54,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  role['company'] ?? '',
                                                  style: TextStyle(
                                                    fontSize:
                                                        isTablet ? 15.0 : 13.0,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: HexColor("#F4A62A"),
                                        size: isTablet ? 24.0 : 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
