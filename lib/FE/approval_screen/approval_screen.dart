import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/approval_screen/cash_bank/cashbank1.dart';

import '../../BE/controller.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  static TextControllers textControllers = Get.put(TextControllers());

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Approval Menu"),
          elevation: 0,
          backgroundColor: HexColor("#F4A62A"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.2, //atur panjang kotak kuning atas
                  decoration: BoxDecoration(
                      color: HexColor("#F4A62A"),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45),
                      )),
                ),
                Positioned(
                  child: Column(
                    children: [
                      //kotak putih pertama (cash & bank approval)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              size.width * 0.03, //atur lebar kotak putih
                          vertical:
                              size.height * 0.02, //atur lokasi kotak putih
                        ),
                        height: size.height * 0.20, //atur panjang kotak putih
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.05),
                                  child: const Text(
                                    'Cash & Bank Approval',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                            // baris pertama
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/cashbankapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              Get.to(() => CashBank1());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'Cash Advance',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Confirmation',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/cashbankapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              Get.to(() => CashBank1());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'Cash Advance',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/salesapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              // Get.to(() => StockTable2());
                                              // Get.offAll(() => const StockTable2());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'C/A Settlement',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Confirmation',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/purchaseapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fitWidth,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              // Get.to(() => FixAsset2());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'C/A Settlement',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //kotak putih kedua (sales approval)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              size.width * 0.03, //atur lebar kotak putih
                          vertical:
                              size.height * 0.02, //atur lokasi kotak putih
                        ),
                        height: size.height * 0.20, //atur panjang kotak putih
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.05),
                                  child: const Text(
                                    'Sales Approval',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                            // baris pertama
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 24),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/cashbankapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              Get.to(() => CashBank1());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'A/R Receipt',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Confirmation',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/cashbankapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              Get.to(() => CashBank1());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'Sales Order',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //kotak putih ketiga (purchase approval)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              size.width * 0.03, //atur lebar kotak putih
                          vertical:
                              size.height * 0.02, //atur lokasi kotak putih
                        ),
                        height: size.height * 0.40, //atur panjang kotak putih
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.05),
                                  child: const Text(
                                    'Purchase Approval',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                            // baris pertama
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/cashbankapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              Get.to(() => CashBank1());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'SPPBJ',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Confirmation',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/cashbankapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              Get.to(() => CashBank1());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'SPPBJ',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/salesapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              // Get.to(() => StockTable2());
                                              // Get.offAll(() => const StockTable2());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'PO SCM',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/purchaseapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fitWidth,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              // Get.to(() => FixAsset2());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'New Payable',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/cashbankapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              Get.to(() => CashBank1());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'D/P Request',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/cashbankapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              Get.to(() => CashBank1());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'A/P Refund',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/salesapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              // Get.to(() => StockTable2());
                                              // Get.offAll(() => const StockTable2());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'A/P Adjustment',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/purchaseapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fitWidth,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              // Get.to(() => FixAsset2());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'D/N to Supplier',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Ink.image(
                                          image: const AssetImage(
                                              'images/cashbankapp.png'),
                                          height: size.height * 0.05,
                                          width: size.width * 0.15,
                                          // fit: BoxFit.fill,
                                          child: InkWell(
                                            splashColor: Colors.black38,
                                            onTap: () async {
                                              Get.to(() => CashBank1());
                                            },
                                          ),
                                        ),
                                      ),
                                      const Column(
                                        children: [
                                          Text(
                                            'PO Exception',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Approval',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
