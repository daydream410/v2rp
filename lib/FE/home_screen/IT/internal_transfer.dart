// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/home_screen/IT/internal_transfer2.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:v2rp1/additional/list_MU.dart';

import '../../../BE/controller.dart';
// import '../../additional/filter.dart';

class InternalTransfer extends StatefulWidget {
  const InternalTransfer({Key? key}) : super(key: key);

  @override
  State<InternalTransfer> createState() => _InternalTransferState();
}

class _InternalTransferState extends State<InternalTransfer> {
  // final controller = TextEditingController();
  static TextControllers textControllers = Get.put(TextControllers());

  List<ListMU> muList = allListMU;

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
          title: const Text("Internal Transfer"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(Navbar());
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Internal Transfer List",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),

                      // TextButton(
                      //   onPressed: () {
                      //     showDialog(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return const FilterData(
                      //             reload: 'Reload',
                      //           );
                      //         });
                      //   },
                      //   child: Text(
                      //     'Filter',
                      //     style: TextStyle(
                      //       fontSize: 15,
                      //       color: HexColor('#F4A62A'),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: textControllers.itReffController.value,
                    onSubmitted: (value) {},
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.assignment),
                      hintText: 'Reff No',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('CREATE NEW'),
            ),
            onPressed: () async {
              Get.to(InternalTransfer2());
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: HexColor('#F4A62A'),
            ),
          ),
        ),
      ),
    );
  }
}
