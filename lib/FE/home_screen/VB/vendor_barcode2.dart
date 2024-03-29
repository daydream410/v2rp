// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/controller.dart';
import 'package:v2rp1/BE/reqip.dart';
import 'package:v2rp1/FE/home_screen/VB/dialog_box_vb.dart';
import 'package:http/http.dart' as http;
import 'package:v2rp1/FE/home_screen/VB/vendor_barcode1.dart';

class VendorBarcode2 extends StatefulWidget {
  final barcodeResult;
  final idstock2;
  final itemname2;
  final message2;
  const VendorBarcode2({
    Key? key,
    required this.barcodeResult,
    this.idstock2,
    this.itemname2,
    this.message2,
  }) : super(key: key);

  @override
  State<VendorBarcode2> createState() => _VendorBarcode2State();
}

class _VendorBarcode2State extends State<VendorBarcode2> {
  static var success;
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
          title: const Text("Confirmation Data"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(VendorBarcode1());
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              // padding: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Confirmation Vendor Data'),
                  const Image(
                    image: AssetImage('images/vb_conf.jpg'),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: 50,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 13,
                              left: 16,
                            ),
                            child: Text(
                              "Item Details",
                              style: TextStyle(
                                color: HexColor("#F4A62A"),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: 200,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("ID Stock"),
                                    Text(
                                      widget.idstock2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Item Name"),
                                    Text(
                                      widget.itemname2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Barcode"),
                                    Text(
                                      widget.barcodeResult,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  controller:
                                      textControllers.remarksController.value,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.assignment),
                                    hintText: 'Remarks',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextButton(
            onPressed: () async {
              updateData();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('SUBMIT DATA'),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: HexColor("#F4A62A"),
            ),
          ),
        ),
      ),
    );
  }

  Future updateData() async {
    var remarks = textControllers.remarksController.value.text;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    // var sendUpdate = await http.post(Uri.https('www.v2rp.net', '/ptemp/'),
    //     headers: {'x-v2rp-key': conve},
    //     body: jsonEncode({
    //       "trxid": trxid,
    //       "datetime": datetime,
    //       "reqid": "0002",
    //       "id": widget.idstock2,
    //       "barcode": widget.barcodeResult,
    //       "serverkey": widget.serverKeyVal2,
    //       "remarks": remarks,
    //     }));
    var sendUpdate = await http.post(
      // Uri.http('156.67.217.113', '/api/v1/mobile/stocks/barcode'),
      Uri.https('v2rp.net', '/api/v1/mobile/stocks/barcode'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'kulonuwun': finalKulonuwun ?? kulonuwun,
        'monggo': finalMonggo ?? monggo,
      },
      body: jsonEncode({
        'id': widget.idstock2,
        'barcode': widget.barcodeResult,
        'remarks': remarks,
      }),
    );
    print(sendUpdate.body);
    final resultData = json.decode(sendUpdate.body);
    success = resultData['success'];
    var responseMessage = resultData['message'];
    var responseMessage2 = resultData['data']['message'];
    print('id stock = ' + widget.idstock2);
    print('remarks = ' + remarks);
    print('barcode = ' + widget.barcodeResult);

    if (success == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBoxVb(
              title: "SUCCESSFUL DATA SUBMIT",
              // descriptions: "Data Barcode Pada item " +
              //     widget.idstock2 +
              //     " Telah Berhasil Di Update",
              descriptions: widget.idstock2 + " " + responseMessage,
              text: "Home",
              home: "OK",
              img: Image.asset("images/success.gif"),
            );
          });
    } else if (success == false) {
      Get.snackbar(
        'Failed!',
        '$responseMessage2',
        colorText: Colors.white,
        icon: Icon(
          Icons.warning,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.vertical,
      );
    } else {
      Get.snackbar(
        'ERROR!!',
        '$responseMessage',
        colorText: Colors.white,
        icon: Icon(
          Icons.warning,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.vertical,
      );
    }
  }
}
