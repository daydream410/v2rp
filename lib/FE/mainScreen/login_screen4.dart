// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_field, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/controller.dart';
import 'package:v2rp1/BE/reqip.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
// import 'package:uuid/uuid.dart';

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

  // static var userVal = textControllers.usernameController.value.text;
  // static var passVal = textControllers.passwordController.value.text;
  static var responseCodeResult;
  static var _timer;
  late bool _isButtonDisabled;

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animatedController =
        // AnimationController(vsync: this, duration: const Duration(20));
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animatedController, curve: Curves.linear)
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
    MsgHeader.Reqip();
    _isButtonDisabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are u sure?'),
            content: Text('Do you want to exit V2RP Mobile?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
              ),
            ],
          ),
        );
        throw (e);
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://media.discordapp.net/attachments/957575427784855554/966553053832568852/vessel.png",
              placeholder: (context, url) => Image.asset(
                'images/vessel.png',
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: FractionalOffset(_animation.value, 0),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    SizedBox(
                      height: 150,
                      child: Image.asset('images/kctgroupasli.png'),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: textControllers.emailController.value,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        prefixIconColor: HexColor("#F4A62A"),
                        hintText: "Email",
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: textControllers.usernameController.value,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        prefixIconColor: HexColor("#F4A62A"),
                        hintText: "Username",
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (String) {
                        _timer = Timer(const Duration(milliseconds: 1000), (() {
                          MsgHeader.Reqip();
                        }));
                      },
                      obscureText: _obsecuredText,
                      controller: textControllers.passwordController.value,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password_rounded),
                        prefixIconColor: HexColor("#F4A62A"),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obsecuredText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obsecuredText = !_obsecuredText;
                            });
                          },
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          // setState(() {
                          // _passwordController.clear();
                          // });
                          return 'Please Enter a valid password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      onPressed: () async {
                        // _isButtonDisabled ? null : convertProcess();
                        // _timer = Timer(const Duration(milliseconds: 3000), (() {
                        //   convertProcess();
                        // }));
                        Get.to(Navbar()); //sementara aja
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: HexColor("#F4A62A"),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
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

  Future<void> convertProcess() async {
    setState(() {
      _isButtonDisabled = true;
    });
    String? finalUsername;
    String? finalPassowrd;
    // final SharedPreferences sharedPreferences =
    //     await SharedPreferences.getInstance();
    // var obtainUsername = sharedPreferences.getString('username');
    // var obtainPassword = sharedPreferences.getString('password');
    // setState(() {
    //   finalUsername = obtainUsername;
    //   finalPassowrd = obtainPassword;
    // });

    print("final pw ==== " + finalPassowrd.toString());
    print("final usn ==== " + finalUsername.toString());

    String? userVal =
        finalUsername ?? textControllers.usernameController.value.text;
    String? passVal =
        finalPassowrd ?? textControllers.passwordController.value.text;

    MsgHeader.convi(userVal, passVal);
    MsgHeader.Login(userVal, passVal);
    loginProcess(
        responseCodeResult, MsgHeader.ipResult, MsgHeader.messageResult);
  }

  Future<void> loginProcess(responseCodeResult, ipResult, messageResult) async {
    var loginResult = MsgHeader.responseCodeResult;
    var messageRes = MsgHeader.messageResult;
    // final SharedPreferences sharedPreferences =
    //     await SharedPreferences.getInstance();
    // sharedPreferences.setString(
    //     'username', textControllers.usernameController.value.text);
    // sharedPreferences.setString(
    //     'password', textControllers.passwordController.value.text);
    // sharedPreferences.setString('conve', MsgHeader.conve);

    try {
      if (_formKey.currentState!.validate()) {
        if (loginResult.toString() == '{00}') {
          Get.snackbar(
            "$messageRes",
            "",
            colorText: Colors.white,
            icon: Icon(Icons.check),
            backgroundColor: Colors.green,
            isDismissible: true,
            dismissDirection: DismissDirection.vertical,
          );

          // Get.to(() => Navbar());
          Get.offAll(const Navbar());
          setState(() {
            textControllers.passwordController.value.clear();
          });
        } else if (loginResult == null) {
          Get.snackbar(
            "Please Wait",
            "Connecting To Server...",
            colorText: Colors.white,
            icon: Icon(
              Icons.timer,
              color: Colors.white,
            ),
            backgroundColor: HexColor("#F4A62A"),
            isDismissible: true,
            duration: Duration(seconds: 2),
            dismissDirection: DismissDirection.vertical,
          );
        } else if (loginResult.toString() == '{05}') {
          Get.snackbar(
            "$messageRes",
            "",
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
            isDismissible: true,
            dismissDirection: DismissDirection.vertical,
          );
          // _timer = Timer(Duration(seconds: 3), (() {
          //   SystemNavigator.pop();
          // }));
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
