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
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/np_app/newap_app.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;

import '../../../../BE/reqip.dart';
import '../../../../BE/resD.dart';
import '../../../../main.dart';

class NpApp2 extends StatefulWidget {
  final seckey;
  final reffno;
  final ket;
  final tanggal;
  final supplier;
  final invdate;
  final ccy;
  final duedate;
  final amount;
  final inIDR;
  NpApp2({
    Key? key,
    required this.seckey,
    required this.reffno,
    required this.ket,
    required this.tanggal,
    required this.supplier,
    required this.invdate,
    required this.ccy,
    required this.duedate,
    required this.amount,
    required this.inIDR,
  }) : super(key: key);

  @override
  State<NpApp2> createState() => _NpApp2State();
}

class _NpApp2State extends State<NpApp2> {
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
  double sTTL = 0;
  double dTTL = 0;
  double sTAX = 0;
  String dTAX = '';
  double ppn = 0;
  double pph = 0;
  double otax = 0;
  double othexpen = 0;
  double nTTL = 0;
  double gTTL = 0;
  bool isVisible = false;

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
          title: const Text("New Payable Approval"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => NpApp());
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
          child: SingleChildScrollView(
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Invoice No : ',
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
                                        'Invoice Date : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('yyyy-MM-dd').format(
                                            DateTime.parse(widget.invdate)),
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
                                            'Due Date : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('yyyy-MM-dd').format(
                                                DateTime.parse(widget.duedate)),
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
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Amount : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            NumberFormat.currency(
                                                    locale: 'eu', symbol: '')
                                                .format(widget.amount),
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
                                            'in IDR : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          Text(
                                            NumberFormat.currency(
                                                    locale: 'eu', symbol: '')
                                                .format(widget.inIDR),
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                                      widget.ket ?? "Notes",
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

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Column(
                          children: [
                            Expanded(
                              child: DataTable2(
                                columnSpacing: 10,
                                horizontalMargin: 10,
                                minWidth: 900,
                                dataRowHeight: 100,
                                // bottomMargin: 100,
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
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Column(
                                      children: [
                                        Text(
                                          'Reffno',
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
                                          'Tax',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          'Amt',
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
                                          'Total',
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
                                    size: ColumnSize.M,
                                  ),
                                ],
                                rows: dataaa
                                    .map((e) => DataRow(cells: [
                                          DataCell(Text(
                                            e['tipeName'] ?? '',
                                            style: const TextStyle(
                                              fontSize: 11,
                                            ),
                                          )),
                                          DataCell(Text(
                                            e['reffno'] ?? '',
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
                                                .format(e['taxAmount']),
                                            style: const TextStyle(
                                              fontSize: 11,
                                            ),
                                          )),
                                          DataCell(Text(
                                            NumberFormat.currency(
                                                    locale: 'eu', symbol: '')
                                                .format(e['amount_forex'] +
                                                    e['taxAmount']),
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
                            ),
                            Divider(
                              height: 10,
                              thickness: 5,
                              color: HexColor("#F4A62A"),
                            ),
                            const Text('Tabel Sub-Total'),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    }
                  },
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
                          Text('Please Kindly Waiting'),
                        ],
                      ));
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          minWidth: 600,
                          columns: const [
                            DataColumn2(
                              label: Column(
                                children: [
                                  Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'DPP',
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
                                    '',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'PPN',
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
                                    '',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'PPh',
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
                                    '',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Other',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Tax',
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
                                    '',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Tax',
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
                                    '',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'Total',
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
                                    '',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'IN',
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
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(
                                NumberFormat.currency(locale: 'eu', symbol: '')
                                    .format(sTTL),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                NumberFormat.currency(locale: 'eu', symbol: '')
                                    .format(ppn),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                NumberFormat.currency(locale: 'eu', symbol: '')
                                    .format(pph),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                NumberFormat.currency(locale: 'eu', symbol: '')
                                    .format(otax),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                NumberFormat.currency(locale: 'eu', symbol: '')
                                    .format(sTAX),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                NumberFormat.currency(locale: 'eu', symbol: '')
                                    .format(gTTL),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                NumberFormat.currency(locale: 'eu', symbol: '')
                                    .format(gTTL),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                            ]),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
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
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    try {
      var getData = await http.get(
        // Uri.http('156.67.217.113',
        //     '/api/v1/mobile/approval/newpayable/' + widget.seckey),
        Uri.https(
            'v2rp.net', '/api/v1/mobile/approval/newpayable/' + widget.seckey),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);
      // setState(() {
      dataaa = caConfirmData['data']['detail'];
      print("dataaa " + dataaa.toString());

      //hitung total
      sTTL = 0;
      // dTTL = 0;
      sTAX = 0;
      dTAX = '';
      nTTL = 0;
      gTTL = 0;
      for (var item in dataaa) {
        sTTL += item["amount_forex"];
        // dTTL += item["disc"] * (item["qty"] * item["harga"]) / 100;
        sTAX += item["taxAmount"];
        if (item["tax"] == ':0') {
          dTAX == '0';
          print("dTaxzzzzzzz  " + dTAX.toString());
        } else {
          dTAX = item["tax"];
          print("dTaxx  " + dTAX.toString());
        }

        var listtax = dTAX.split(",");

        for (var xx = 0; xx < listtax.length; xx++) {
          var snil = listtax[xx].split(":");
          if (dTAX != "") {
            if (snil.isNotEmpty) {
              if (snil[0].substring(0, 1) == "0") {
                ppn += double.parse(snil[1]);
              } else if (snil[0].substring(0, 1) == "1") {
                pph += double.parse(snil[1]);
              } else {
                otax += double.parse(snil[1]);
              }
            }
          }
        }

        nTTL = sTTL; //sTTL
        gTTL = nTTL + sTAX; //nTTL + sTAX
      }

      // });
      print("totalllll  " + sTTL.toString());
      print("dTax  " + dTAX.toString());

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

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Submitting your data',
      barrierDismissible: false,
    );
    try {
      var getData = await http.put(
        // Uri.http(
        //   '156.67.217.113',
        //   '/api/v1/mobile/approval/newpayable/' +
        //       widget.seckey +
        //       '/' +
        //       updstatus,
        // ),
        Uri.https(
          'v2rp.net',
          '/api/v1/mobile/approval/newpayable/' +
              widget.seckey +
              '/' +
              updstatus,
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
          reffno = response['data']['reffno'];
          message = response['data']['message'];
        });
        // Get.snackbar(
        //   'Success $message Data!',
        //   '$reffno',
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
            // confirmBtnText: 'OK',
            onConfirmBtnTap: () async {
              Get.to(NpApp());
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
        // Get.snackbar(
        //   'Failed!',
        //   '$reffno',
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
          title: 'Failed! ' + reffno,
          text: '$message',
          onConfirmBtnTap: () async {
            Get.to(NpApp());
          },
        );
      }
    } catch (e) {
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: 'Error! ' + reffno,
        text: '$messageError',
        onConfirmBtnTap: () async {
          Get.to(NpApp());
        },
      );
    }
  }
}
