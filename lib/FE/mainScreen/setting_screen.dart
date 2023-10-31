// import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:upgrader/upgrader.dart';
// import 'package:url_launcher/url_launcher.dart';
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
                  height: 15.0,
                ),
                const Text(
                  "Versi : 1.2.3 ",
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
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
                const SizedBox(
                  height: 20,
                ),
                // TextButton(
                //   style: TextButton.styleFrom(
                //     foregroundColor: HexColor("#F4A62A"),
                //   ),
                //   onPressed: () async {
                //     // QuickAlert.show(
                //     //   context: context,
                //     //   type: QuickAlertType.info,
                //     //   title: 'Checking App Version...',
                //     //   barrierDismissible: false,
                //     //   customAsset: 'images/loading.gif',
                //     //   headerBackgroundColor: HexColor("#F4A62A"),
                //     //   confirmBtnColor: HexColor("#F4A62A"),
                //     // );
                //     // Future.delayed(const Duration(seconds: 3), () {
                //     //   _checkUpdate();
                //     // });
                //     UpgradeCard(
                //         upgrader: Upgrader(
                //       durationUntilAlertAgain: const Duration(seconds: 5),
                //       dialogStyle: Platform.isIOS
                //           ? UpgradeDialogStyle.cupertino
                //           : UpgradeDialogStyle.material,
                //       debugDisplayAlways: true,
                //       showIgnore: false,
                //       showLater: false,
                //       canDismissDialog: true,
                //     ));
                //   },
                //   child: const Text(
                //     "CHECK UPDATE",
                //     style: TextStyle(
                //       fontSize: 20,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _checkUpdate() async {
  //   var versionApp = '1.2.1';

  //   if (versionApp != '1.2.2') {
  //     if (Platform.isAndroid) {
  //       QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.info,
  //         title: 'New Version Is Available',
  //         text: 'Please Download Our Latest App Version.',
  //         barrierDismissible: false,
  //         disableBackBtn: true,
  //         headerBackgroundColor: HexColor("#F4A62A"),
  //         confirmBtnText: 'Download',
  //         onConfirmBtnTap: () async {
  //           final Uri url = Uri.parse(
  //               'https://drive.google.com/drive/folders/1Xa4MAJi5Ia12x2i1K-R7DzY6Ypv1Co4M?usp=sharing');
  //           if (!await launchUrl(url)) {
  //             throw Exception('Could not launch $url');
  //           }
  //         },
  //       );
  //     } else if (Platform.isIOS) {
  //       QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.info,
  //         title: 'New Version Is Available',
  //         text: 'Please Update Our Latest App Version in App Store.',
  //         barrierDismissible: false,
  //         disableBackBtn: true,
  //         headerBackgroundColor: HexColor("#F4A62A"),
  //         confirmBtnText: 'Update',
  //         onConfirmBtnTap: () async {
  //           final Uri url = Uri.parse(
  //               'https://apps.apple.com/us/app/v2rp-mobile/id1668962103');
  //           if (!await launchUrl(url)) {
  //             throw Exception('Could not launch $url');
  //           }
  //         },
  //       );
  //     }
  //   } else {
  //     QuickAlert.show(
  //       context: context,
  //       type: QuickAlertType.error,
  //       title: 'No update available!',
  //       barrierDismissible: false,
  //       disableBackBtn: true,
  //       headerBackgroundColor: HexColor("#F4A62A"),
  //     );
  //   }
  // }

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
