import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/approval_screen/cash_bank/ca_set_approval/ca_set_app.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';

class CaSetApproval2 extends StatefulWidget {
  CaSetApproval2({Key? key}) : super(key: key);

  @override
  State<CaSetApproval2> createState() => _CaSetApproval2State();
}

class _CaSetApproval2State extends State<CaSetApproval2> {
  List<Details> details = [
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'SMALL MARINE',
      account: 'Sepatu Bekas',
      requestor: 'Developer 3',
      qty: 5,
      price: 20,
      amount: 3000,
      budgetavail: 200000,
    ),
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'PNEP INDUK',
      account: 'Sepatu Sobek',
      requestor: 'Developer 3',
      qty: 5,
      price: 2,
      amount: 30000,
      budgetavail: 60000,
    ),
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'PNEP INDUK',
      account: 'Sepatu Bekas',
      requestor: 'Developer 3',
      qty: 5,
      price: 20,
      amount: 3000,
      budgetavail: 200000,
    ),
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'PNEP INDUK',
      account: 'Sepatu Bekas',
      requestor: 'Developer 3',
      qty: 23,
      price: 20,
      amount: 3000,
      budgetavail: 200000,
    ),
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'Op. HO',
      account: 'Sepatu Sobek',
      requestor: 'Developer 3',
      qty: 52,
      price: 2,
      amount: 30000,
      budgetavail: 60000,
    ),
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'Op. HO',
      account: 'Sepatu Bekas',
      requestor: 'Developer 3',
      qty: 56,
      price: 20,
      amount: 3000,
      budgetavail: 200000,
    ),
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'Op. HO',
      account: 'Sepatu Bekas',
      requestor: 'Developer 3',
      qty: 92,
      price: 20,
      amount: 3000,
      budgetavail: 200000,
    ),
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'Op. HO',
      account: 'Sepatu Sobek',
      requestor: 'Developer 3',
      qty: 924,
      price: 2,
      amount: 30000,
      budgetavail: 60000,
    ),
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'Op. Dir',
      account: 'Sepatu Bekas',
      requestor: 'Developer 3',
      qty: 102,
      price: 20,
      amount: 3000,
      budgetavail: 200000,
    ),
    Details(
      cano: 'CADV/NEP/2023/02-0161',
      jobproject: 'Op. Dir',
      account: 'Sepatu Sobek',
      requestor: 'Developer 3',
      qty: 523,
      price: 2,
      amount: 30000,
      budgetavail: 60000,
    ),
  ];
  List<Details> selectedDetails = [];
  bool selectedGak = false;
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
          title: const Text("CA Settlement Approval"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => CaSetApproval());
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
                              const Text(
                                '50.000.000',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
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
              Visibility(
                visible: selectedGak,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Approve Selected',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Reject',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          HexColor("#F4A62A"),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Send To Draft',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
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
                        .map((Details details) => DataRow2(
                                selected: selectedDetails.contains(details),
                                onSelectChanged: (isSelected) => setState(() {
                                      final isAdding =
                                          isSelected != null && isSelected;
                                      isAdding
                                          ? selectedDetails.add(details)
                                          : selectedDetails.remove(details);
                                      if (isSelected != null) {
                                        selectedGak = true;
                                      }
                                    }),
                                cells: [
                                  DataCell(Text(
                                    details.requestor ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    details.cano ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    details.jobproject ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    details.account ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    details.qty.toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    details.amount.toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    details.budgetavail.toString(),
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
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('A P P R O V E   A L L'),
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
  // String? requestor;
  // String? project;
  // String? accname;
  // String? desc;
  // int? qty;
  // int? priceunit;
  // int? amount;

  String? cano;
  String? jobproject;
  String? requestor;
  String? account;
  int? qty;
  int? price;
  int? amount;
  int? budgetavail;

  Details({
    this.cano,
    this.jobproject,
    this.requestor,
    this.account,
    this.qty,
    this.price,
    this.amount,
    this.budgetavail,
  });
}
