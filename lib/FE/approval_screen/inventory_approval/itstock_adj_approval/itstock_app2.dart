import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/approval_screen/inventory_approval/itstock_adj_approval/itstock_app.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:v2rp1/routes/api_name.dart';
import '../../../../BE/reqip.dart';
import '../../../../BE/resD.dart';
import '../../../../main.dart';
import 'package:v2rp1/BE/controller.dart';

class ItStockAdjApp2 extends StatefulWidget {
  final seckey;
  final reffno;
  final warehouse;
  final tanggal;
  final requestor;
  ItStockAdjApp2({
    Key? key,
    required this.seckey,
    required this.reffno,
    required this.warehouse,
    required this.tanggal,
    required this.requestor,
  }) : super(key: key);

  @override
  State<ItStockAdjApp2> createState() => _ItStockAdjApp2State();
}

class _ItStockAdjApp2State extends State<ItStockAdjApp2> {
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
  String reasonValue = '';
  static TextControllers textControllers = Get.put(TextControllers());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    List listStatus = [
      // "Pending",
      "Ready To Approval",
      "Send To Draft",
      "Approved & Updated",
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
          title: const Text("IT/Stock Adjustment Approval"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => ItStockAdjApp());
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
                                      'Warehouse Admin : ',
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
                                      'Warehouse Destination : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      widget.warehouse ?? "",
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
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                      child: DropdownButton(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        hint: const Text(
                                          "Ready To Approval",
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

                                            if (valueStatus ==
                                                "Approved & Updated") {
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
                                              updstatus = "0";
                                              isVisible = false;
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
                        SizedBox(
                          height: 20,
                        ),
                        Text('Please Kindly Waiting...'),
                      ],
                    ));
                  } else {
                    return Expanded(
                      child: DataTable2(
                        columnSpacing: 12,
                        dataRowHeight: 70,
                        // horizontalMargin: 12,
                        minWidth: 1300,
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
                                  'ID',
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
                                  'Stock',
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
                            size: ColumnSize.L,
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
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'WH',
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
                                Text(
                                  'Deliver',
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
                                Text(
                                  'Received',
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
                                Text(
                                  'Stock',
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
                                  'O/S',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
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
                                  'Adj',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Write',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Off',
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
                                  'Adj',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Send',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Back',
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
                                  'Adj',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Allocate',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'To W/H',
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
                                  'Adj',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'WH',
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
                                    e['sppbjno'] ?? '',
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
                                    e['stockcode'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['ket'] ?? e['stocknm'],
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
                                    e['warehouse'] ?? e['fmwh'],
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['qtyrcvd']?.toString() ??
                                        e['rcvd'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['qtyarrive'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['qtystock'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    (e['qtyrcvd'] -
                                            e['qtyarrive'] -
                                            e['qtystock'])
                                        .toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['qtywoff'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['qtysendback'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['qtytowh'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['adjwarehouse'].toString(),
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
                // sendConfirm();
                print('updstatus ' + updstatus.toString());
                if (updstatus == '-9') {
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

    String reffnoo = widget.reffno;
    String contain = 'STRF';
    if (reffnoo.contains(contain)) {
      print('contain');
      try {
        var getData = await http.get(
          Uri.https(ApiName.v2rp, ApiName.itAdj + widget.seckey),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'kulonuwun': finalKulonuwun ?? kulonuwun,
            'monggo': finalMonggo ?? monggo,
          },
        );
        final responseData = json.decode(getData.body);
        dataaa = responseData['data']['detail'];
        print("dataaa " + dataaa.toString());

        return dataaa;
      } catch (e) {
        print(e);
      }
    } else {
      print('not');
      try {
        var getData = await http.get(
          Uri.https(ApiName.v2rp, ApiName.stockAdj + widget.seckey),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'kulonuwun': finalKulonuwun ?? kulonuwun,
            'monggo': finalMonggo ?? monggo,
          },
        );
        final responseData = json.decode(getData.body);
        dataaa = responseData['data']['detail'];
        print("dataaa " + dataaa.toString());

        return dataaa;
      } catch (e) {
        print(e);
      }
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
    var message;
    var messageError;
    String reffnoo = widget.reffno;
    String contain = 'STRF';

    var body = json.encode({
      "reason": textControllers.itstockadjAppControllerReason.value.text,
    });
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Submitting your data',
      barrierDismissible: false,
      disableBackBtn: true,
    );
    if (reffnoo.contains(contain)) {
      try {
        var getData = await http.put(
          Uri.https(
            ApiName.v2rp,
            ApiName.itAdj + widget.seckey + '/' + updstatus,
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
                Get.to(ItStockAdjApp());
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
            title: 'Failed! ' + widget.reffno,
            text: '$message',
            disableBackBtn: true,
            onConfirmBtnTap: () async {
              Get.to(ItStockAdjApp());
            },
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        var getData = await http.put(
          Uri.https(
            ApiName.v2rp,
            ApiName.stockAdj + widget.seckey + '/' + updstatus,
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
                Get.to(ItStockAdjApp());
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
            title: 'Failed! ' + widget.reffno,
            text: '$message',
            disableBackBtn: true,
            onConfirmBtnTap: () async {
              Get.to(ItStockAdjApp());
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
            Get.to(ItStockAdjApp());
          },
        );
      }
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
        controller: textControllers.itstockadjAppControllerReason.value,
      ),
      onConfirmBtnTap: () {
        print(textControllers.itstockadjAppControllerReason.value.text);
        sendConfirm();
      },
    );
    textControllers.itstockadjAppControllerReason.value.clear();
  }
}
