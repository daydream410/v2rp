// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_field, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/reqip.dart';
import 'package:v2rp1/FE/mainScreen/choose_role_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animatedController;
  late Animation<double> _animation;

  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Timer? _countdownTimer;
  int _countdown = 180; // 3 menit dalam detik

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
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _animatedController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String _formatCountdown(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length != 6) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Invalid OTP',
        text: 'Please enter 6-digit OTP',
        barrierDismissible: true,
        confirmBtnColor: HexColor("#F4A62A"),
      );
      return;
    }

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? seckey = prefs.getString('seckey');

      if (seckey == null) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Session expired. Please login again.',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
        Get.offAllNamed('/Login');
        return;
      }

      await MsgHeader.verifyOtp(seckey, otp);

      if (MsgHeader.otpSuccess == true) {
        if (mounted) {
          // Hapus password sementara setelah OTP berhasil diverifikasi
          await prefs.remove('password_temp');

          Get.snackbar(
            "Success",
            "OTP verified successfully",
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

          // Navigate to choose role screen
          Get.offAll(const ChooseRoleScreen());
        }
      } else {
        if (mounted) {
          // Display message from "data" field if available, otherwise use message or fallback
          String errorMessage = '';

          // Debug: Print values to check
          print('otpData: ${MsgHeader.otpData}');
          print('otpMessage: ${MsgHeader.otpMessage}');

          // Priority: otpData (from "data" field) > otpMessage (from "message" field) > default
          if (MsgHeader.otpData != null &&
              MsgHeader.otpData.toString().trim().isNotEmpty) {
            errorMessage = MsgHeader.otpData.toString().trim();
          } else if (MsgHeader.otpMessage != null &&
              MsgHeader.otpMessage.toString().trim().isNotEmpty) {
            errorMessage = MsgHeader.otpMessage.toString().trim();
          } else {
            errorMessage = 'Invalid OTP. Please try again.';
          }

          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Verification Failed',
            text: errorMessage,
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
              'Failed to verify OTP. Please check your internet connection and try again.',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
      }
      print('OTP verification error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOtp() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? email = prefs.getString('email');
      final String? password = prefs.getString('password_temp');

      if (email == null || password == null) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Session expired. Please login again.',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
        Get.offAllNamed('/Login');
        return;
      }

      await MsgHeader.resendOtp(email, password);

      if (MsgHeader.resendOtpSuccess == true) {
        if (mounted) {
          // Reset countdown
          setState(() {
            _countdown = 180;
          });
          _startCountdown();

          // Clear OTP fields
          for (var controller in _otpControllers) {
            controller.clear();
          }
          _focusNodes[0].requestFocus();

          Get.snackbar(
            "Success",
            "OTP has been resent to your email / Telegram",
            colorText: Colors.white,
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            isDismissible: true,
            dismissDirection: DismissDirection.vertical,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        if (mounted) {
          String errorMessage = MsgHeader.resendOtpMessage.isNotEmpty
              ? MsgHeader.resendOtpMessage
              : 'Failed to resend OTP. Please try again.';

          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Resend Failed',
            text: errorMessage,
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
              'Failed to resend OTP. Please check your internet connection and try again.',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
      }
      print('Resend OTP error: $e');
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
    double logoHeight = size.height * 0.15;
    double titleFontSize = isTablet ? 32.0 : 24.0;
    double subtitleFontSize = isTablet ? 18.0 : 16.0;
    double otpFieldSize =
        isTablet ? 60.0 : (size.width * 0.12).clamp(40.0, 55.0);
    double otpFontSize = isTablet ? 28.0 : 22.0;

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
                  // Clear seckey when going back
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.remove('seckey');
                  });
                  // Navigate back to login screen
                  Get.offAllNamed('/Login');
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
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: responsivePadding),
              child: ListView(
                children: [
                  SizedBox(height: size.height * 0.05),
                  SizedBox(
                    height: logoHeight.clamp(100.0, 200.0),
                    child: Image.asset('images/v2rpLogo.png'),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified_user,
                        color: HexColor("#F4A62A"),
                        size: isTablet ? 36.0 : 32.0,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'OTP Verification',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: responsivePadding),
                    child: Text(
                      'Enter the 6-digit code sent to your email',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: subtitleFontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            isTablet ? size.width * 0.2 : responsivePadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return Container(
                          width: otpFieldSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: otpFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: HexColor("#F4A62A"),
                                  width: 2.5,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: isTablet ? 16.0 : 12.0,
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) => _onOtpChanged(index, value),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  if (_countdown > 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsivePadding,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white70,
                            size: isTablet ? 20.0 : 18.0,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Resend OTP in ${_formatCountdown(_countdown)}',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isTablet ? 16.0 : 14.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      height: isTablet ? 60.0 : 50.0,
                      child: TextButton.icon(
                        onPressed: _isLoading ? null : _resendOtp,
                        icon: _isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: isTablet ? 20.0 : 18.0,
                              ),
                        label: Text(
                          'Resend OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 18.0 : 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          backgroundColor: Colors.white.withOpacity(0.15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: size.height * 0.04),
                  SizedBox(
                    width: double.infinity,
                    height: isTablet ? 60.0 : 50.0,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        disabledForegroundColor: Colors.white70,
                        disabledBackgroundColor:
                            HexColor("#F4A62A").withOpacity(0.5),
                        backgroundColor: HexColor("#F4A62A"),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Verify',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 24.0 : 20.0,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
