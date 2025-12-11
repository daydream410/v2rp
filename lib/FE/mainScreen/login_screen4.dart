// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_field, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/controller.dart';
import 'package:v2rp1/BE/reqip.dart';
import 'package:v2rp1/FE/mainScreen/otp_verification_screen.dart';

class LoginPage4 extends StatefulWidget {
  const LoginPage4({Key? key}) : super(key: key);

  @override
  State<LoginPage4> createState() => _LoginPage4State();
}

class _LoginPage4State extends State<LoginPage4>
    with SingleTickerProviderStateMixin {
  late AnimationController _animatedController;
  late Animation<double> _animation;

  bool _obsecuredText = true;
  static TextControllers textControllers = Get.put(TextControllers());
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _isLoading = false;
  Timer? _timer;

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
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isTablet = size.width > 600;
    double responsivePadding = isTablet ? 32.0 : 16.0;
    double logoHeight = size.height * 0.15;

    return WillPopScope(
      onWillPop: () async {
        if (_isLoading) return false;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit V2RP Mobile?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        if (shouldPop == true) {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // CachedNetworkImage(
            //   imageUrl:
            //       "https://cdn.discordapp.com/attachments/99335927377610308/1222481345507495976/vessel.png?ex=66165f79&is=6603ea79&hm=6a2164350471fb4518a6160ff8dd3ca0f0eeb583068e488f03915ab95e2c440f&",
            //   placeholder: (context, url) => Image.asset(
            //     'images/vessel.png',
            //     fit: BoxFit.fill,
            //   ),
            //   errorWidget: (context, url, error) => const Icon(Icons.error),
            //   height: double.infinity,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            //   alignment: FractionalOffset(_animation.value, 0),
            // ),
            Image.asset(
              'images/vessel.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: FractionalOffset(_animation.value, 0),
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
                      child: Image.asset('images/kctgroupasli.png'),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'V2RP MOBILE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 32.0 : 28.0,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: responsivePadding),
                      child: Text(
                        'Welcome back! Please login to continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet ? 18.0 : 16.0,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    AutofillGroup(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: textControllers.emailController.value,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                prefixIconColor: HexColor("#F4A62A"),
                                hintText: "Email",
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: HexColor("#F4A62A"),
                                    width: 2.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: isTablet ? 18.0 : 16.0,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                }
                                final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please Enter a Valid Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: isTablet ? 24.0 : 20.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              obscureText: _obsecuredText,
                              keyboardType: TextInputType.visiblePassword,
                              controller:
                                  textControllers.passwordController.value,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _handleLogin(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              autofillHints: const [AutofillHints.password],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.password_rounded),
                                prefixIconColor: HexColor("#F4A62A"),
                                hintText: "Password",
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obsecuredText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obsecuredText = !_obsecuredText;
                                    });
                                  },
                                ),
                                suffixIconColor: Colors.white70,
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: HexColor("#F4A62A"),
                                    width: 2.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: isTablet ? 18.0 : 16.0,
                                ),
                              ),
                              onEditingComplete: () =>
                                  TextInput.finishAutofillContext(),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 3) {
                                  return 'Please Enter a valid password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor("#F4A62A").withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: isTablet ? 60.0 : 50.0,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            disabledForegroundColor: Colors.white70,
                            disabledBackgroundColor:
                                HexColor("#F4A62A").withOpacity(0.5),
                            backgroundColor: HexColor("#F4A62A"),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.login_rounded,
                                      size: isTablet ? 24.0 : 20.0,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: isTablet ? 24.0 : 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simpan email dan password sementara (untuk resend OTP)
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString(
        'email',
        textControllers.emailController.value.text,
      );
      await sharedPreferences.setString(
        'password_temp',
        textControllers.passwordController.value.text,
      );

      // Proses login dengan await untuk menunggu response
      await MsgHeader.loginProcessNEW();

      // Cek hasil login
      final success = MsgHeader.success;

      if (success == true) {
        final email = sharedPreferences.getString('email') ?? '';

        if (mounted) {
          Get.snackbar(
            "Success",
            "Logged In As $email",
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

          // Clear form
          textControllers.emailController.value.clear();
          textControllers.passwordController.value.clear();

          // Navigate to OTP verification screen
          Get.offAll(const OtpVerificationScreen());
        }
      } else {
        if (mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Failed Login',
            text: 'Incorrect Email / Password',
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
              'Failed to connect to server. Please check your internet connection and try again.',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
      }
      print('Login error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        TextInput.finishAutofillContext();
      }
    }
  }
}
