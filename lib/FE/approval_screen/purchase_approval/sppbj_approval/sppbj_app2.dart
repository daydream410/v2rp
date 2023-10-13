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
import 'package:v2rp1/FE/approval_screen/purchase_approval/sppbj_approval/sppbj_app.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;

import '../../../../BE/reqip.dart';
import '../../../../BE/resD.dart';
import '../../../../main.dart';

class SppbjApp2 extends StatefulWidget {
  final seckey;
  final sppbjno;
  final ket;
  final tanggal;
  final requestorname;
  SppbjApp2({
    Key? key,
    required this.seckey,
    required this.sppbjno,
    required this.ket,
    required this.tanggal,
    required this.requestorname,
  }) : super(key: key);

  @override
  State<SppbjApp2> createState() => _SppbjApp2State();
}

class _SppbjApp2State extends State<SppbjApp2> {
  static late List dataaa = <CaConfirmData>[];
  late Future dataFuture;
  @override
  void initState() {
    super.initState();
    dataFuture = getDataa();
  }

  List selectedDetails = [];
  bool selectedGak = false;
  double totalPrice = 0;
  var valueButton;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          title: const Text("SPPBJ Approval"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => SppbjApp());
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
                                      'SPPBJ No : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      widget.sppbjno ?? "",
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
                                        fontSize: 13.0,
                                        color: Colors.white,
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
                                    widget.ket ?? "Description",
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
              Visibility(
                visible: selectedGak,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          setState(() {
                            valueButton = '-1';
                          });
                          print("value button " + valueButton);
                          submitData();
                        },
                        child: const Text(
                          'Reject Selected',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            HexColor("#F4A62A"),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            valueButton = '-9';
                          });
                          print("value button " + valueButton);
                          submitData();
                        },
                        child: const Text(
                          'Send To Draft (ALL)',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: dataFuture,
                builder: (context, snapshot) {
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
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'Req',
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
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'Acc',
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
                                  'Description',
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
                            numeric: true,
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
                            numeric: true,
                            size: ColumnSize.S,
                          ),
                          DataColumn(
                            label: Column(
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                          ),
                          DataColumn(
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
                          ),
                          DataColumn(
                            label: Column(
                              children: [
                                Text(
                                  'Buget',
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
                          ),
                        ],
                        rows: dataaa
                            .map((e) => DataRow2(
                                    selected:
                                        selectedDetails.contains(e["urutan"]),
                                    onSelectChanged: (isSelected) {
                                      setState(() {
                                        final isAdding =
                                            isSelected != null && isSelected;
                                        isAdding
                                            ? selectedDetails.add(e["urutan"])
                                            : selectedDetails
                                                .remove(e["urutan"]);
                                        if (isSelected != null) {
                                          selectedGak = true;
                                        }
                                      });
                                    },
                                    cells: [
                                      DataCell(Text(
                                        e['sppbjno'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                      DataCell(Text(
                                        e['projectname'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                      DataCell(Text(
                                        e['requestorname'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                      DataCell(Text(
                                        e['itemcoa'],
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                      DataCell(Text(
                                        e['ket'],
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                      DataCell(Text(
                                        e['unit'].toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                      DataCell(Text(
                                        e['qty'].toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                      DataCell(Text(
                                        NumberFormat.currency(
                                                locale: 'eu', symbol: '')
                                            .format(e['harga']),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                      DataCell(Text(
                                        NumberFormat.currency(
                                                locale: 'eu', symbol: '')
                                            .format(e['amount']),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                      DataCell(Text(
                                        NumberFormat.currency(
                                                locale: 'eu', symbol: '')
                                            .format(
                                                e['budget']['budgetavailable']),
                                        style: const TextStyle(
                                          fontSize: 10,
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
                width: 20,
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
            visible: selectedGak,
            child: TextButton(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('A P P R O V E   A L L'),
              ),
              onPressed: () async {
                setState(() {
                  valueButton = '1';
                });
                print("value button " + valueButton);
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
        // Uri.http(
        //     '156.67.217.113', '/api/v1/mobile/approval/sppbj/' + widget.seckey),
        Uri.https('v2rp.net', '/api/v1/mobile/approval/sppbj/' + widget.seckey),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);
      // setState(() {
      dataaa = caConfirmData['data']['detail'];

      //hitung total
      totalPrice = 0;
      for (var item in dataaa) {
        // totalPrice += item["amount"] as int;
        totalPrice += item["amount"];
      }

      // });
      print("totalllll  " + totalPrice.toString());
      print("dataaa " + dataaa.toString());
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
    // var reffno;
    var message;
    var messageError;

    var body = json.encode({
      "urutan": selectedDetails,
    });

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Submitting your data',
      barrierDismissible: false,
    );
    try {
      var sendData = await http.put(
        // Uri.http(
        //   '156.67.217.113',
        //   '/api/v1/mobile/approval/sppbj/' + widget.seckey + '/' + valueButton,
        // ),
        Uri.https(
          'v2rp.net',
          '/api/v1/mobile/approval/sppbj/' + widget.seckey + '/' + valueButton,
        ),
        body: body,
        headers: {
          'Content-type': 'application/json',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      print("selected = " +
          selectedDetails.toString() +
          selectedDetails.runtimeType.toString());
      // print("urutan = " + urutan.toString() + urutan.runtimeType.toString());
      final response = json.decode(sendData.body);
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
        //   '$message Data!',
        //   widget.sppbjno,
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
              Get.to(SppbjApp());
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
        print(message);
        await Future.delayed(const Duration(milliseconds: 1000));
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Failed! ' + widget.sppbjno,
          text: '$message',
          onConfirmBtnTap: () async {
            Get.to(SppbjApp());
          },
        );
      }
    } catch (e) {
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: 'Error! ' + widget.sppbjno,
        text: '$messageError',
        onConfirmBtnTap: () async {
          Get.to(SppbjApp());
        },
      );
    }
  }
}
