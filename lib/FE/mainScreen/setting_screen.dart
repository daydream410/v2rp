import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/mainScreen/login_screen4.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? finalEmail = '';
  String? finalUsername = '';

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are You sure?'),
            content: const Text('Do you want to exit V2RP Mobile?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        throw (e);
      },
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: [
                InkWell(
                  onDoubleTap: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         title: const Text('Company List'),
                    //         content: setupAlertDialoadContainer(),
                    //       );
                    //     });
                  },
                  borderRadius: BorderRadius.circular(100),
                  splashColor: HexColor('#F4A62A').withOpacity(0.5),
                  child: Ink(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/pp.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  "$finalEmail ",
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  "$finalUsername ",
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.remove('username');
                    sharedPreferences.remove('email');
                    sharedPreferences.remove('password');
                    sharedPreferences.remove('kulonuwun');
                    sharedPreferences.remove('monggo');
                    await sharedPreferences.clear();

                    Get.offAll(() => const LoginPage4());
                    Get.snackbar(
                      "Success Logout",
                      "From V2RP Mobile",
                      colorText: Colors.white,
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.red,
                      isDismissible: true,
                      dismissDirection: DismissDirection.vertical,
                    );
                  },
                  child: const Text(
                    "LOGOUT",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return SizedBox(
      height: 200.0, // Change as per your requirement
      width: 200.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: const Text('test'),
            onTap: () {},
          );
        },
      ),
    );
  }

  Future getEmail() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      finalEmail = sharedPreferences.getString('email');
      finalUsername = sharedPreferences.getString('username');
    });
  }
}
