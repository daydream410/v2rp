import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/approval_screen/inventory_approval/assembling_approval/asmb_app.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:v2rp1/routes/api_name.dart';
// import '../../../../BE/resD.dart';

import '../../../../BE/reqip.dart';
import '../../../../main.dart';

class AssemblingApp2 extends StatefulWidget {
  final seckey;
  final reffno;
  final tanggal;
  final estdate;
  final requestor;
  final supplier;
  final item;
  final location;
  final ket;

  AssemblingApp2({
    Key? key,
    required this.seckey,
    required this.reffno,
    required this.tanggal,
    required this.estdate,
    required this.requestor,
    required this.supplier,
    required this.item,
    required this.location,
    required this.ket,
  }) : super(key: key);

  @override
  State<AssemblingApp2> createState() => _AssemblingApp2State();
}

class _AssemblingApp2State extends State<AssemblingApp2> {
  // static late List dataaa = <CaConfirmData>[];

  late Future dataFuture;

  @override
  void initState() {
    super.initState();

    // dataFuture = getDataa();
  }

  var valueChooseRequest = "";
  var valueStatus = "";
  var updstatus = "0";
  double totalPrice = 0;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    List listStatus = [
      "Pending",
      "Approve",
      // "Reject",
      // "Send To Draft",
    ];
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Assembling Approval"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => AssemblingApp());
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 0,
            top: 5.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.001, //atur lebar kotak putih
                    vertical: size.height * 0.02, //atur lokasi kotak putih
                  ),
                  height: size.height * 0.30, //atur panjang kotak putih
                  decoration: BoxDecoration(
                    color: HexColor("#F4A62A"),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 60,
                        color: Colors.grey.withOpacity(0.40),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Reffno : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        widget.reffno ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Date : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('yyyy-MM-dd').format(
                                                DateTime.parse(widget.tanggal)),
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Est. Finish Date : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('yyyy-MM-dd').format(
                                                DateTime.parse(widget.estdate)),
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Request By : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        widget.requestor ?? "",
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Supplier : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        widget.supplier ?? "",
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Item : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        widget.item ?? "",
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Location : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        widget.location ?? "",
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Request Status : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(1),
                                        ),
                                        child: DropdownButton(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          hint: const Text(
                                            "Pending",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                          dropdownColor: HexColor("#F4A62A"),
                                          underline: Container(), //empty line
                                          iconSize: 30,
                                          value: valueStatus.isNotEmpty
                                              ? valueStatus
                                              : null,
                                          onChanged: (newValueStatus) {
                                            setState(() {
                                              valueStatus =
                                                  newValueStatus as String;

                                              if (valueStatus == "Pending") {
                                                updstatus = "0";
                                                isVisible = false;
                                                print("updstatus " +
                                                    updstatus.toString());
                                              } else if (valueStatus ==
                                                  "Approve") {
                                                updstatus = "1";
                                                isVisible = true;
                                                print("updstatus " +
                                                    updstatus.toString());
                                              } else if (valueStatus ==
                                                  "Send To Draft") {
                                                updstatus = "-9";
                                                isVisible = true;
                                                print("updstatus " +
                                                    updstatus.toString());
                                              } else {
                                                updstatus = "-1";
                                                isVisible = true;
                                                print("updstatus " +
                                                    updstatus.toString());
                                              }
                                            });
                                          },
                                          items: listStatus.map((valueStatuss) {
                                            return DropdownMenuItem(
                                              value: valueStatuss,
                                              child: Text(
                                                valueStatuss,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    // margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    width: size.width * 0.8,
                                    height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: Colors.white,
                                    )),
                                    child: Text(
                                      widget.ket ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Visibility(
            visible: isVisible,
            child: TextButton(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('S U B M I T'),
              ),
              onPressed: () async {
                sendConfirm();
                print('updstatus ' + updstatus.toString());
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: HexColor("#F4A62A"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<dynamic> getDataa() async {
  //   HttpOverrides.global = MyHttpOverrides();

  //   var kulonuwun = MsgHeader.kulonuwun;
  //   var monggo = MsgHeader.monggo;
  //   try {
  //     var getData = await http.get(
  //       Uri.http('156.67.217.113',
  //           '/api/v1/mobile/approval/assembling/' + widget.seckey),
  //       headers: {
  //         'Content-Type': 'application/json; charset=utf-8',
  //         'kulonuwun': kulonuwun,
  //         'monggo': monggo,
  //       },
  //     );
  //     final caConfirmData = json.decode(getData.body);

  //     // setState(() {
  //     dataaa = caConfirmData['data']['detail'];
  //     print("dataaa " + dataaa.toString());

  //     //hitung total
  //     totalPrice = 0;
  //     for (var item in dataaa) {
  //       totalPrice += item["amount"] as int;
  //     }

  //     // });
  //     print("totalllll  " + totalPrice.toString());
  //     return dataaa;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> sendConfirm() async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    var status;
    var message;
    var messageError;

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Submitting your data',
      barrierDismissible: false,
      disableBackBtn: true,
    );
    try {
      var getData = await http.put(
        // Uri.http(
        //   '156.67.217.113',
        //   '/api/v1/mobile/approval/assembling/' +
        //       widget.seckey +
        //       '/' +
        //       updstatus,
        // ),
        Uri.https(
          ApiName.v2rp,
          ApiName.assembling + widget.seckey + '/' + updstatus,
        ),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final response = json.decode(getData.body);
      print(response.toString());
      setState(() {
        status = response['success'];
        messageError = response['message'];
      });
      if (status == true) {
        setState(() {
          message = response['data']['message'];
        });
        // Get.snackbar(
        //   'Success $message Data!',
        //   widget.reffno,
        //   icon: const Icon(Icons.check),
        //   backgroundColor: Colors.green,
        //   isDismissible: true,
        //   dismissDirection: DismissDirection.vertical,
        //   colorText: Colors.white,
        // );
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Success $message Data!',
            barrierDismissible: false,
            disableBackBtn: true,
            // confirmBtnText: 'OK',
            onConfirmBtnTap: () async {
              Get.to(AssemblingApp());
            },
            showCancelBtn: true,
            cancelBtnText: 'Home',
            onCancelBtnTap: () async {
              Get.to(const Navbar());
            });
      } else {
        setState(() {
          message = response['data']['message'];
        });
        // Get.snackbar(
        //   'Failed! ' + widget.reffno,
        //   '$messageError',
        //   icon: const Icon(Icons.warning),
        //   backgroundColor: Colors.red,
        //   isDismissible: true,
        //   dismissDirection: DismissDirection.vertical,
        //   colorText: Colors.white,
        // );
        await Future.delayed(const Duration(milliseconds: 1000));
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Failed! ' + widget.reffno,
          disableBackBtn: true,
          text: '$message',
          onConfirmBtnTap: () async {
            Get.to(AssemblingApp());
          },
        );
      }
    } catch (e) {
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: 'Error! ' + widget.reffno,
        text: '$messageError',
        disableBackBtn: true,
        onConfirmBtnTap: () async {
          Get.to(AssemblingApp());
        },
      );
    }
  }
}
