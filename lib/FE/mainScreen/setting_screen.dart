import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/mainScreen/login_screen4.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are You sure?'),
            content: const Text('Do you want to exit the App?'),
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
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onDoubleTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('User List'),
                            content: setupAlertDialoadContainer(),
                          );
                        });
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
                const Text(
                  // "$finalUsername",
                  "Hai",
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.teal,
                  ),
                  onPressed: () async {
                    // final SharedPreferences sharedPreferences =
                    //     await SharedPreferences.getInstance();
                    // sharedPreferences.remove('username');
                    // // sharedPreferences.remove('conve');
                    // // sharedPreferences.remove('trxid');
                    // // sharedPreferences.remove('datetime');
                    // sharedPreferences.remove('password');
                    // await sharedPreferences.clear();

                    Get.offAll(() => const LoginPage4());
                  },
                  child: const Text("LOGOUT"),
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
            title: const Text('vindo3'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
