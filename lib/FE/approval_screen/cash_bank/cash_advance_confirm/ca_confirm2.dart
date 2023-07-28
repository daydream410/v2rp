import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/approval_screen/cash_bank/cash_advance_confirm/ca_confirm.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';

class CashAdvanceConfirm2 extends StatefulWidget {
  CashAdvanceConfirm2({Key? key}) : super(key: key);

  @override
  State<CashAdvanceConfirm2> createState() => _CashAdvanceConfirm2State();
}

class _CashAdvanceConfirm2State extends State<CashAdvanceConfirm2> {
  var valueChooseRequest = "";
  var valueStatus = "";

  List<Details> details = [
    Details(
      requestor: 'Developer 3',
      project: 'SMALL MARINE',
      accname: 'Sepatu Bekas',
      desc: 'Beli sepatu bekas',
      qty: 20,
      priceunit: 3000,
      amount: 200000,
    ),
    Details(
      requestor: 'SSM10',
      project: 'PNEP INDUK',
      accname: 'Sepatu Sobek',
      desc: 'Beli sepatu sobek',
      qty: 2,
      priceunit: 30000,
      amount: 60000,
    ),
    Details(
      requestor: 'Developer 3',
      project: 'PNEP INDUK',
      accname: 'Sepatu Bekas',
      desc: 'Beli sepatu bekas',
      qty: 20,
      priceunit: 3000,
      amount: 200000,
    ),
    Details(
      requestor: 'Developer 3',
      project: 'PNEP INDUK',
      accname: 'Sepatu Bekas',
      desc: 'Beli sepatu bekas',
      qty: 20,
      priceunit: 3000,
      amount: 200000,
    ),
    Details(
      requestor: 'SSM10',
      project: 'Op. HO',
      accname: 'Sepatu Sobek',
      desc: 'Beli sepatu sobek',
      qty: 2,
      priceunit: 30000,
      amount: 60000,
    ),
    Details(
      requestor: 'Developer 3',
      project: 'Op. HO',
      accname: 'Sepatu Bekas',
      desc: 'Beli sepatu bekas',
      qty: 20,
      priceunit: 3000,
      amount: 200000,
    ),
    Details(
      requestor: 'Developer 3',
      project: 'Op. HO',
      accname: 'Sepatu Bekas',
      desc: 'Beli sepatu bekas',
      qty: 20,
      priceunit: 3000,
      amount: 200000,
    ),
    Details(
      requestor: 'SSM10',
      project: 'Op. HO',
      accname: 'Sepatu Sobek',
      desc: 'Beli sepatu sobek',
      qty: 2,
      priceunit: 30000,
      amount: 60000,
    ),
    Details(
      requestor: 'Developer 3',
      project: 'Op. Dir',
      accname: 'Sepatu Bekas',
      desc: 'Beli sepatu bekas',
      qty: 20,
      priceunit: 3000,
      amount: 200000,
    ),
    Details(
      requestor: 'SSM11',
      project: 'Op. Dir',
      accname: 'Sepatu Sobek',
      desc: 'Beli sepatu sobek',
      qty: 2,
      priceunit: 30000,
      amount: 60000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    // List listRequestTo = [
    //   "Kasir Surabaya",
    //   "Kasir Samarinda",
    //   "Kasir Gresik",
    //   "Kasir - Kasiran",
    // ];
    List listStatus = [
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
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'CA No : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'CADV/NEP/2023/02-0161',
                                      style: TextStyle(
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
                                const Row(
                                  children: [
                                    Text(
                                      'Date : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '02/12/2023',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Request By : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Developer 3',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      'Request To : ',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Kasir Surabaya',
                                      style: TextStyle(
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
                                    'Description',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
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
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  // width: MediaQuery.of(context).size.width * 2.2,
                  child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: Text('Req By'),
                        size: ColumnSize.M,
                      ),
                      DataColumn2(
                        label: Text('Project Name'),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text('Item/Acc Name'),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text('Description'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('QTY'),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text('Price/Unit'),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text('Amount'),
                        numeric: true,
                      ),
                    ],
                    rows: details
                        .map((e) => DataRow(cells: [
                              DataCell(Text(
                                e.requestor ?? '',
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                e.project ?? '',
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                e.accname ?? '',
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                e.desc ?? '',
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                e.qty.toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                e.priceunit.toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                              DataCell(Text(
                                e.amount.toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              )),
                            ]))
                        .toList(),
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'TOTAL = ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '500000',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
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
              Get.to(const Navbar());
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
}

class Details {
  String? requestor;
  String? project;
  String? accname;
  String? desc;
  int? qty;
  int? priceunit;
  int? amount;

  Details({
    this.requestor,
    this.project,
    this.accname,
    this.desc,
    this.qty,
    this.priceunit,
    this.amount,
  });
}
