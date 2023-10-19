// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/poscm_unapproved/poscm_unapproved.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;

import '../../../../BE/reqip.dart';
import '../../../../BE/resD.dart';
import '../../../../main.dart';

class PoUnapproved2 extends StatefulWidget {
  final seckey;
  final pono;
  final tanggal;
  final requestorname;
  final supplier;
  final ccy;
  final disc;
  final tipe;

  const PoUnapproved2({
    Key? key,
    required this.seckey,
    required this.pono,
    required this.tanggal,
    required this.requestorname,
    required this.supplier,
    required this.ccy,
    required this.disc,
    required this.tipe,
  }) : super(key: key);

  @override
  State<PoUnapproved2> createState() => _PoUnapproved2State();
}

class _PoUnapproved2State extends State<PoUnapproved2> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List listStatus = [
      "Pending",
      "Approve",
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
          title: const Text("PO Supplier Unapproved Approval"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => PoUnapproved());
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
                  height: size.height * 0.25, //atur panjang kotak putih
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
                                        'PO No : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        widget.pono ?? "",
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
                                        widget.requestorname ?? "",
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
                                        'CCY : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        widget.ccy,
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
                                        'Discount : ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        widget.disc + '%',
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
                        height: MediaQuery.of(context).size.height * 0.40,
                        child: Column(
                          children: [
                            Expanded(
                              child: DataTable2(
                                columnSpacing: 10,
                                horizontalMargin: 10,
                                minWidth: 1500,
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
                                    size: ColumnSize.M,
                                  ),
                                  DataColumn2(
                                    label: Column(
                                      children: [
                                        Text(
                                          'SPPBJ',
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
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Column(
                                      children: [
                                        Text(
                                          'Item',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          'Coa',
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
                                          'ID',
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
                                          'Unit',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    size: ColumnSize.S,
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
                                    size: ColumnSize.S,
                                    numeric: true,
                                  ),
                                  DataColumn2(
                                    label: Column(
                                      children: [
                                        Text(
                                          'Price',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          '/Unit',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    size: ColumnSize.L,
                                    numeric: true,
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
                                    size: ColumnSize.L,
                                    numeric: true,
                                  ),
                                  DataColumn2(
                                    label: Column(
                                      children: [
                                        Text(
                                          'Disc(%)',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    size: ColumnSize.M,
                                    numeric: true,
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
                                    size: ColumnSize.M,
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
                                            e['tipe'] == 0
                                                ? 'SPPBJ'
                                                : 'Other Income/Expenses',
                                            style: const TextStyle(
                                              fontSize: 11,
                                            ),
                                          )),
                                          DataCell(Text(
                                            e['sppbjno'] ?? '',
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
                                            e['projectid'] ?? '',
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
                                            e['unit'] ?? '',
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
                                                .format(e['harga'] * e['qty']),
                                            style: const TextStyle(
                                              fontSize: 11,
                                            ),
                                          )),
                                          DataCell(Text(
                                            NumberFormat.currency(
                                                    locale: 'eu', symbol: '%')
                                                .format(e['disc']),
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
                                                .format(e['harga'] * e['qty'] +
                                                    e['taxAmount']),
                                            style: const TextStyle(
                                              fontSize: 11,
                                            ),
                                          )),
                                          DataCell(Text(
                                            NumberFormat.currency(
                                                    locale: 'eu', symbol: '')
                                                .format(e['amtidr']),
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
                child: Text('A P P R O V E   A L L'),
              ),
              onPressed: () async {
                submitData();
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
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var finalKulonuwun = sharedPreferences.getString('kulonuwun');
  //   var finalMonggo = sharedPreferences.getString('monggo');
  //   var kulonuwun = MsgHeader.kulonuwun;
  //   var monggo = MsgHeader.monggo;

  //   try {
  //     var getData = await http.get(
  //       Uri.https('v2rp.net',
  //           '/api/v1/mobile/approval/supplier/pononscm/' + widget.seckey),
  //       headers: {
  //         'Content-Type': 'application/json; charset=utf-8',
  //         'kulonuwun': finalKulonuwun ?? kulonuwun,
  //         'monggo': finalMonggo ?? monggo,
  //       },
  //     );
  //     final caConfirmData = json.decode(getData.body);
  //     print("response " + caConfirmData.toString());
  //     dataaa = caConfirmData['data']['detail'];
  //     print("dataaa " + dataaa.toString());
  //     if (dataaa.isEmpty) {
  //       var getData = await http.get(
  //         Uri.https('v2rp.net',
  //             '/api/v1/mobile/approval/supplier/poscm/' + widget.seckey),
  //         headers: {
  //           'Content-Type': 'application/json; charset=utf-8',
  //           'kulonuwun': finalKulonuwun ?? kulonuwun,
  //           'monggo': finalMonggo ?? monggo,
  //         },
  //       );
  //       final caConfirmData = json.decode(getData.body);
  //       print("response " + caConfirmData.toString());
  //       dataaa = caConfirmData['data']['detail'];
  //       print("dataaa " + dataaa.toString());
  //     }
  //     return dataaa;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
        Uri.https('v2rp.net',
            '/api/v1/mobile/approval/supplier/poscm/' + widget.seckey),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);
      print("response " + caConfirmData.toString());
      dataaa = caConfirmData!['data']['detail'] ?? [];
      print("dataaa " + dataaa.toString());

      if (dataaa.isEmpty) {
        var getData = await http.get(
          Uri.https('v2rp.net',
              '/api/v1/mobile/approval/supplier/pononscm/' + widget.seckey),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'kulonuwun': finalKulonuwun ?? kulonuwun,
            'monggo': finalMonggo ?? monggo,
          },
        );
        final caConfirmData = json.decode(getData.body);
        print("response " + caConfirmData.toString());
        dataaa = caConfirmData['data']['detail'];
        print("dataaa " + dataaa.toString());
      }

      //hitung total
      sTTL = 0;
      // dTTL = 0;
      sTAX = 0;
      dTAX = '';
      nTTL = 0;
      gTTL = 0;
      for (var item in dataaa) {
        sTTL += item["harga"] * item["qty"];

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

//----------------------------------------------------------------
  Future<void> submitData() async {
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

    // var body = json.encode({
    //   "urutan": selectedDetails,
    // });

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Submitting your data',
      barrierDismissible: false,
    );
    try {
      var sendData = await http.put(
        Uri.https(
          'v2rp.net',
          '/api/v1/mobile/approval/supplier/poscm/' +
              widget.seckey +
              '/' +
              updstatus,
        ),
        // body: body,
        headers: {
          'Content-type': 'application/json',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      // print("selected = " +
      //     selectedDetails.toString() +
      //     selectedDetails.runtimeType.toString());
      final response = json.decode(sendData.body);
      print(response.toString());
      setState(() {
        status = response['success'];
        messageError = response['message'];
        message = response['data']['message'] ?? '';
      });
      if (status == false) {
        var sendData = await http.put(
          Uri.https(
            'v2rp.net',
            '/api/v1/mobile/approval/supplier/pononscm/' +
                widget.seckey +
                '/' +
                updstatus,
          ),
          // body: body,
          headers: {
            'Content-type': 'application/json',
            'kulonuwun': finalKulonuwun ?? kulonuwun,
            'monggo': finalMonggo ?? monggo,
          },
        );
        final response = json.decode(sendData.body);
        print(response.toString());
        setState(() {
          status = response['success'];
          messageError = response['message'];
          message = response['data']['message'] ?? '';
        });
      }
      if (status == true) {
        // setState(() {
        //   message = response['data']['message'];
        // });
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Success $message Data!',
            barrierDismissible: false,
            // confirmBtnText: 'OK',
            onConfirmBtnTap: () async {
              Get.to(PoUnapproved());
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
        await Future.delayed(const Duration(milliseconds: 1000));
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Failed! ' + widget.pono,
          text: '$message',
          barrierDismissible: false,
          onConfirmBtnTap: () async {
            Get.to(PoUnapproved());
          },
        );
      }
    } catch (e) {
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: 'Error! ' + widget.pono,
        text: '$messageError',
        onConfirmBtnTap: () async {
          Get.to(PoUnapproved());
        },
      );
    }
  }
}
