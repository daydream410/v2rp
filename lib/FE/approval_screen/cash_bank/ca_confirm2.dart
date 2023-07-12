import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/approval_screen/cash_bank/ca_confirm.dart';

class CashAdvanceConfirm2 extends StatefulWidget {
  CashAdvanceConfirm2({Key? key}) : super(key: key);

  @override
  State<CashAdvanceConfirm2> createState() => _CashAdvanceConfirm2State();
}

class _CashAdvanceConfirm2State extends State<CashAdvanceConfirm2> {
  var valueChooseRequest = "";
  var valueStatus = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    List listRequestTo = [
      "Kasir Surabaya",
      "Kasir Samarinda",
      "Kasir Gresik",
      "Kasir - Kasiran",
    ];
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
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
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
                  height: size.height * 0.40, //atur panjang kotak putih
                  decoration: BoxDecoration(
                    color: HexColor("#F4A62A"),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 60,
                        color: Colors.grey.withOpacity(0.40),
                      ),
                    ],
                  ),
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
                                const Text(
                                  'CADV/NEP/2023/02-0161',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  '02/12/2023',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Developer 3',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButton(
                                  hint: const Text(
                                    "Request To",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  dropdownColor: HexColor("#F4A62A"),
                                  iconSize: 30,
                                  value: valueChooseRequest.isNotEmpty
                                      ? valueChooseRequest
                                      : null,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChooseRequest = newValue as String;
                                    });
                                  },
                                  items: listRequestTo.map((valueRequest) {
                                    return DropdownMenuItem(
                                      value: valueRequest,
                                      child: Text(
                                        valueRequest,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                DropdownButton(
                                  hint: const Text(
                                    "Request Status",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  dropdownColor: HexColor("#F4A62A"),
                                  iconSize: 30,
                                  value: valueStatus.isNotEmpty
                                      ? valueStatus
                                      : null,
                                  onChanged: (newValueStatus) {
                                    setState(() {
                                      valueStatus = newValueStatus as String;
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
                                    'Description',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: ListView.separated(
                    // shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      );
                    },
                    physics: const BouncingScrollPhysics(),
                    // scrollDirection: Axis.horizontal,
                    // itemCount: _dataaa.length,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            // _dataaa[index]['itemname'],
                            "Cash Advance Number",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle:
                              // Text(_dataaa[index]['stockid']),
                              const Text("Requestor || Date"),
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward_rounded),
                            onPressed: () {
                              Get.to(CashAdvanceConfirm2());
                              // Get.to(ScanVb(
                              //   idstock: _dataaa[index]
                              //       ['stockid'],
                              //   itemname: _dataaa[index]
                              //       ['itemname'],
                              //   serverKeyVal: serverKeyValue,
                              // ));
                            },
                            color: HexColor('#F4A62A'),
                            hoverColor: HexColor('#F4A62A'),
                            splashColor: HexColor('#F4A62A'),
                          ),
                          tileColor: Colors.white,
                          textColor: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.05,
          // width: size.width * 0.5,
          color: HexColor("#F4A62A"),
          child: const Padding(
            padding: EdgeInsets.only(
              // top: 13,
              left: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'TOTAL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '50.00000.00000',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
