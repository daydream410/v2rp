import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/approval_screen/cash_bank/ca_set_confirm/ca_set_confirm.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:v2rp1/BE/controller.dart';

import '../../../../BE/reqip.dart';
import '../../../../BE/resD.dart';
import '../../../../main.dart';

class CaSettleConfirm2 extends StatefulWidget {
  final seckey;
  final lpjk;
  final ket;
  final tanggal;
  final requestor;
  final requestorname;
  final updstatus;
  final kasir;
  final kasirname;
  CaSettleConfirm2({
    Key? key,
    required this.seckey,
    required this.lpjk,
    required this.ket,
    required this.tanggal,
    required this.requestor,
    required this.requestorname,
    required this.updstatus,
    required this.kasir,
    required this.kasirname,
  }) : super(key: key);

  @override
  State<CaSettleConfirm2> createState() => _CaSettleConfirm2State();
}

class _CaSettleConfirm2State extends State<CaSettleConfirm2> {
  static late List dataaa = <CaConfirmData>[];

  late Future dataFuture;

  @override
  void initState() {
    super.initState();

    dataFuture = getDataa();
  }

  static TextControllers textControllers = Get.put(TextControllers());
  var valueChooseRequest = "";
  var valueStatus = "";
  var updstatus = "0";
  double totalPrice = 0;
  bool isVisible = false;
  String reasonValue = '';

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
          title: const Text("C/A Settlement Confirmation"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => const CaSettleConfirm());
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
                height: size.height * 0.20, //atur panjang kotak putih
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
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      widget.lpjk,
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
                                      'Request To : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      widget.kasirname,
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
                                                "Confirm") {
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
                        minWidth: 900,
                        dataRowHeight: 90,
                        columns: const [
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'Request',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'By',
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
                                  'Project',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Name',
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
                                  'Item/',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Acc No',
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
                                  'Item/Acc',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Name',
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
                                  'QTY',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'Price/',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Unit',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.S,
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
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'Budget',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Avail',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
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
                                      fontSize: 10,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['ket'] ?? '',
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
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '')
                                        .format(e['harga']),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '')
                                        .format(e['amount']),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '')
                                        .format(e['budget']['budgetavailable']),
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
                print('updstatus ' + updstatus.toString());
                if (updstatus == '-9' || updstatus == '-1') {
                  reason();
                } else {
                  sendConfirm();
                }
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
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    try {
      var getData = await http.get(
        // Uri.http('156.67.217.113',
        //     '/api/v1/mobile/confirmation/lpjk/' + widget.seckey),
        Uri.https(
            'v2rp.net', '/api/v1/mobile/confirmation/lpjk/' + widget.seckey),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final response = json.decode(getData.body);
      // setState(() {
      dataaa = response['data']['detail'];

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
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    var status;
    var reffno;
    var message;
    var messageError;

    var body = json.encode({
      "reason": textControllers.caSetConfControllerReason.value.text,
    });
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
        Uri.https(
          'v2rp.net',
          '/api/v1/mobile/confirmation/lpjk/' + widget.seckey + '/' + updstatus,
        ),
        body: body,
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
          reffno = response['data']['reffno'];
          message = response['data']['message'];
        });
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Success $message Data!',
            barrierDismissible: false,
            disableBackBtn: true,
            // confirmBtnText: 'OK',
            onConfirmBtnTap: () async {
              Get.to(const CaSettleConfirm());
            },
            showCancelBtn: true,
            cancelBtnText: 'Home',
            onCancelBtnTap: () async {
              Get.to(const Navbar());
            });
      } else {
        setState(() {
          reffno = response['data']['reffno'];
          message = response['data']['message'];
        });
        await Future.delayed(const Duration(milliseconds: 1000));
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          disableBackBtn: true,
          title: 'Failed! ' + reffno,
          text: '$message',
          onConfirmBtnTap: () async {
            Get.to(const CaSettleConfirm());
          },
        );
      }
    } catch (e) {
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        disableBackBtn: true,
        title: 'Error! ',
        text: '$messageError',
        onConfirmBtnTap: () async {
          Get.to(const CaSettleConfirm());
        },
      );
    }
  }

  Future<void> reason() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      confirmBtnText: 'S U B M I T',
      confirmBtnColor: HexColor("#ffc947"),
      widget: TextFormField(
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Enter Your Reason',
          prefixIcon: Icon(
            Icons.text_snippet_rounded,
          ),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        controller: textControllers.caSetConfControllerReason.value,
      ),
      onConfirmBtnTap: () {
        print(textControllers.caSetConfControllerReason.value.text);
        sendConfirm();
      },
    );
    textControllers.caSetConfControllerReason.value.clear();
  }
}
