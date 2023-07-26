import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:v2rp1/FE/approval_screen/inventory_approval/it_approval/it_app.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class ItApp2 extends StatefulWidget {
  ItApp2({Key? key}) : super(key: key);

  @override
  State<ItApp2> createState() => _ItApp2State();
}

class _ItApp2State extends State<ItApp2> {
  // String CurrentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String currentDate = "Estimate Arrival Date ";
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

    List listStatus = [
      "Pending",
      "Approve",
      "Send To Draft",
    ];

    Future<void> getCurrent(BuildContext context) async {
      final DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(200),
          lastDate: DateTime(3000));
      if (date != null) {
        setState(() {
          currentDate = DateFormat("yyyy-MM-dd").format(date);
        });
      }
    }

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
          title: const Text("Internal Transfer Approval"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => ItApp());
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
                  height: size.height * 0.40, //atur panjang kotak putih
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
                                  'STRF/NEP/2023/07-0629',
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
                                  'Warehouse Staff - Kalimantan 1',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'KALSP2 - SPU 2',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  '2023-07-25',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      currentDate,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        getCurrent(context);
                                      },
                                      icon: const Icon(
                                        Icons.date_range_rounded,
                                      ),
                                      color: Colors.white,
                                      iconSize: 30,
                                    ),
                                  ],
                                ),
                                // DropdownButton(
                                //   hint: const Text(
                                //     "IDR",
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                //   icon: const Icon(
                                //     Icons.arrow_drop_down,
                                //     color: Colors.white,
                                //   ),
                                //   dropdownColor: HexColor("#F4A62A"),
                                //   iconSize: 30,
                                //   value: valueChooseRequest.isNotEmpty
                                //       ? valueChooseRequest
                                //       : null,
                                //   onChanged: null,
                                //   items: null,
                                // ),
                                DropdownButton(
                                  hint: const Text(
                                    "Approval Status",
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
              ),
              SizedBox(
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