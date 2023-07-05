// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/home_screen/ST/detail_st.dart';
import 'package:v2rp1/FE/home_screen/ST/stock_transfer.dart';
import 'package:v2rp1/FE/home_screen/ST/stock_transfer3.dart';

import '../../../BE/controller.dart';

class StockTransfer2 extends StatefulWidget {
  const StockTransfer2({Key? key}) : super(key: key);

  @override
  State<StockTransfer2> createState() => _StockTransfer2State();
}

class _StockTransfer2State extends State<StockTransfer2> {
  bool isVisible = false;
  static TextControllers textControllers = Get.put(TextControllers());

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
          title: const Text("Stock Transfer"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(StockTransfer());
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TextField(
                  //   controller: controllerWh,
                  //   decoration: InputDecoration(
                  //     prefixIcon: const Icon(Icons.warehouse),
                  //     hintText: 'Warehouse',
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(15),
                  //         borderSide: const BorderSide(color: Colors.black)),
                  //   ),
                  // ),
                  TextField(
                    controller: textControllers.smWhController.value,
                    onSubmitted: (value) {},
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.warehouse),
                      hintText: 'Warehouse',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () => setState(() => isVisible = !isVisible),
                    child: const Text('Load Data'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: HexColor('#F4A62A'),
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          color: Colors.black,
                          thickness: 0.8,
                          height: 25,
                        ),
                        const Text('Item List'),
                        const SizedBox(height: 15.0),
                        //list 1
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('CASTOLDI01SP038'),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AddDetailST(
                                          title: "SUBMIT DATA SUCCESFUL",
                                          descriptions:
                                              "Internal Transfer No.STTR/NEP/2022/03-000158",
                                          text: "Home",
                                          home: "OK",
                                        );
                                      });
                                },
                                child: Text(
                                  "Detail",
                                  style: TextStyle(color: HexColor("#F4A62A")),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Hydraulic Pump TD282 30000380"),
                              Text("Gudang SCM HO 3 Rak 6C Box 04"),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: isVisible,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('SAVE DATA'),
              ),
              onPressed: () async {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const StockTransfer3(),
                //   ),
                // );
                Get.to(StockTransfer3());
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: HexColor('#F4A62A'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
