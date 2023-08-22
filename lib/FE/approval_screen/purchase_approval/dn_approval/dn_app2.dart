import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/dn_approval/dn_app.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;

import '../../../../BE/reqip.dart';
import '../../../../BE/resD.dart';
import '../../../../main.dart';

class DebitNotesApp2 extends StatefulWidget {
  final seckey;
  final reffno;
  final tanggal;
  final requestor;
  final supplier_id;
  final ap_type;
  final ccy;
  final forexrate;

  DebitNotesApp2({
    Key? key,
    required this.seckey,
    required this.reffno,
    required this.tanggal,
    required this.requestor,
    required this.supplier_id,
    required this.ap_type,
    required this.ccy,
    required this.forexrate,
  }) : super(key: key);

  @override
  State<DebitNotesApp2> createState() => _DebitNotesApp2State();
}

class _DebitNotesApp2State extends State<DebitNotesApp2> {
  static late List dataaa = <CaConfirmData>[];

  late Future dataFuture;

  @override
  void initState() {
    super.initState();

    dataFuture = getDataa();
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
          title: const Text("D/N To Supplier Approval"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => DebitNotesApp());
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
                                      'D/N No : ',
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
                                      widget.supplier_id ?? "",
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
                                      'A/P Type : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      widget.ap_type ?? "",
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
                                    Row(
                                      children: [
                                        const Text(
                                          'CCY : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                          widget.ccy ?? "",
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
                                          'Forex Rate : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                          widget.forexrate.toString(),
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
                                        borderRadius: BorderRadius.circular(1),
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
                future: dataFuture,
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
                                Text(
                                  'Type',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'Invoice',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'No',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'Desc',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'CCY',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'in',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'IDR',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.L,
                          ),
                        ],
                        rows: dataaa
                            .map((e) => DataRow(cells: [
                                  DataCell(Text(
                                    e['tipe'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['docno'] ?? '',
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
                                    e['ccy'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '')
                                        .format(e['amount_forex']),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '')
                                        .format(e['amount_base']),
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
                future: dataFuture,
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
                          NumberFormat.currency(locale: 'eu', symbol: '')
                              .format(totalPrice),
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

  Future<dynamic> getDataa() async {
    HttpOverrides.global = MyHttpOverrides();

    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    try {
      var getData = await http.get(
        Uri.http('156.67.217.113',
            '/api/v1/mobile/approval/debitnotes/' + widget.seckey),
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
        totalPrice += item["amount_forex"];
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
    var message;
    var messageError;

    Get.to(const Navbar());
    try {
      var getData = await http.put(
        Uri.http(
          '156.67.217.113',
          '/api/v1/mobile/approval/debitnotes/' +
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
        messageError = response['message'];
      });
      if (status == true) {
        setState(() {
          message = response['data']['message'];
        });
        Get.snackbar(
          'Success $message Data!',
          widget.reffno,
          icon: const Icon(Icons.check),
          backgroundColor: Colors.green,
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Failed! ' + widget.reffno,
          '$messageError',
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
