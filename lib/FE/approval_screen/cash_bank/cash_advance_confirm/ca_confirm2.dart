// ignore_for_file: avoid_print, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'dart:math';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:v2rp1/FE/approval_screen/cash_bank/cash_advance_confirm/ca_confirm.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;

import '../../../../BE/reqip.dart';
import '../../../../BE/resD.dart';
import '../../../../main.dart';

class CashAdvanceConfirm2 extends StatefulWidget {
  final seckey;
  final nokasbon;
  final ket;
  final tanggal;
  final requestor;
  final requestorname;
  final updstatus;
  final kasir;
  final kasirname;
  const CashAdvanceConfirm2({
    Key? key,
    required this.seckey,
    required this.nokasbon,
    required this.ket,
    required this.tanggal,
    required this.requestor,
    required this.requestorname,
    required this.updstatus,
    required this.kasir,
    required this.kasirname,
  }) : super(key: key);

  @override
  State<CashAdvanceConfirm2> createState() => _CashAdvanceConfirm2State();
}

class _CashAdvanceConfirm2State extends State<CashAdvanceConfirm2> {
  static late List dataaa = <CaConfirmData>[];

  @override
  void initState() {
    super.initState();

    // getDataa();
  }

  var valueChooseRequest = "";
  var valueStatus = "";
  var updstatus = "0";
  double totalPrice = 0;

  // List<Details> details = [
  //   Details(
  //     requestor: 'Developer 3',
  //     project: 'SMALL MARINE',
  //     accname: 'Sepatu Bekas',
  //     desc: 'Beli sepatu bekas',
  //     qty: 20,
  //     priceunit: 3000,
  //     amount: 200000,
  //   ),
  //   Details(
  //     requestor: 'SSM10',
  //     project: 'PNEP INDUK',
  //     accname: 'Sepatu Sobek',
  //     desc: 'Beli sepatu sobek',
  //     qty: 2,
  //     priceunit: 30000,
  //     amount: 60000,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    List listStatus = [
      "Pending",
      "Confirm",
      "Reject",
      "Send To Draft",
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
          title: const Text("Cash Advance Confirmation"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => CashAdvanceConfirm());
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
              Container(
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
                                      'CA No : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      widget.nokasbon ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.white70,
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
                                      'Date : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(widget.tanggal)),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white70,
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
                                      'Request By : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      widget.requestorname ?? "",
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white70,
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
                                      'Request To : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      widget.kasirname ?? "",
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Request Status : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    DropdownButton(
                                      hint: const Text(
                                        "Pending",
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      dropdownColor: HexColor("#F4A62A"),
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
                                            print("updstatus " +
                                                updstatus.toString());
                                          } else if (valueStatus == "Confirm") {
                                            updstatus = "1";
                                            print("updstatus " +
                                                updstatus.toString());
                                          } else if (valueStatus ==
                                              "Send To Draft") {
                                            updstatus = "-9";
                                            print("updstatus " +
                                                updstatus.toString());
                                          } else {
                                            updstatus = "-1";
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
              FutureBuilder(
                future: getDataa(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.error != null) {
                    return const Center(
                      child: Text('Error Loading Data'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: Column(
                      children: [
                        Text('Loading Detail...'),
                        SizedBox(
                          height: 20,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ));
                  } else {
                    print("snapshot data " + snapshot.data.toString());
                    return Expanded(
                      child: DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 600,
                        columns: const [
                          DataColumn2(
                            label: Column(
                              children: [
                                Text('Req'),
                                Text('By'),
                              ],
                            ),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text('Project'),
                                Text('Name'),
                              ],
                            ),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text('Item/'),
                                Text('Acc No'),
                              ],
                            ),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text('Item/Acc'),
                                Text('Name'),
                              ],
                            ),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text('Desc'),
                              ],
                            ),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text('Unit'),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text('QTY'),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.S,
                          ),
                          DataColumn(
                            label: Column(
                              children: [
                                Text('Price/'),
                                Text('Unit'),
                              ],
                            ),
                            numeric: true,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text('Amt'),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text('Budget'),
                                Text('Avail'),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.M,
                          ),
                        ],
                        rows: dataaa
                            .map((e) => DataRow(cells: [
                                  DataCell(Text(
                                    e['requestorname'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['projectname'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['itemcoa'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['rem'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['ket'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['unit'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['qty'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['harga'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['amount'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['budget']['budgetavailable'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                ]))
                            .toList(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: hitungTotal(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.error != null) {
                    return const Center(
                      child: Text('Error Loading Data'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text('Please Kindly Waiting...'),
                      ],
                    ));
                  } else {
                    print("snapshot data " + snapshot.data.toString());
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'TOTAL = ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          totalPrice.toStringAsFixed(2),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('S U B M I T'),
            ),
            onPressed: () async {
              sendConfirm();
              print('updstatus ' + updstatus.toString());

              // Get.to(const Navbar());
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: HexColor("#F4A62A"),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> getDataa() async {
    HttpOverrides.global = MyHttpOverrides();

    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    try {
      var getData = await http.get(
        Uri.http('156.67.217.113',
            '/api/v1/mobile/confirmation/kasbon/' + widget.seckey),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': kulonuwun,
          'monggo': monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);
      // setState(() {
      dataaa = caConfirmData['data']['detail'];
      //hitung total
      // double totalScores = 0.0;
      // dataaa.forEach((item) {
      //   totalPrice += item["amount"];
      // }); //total udah masuk cuman ga keubah di tampilan
      // });
      // print("totalllll  " + totalScores.toString());
      print("dataaa " + dataaa.toString());
      return dataaa;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> hitungTotal() async {
    HttpOverrides.global = MyHttpOverrides();

    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    try {
      var getData = await http.get(
        Uri.http('156.67.217.113',
            '/api/v1/mobile/confirmation/kasbon/' + widget.seckey),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': kulonuwun,
          'monggo': monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);
      // setState(() {
      dataaa = caConfirmData['data']['detail'];
      //hitung total
      totalPrice = 0;
      for (var item in dataaa) {
        totalPrice += item["amount"] as int;
      }

      // });
      print("totalllll  " + totalPrice.toString());
      print("dataaa " + dataaa.toString());
      return dataaa;
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendConfirm() async {
    HttpOverrides.global = MyHttpOverrides();

    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    var status;
    var reffno;
    var message;

    Get.to(const Navbar());
    try {
      var getData = await http.put(
        Uri.http(
          '156.67.217.113',
          '/api/v1/mobile/confirmation/kasbon/' +
              widget.seckey +
              '/' +
              updstatus,
        ),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': kulonuwun,
          'monggo': monggo,
        },
      );
      final response = json.decode(getData.body);
      print(response.toString());
      setState(() {
        status = response['success'];
        reffno = response['data']['reffno'];
        message = response['data']['message'];
      });
      if (status = true) {
        Get.snackbar(
          'Success $message Data!',
          '$reffno',
          icon: const Icon(Icons.check),
          backgroundColor: Colors.green,
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Failed!',
          '$reffno',
          icon: const Icon(Icons.warning),
          backgroundColor: Colors.red,
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
