import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:v2rp1/additional/webview/web_view_stack.dart';
import 'package:v2rp1/additional/webview/webview.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import '../navbar/navbar.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({Key? key}) : super(key: key);

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notification List"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Navbar()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 20.0, top: 15.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.90,
              width: MediaQuery.of(context).size.width * 1,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 90,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: const Text('Notif'),
                    subtitle: const Text('Sub Notif'),
                    onTap: () {
                      Get.to(const WebViewStack());
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
