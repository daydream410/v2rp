import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/approval_screen/cash_bank/cash_advance_confirm/ca_confirm.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/dpreq_approval/dpreq_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/np_app/newap_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/sppbj_approval/sppbj_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/sppbj_confirm/sppbj_confirm.dart';
import 'package:v2rp1/FE/approval_screen/sales_approval/ar_app/ar_app.dart';
import 'package:v2rp1/FE/approval_screen/sales_approval/sales_order_app/sales_order_app.dart';

import '../../BE/controller.dart';
import 'cash_bank/ca_set_approval/ca_set_app.dart';
import 'cash_bank/ca_set_confirm/ca_set_confirm.dart';
import 'cash_bank/cash_advance_approval/ca_app.dart';
import 'purchase_approval/po_scm_approval/poscm_app.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  static TextControllers textControllers = Get.put(TextControllers());

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  bool selected = false;
  String idSelected = "";
  bool isVisible1 = true;
  bool isVisible2 = true;
  bool isVisible3 = true;
  bool isVisible4 = true;

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
        extendBody: true,
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
                      //tampil filter chip
                      Wrap(
                        spacing: 8,
                        direction: Axis.horizontal,
                        children: [
                          FilterChip(
                            label: const Text('All'),
                            backgroundColor: Colors.white,
                            // checkmarkColor: HexColor("#F4A62A"),
                            selected: (idSelected == "0") ? true : false,
                            onSelected: (bool value) {
                              setState(() {
                                idSelected = "0";
                                isVisible1 = true;
                                isVisible2 = true;
                                isVisible3 = true;
                                isVisible4 = true;
                              });
                            },
                          ),
                          FilterChip(
                            label: const Text('Cash & Bank Approval'),
                            backgroundColor: Colors.white,
                            // checkmarkColor: HexColor("#F4A62A"),
                            selected: (idSelected == "1") ? true : false,
                            onSelected: (bool value) {
                              setState(() {
                                idSelected = "1";
                                isVisible1 = true;
                                isVisible2 = false;
                                isVisible3 = false;
                                isVisible4 = false;
                              });
                            },
                          ),
                          FilterChip(
                            label: const Text('Sales Approval'),
                            backgroundColor: Colors.white,
                            // checkmarkColor: HexColor("#F4A62A"),
                            selected: (idSelected == "2") ? true : false,
                            onSelected: (bool value) {
                              setState(() {
                                idSelected = "2";
                                isVisible1 = false;
                                isVisible2 = true;
                                isVisible3 = false;
                                isVisible4 = false;
                              });
                            },
                          ),
                          FilterChip(
                            label: const Text('Purchase Approval'),
                            backgroundColor: Colors.white,
                            // checkmarkColor: HexColor("#F4A62A"),
                            selected: (idSelected == "3") ? true : false,
                            onSelected: (bool value) {
                              setState(() {
                                idSelected = "3";
                                isVisible1 = false;
                                isVisible2 = false;
                                isVisible3 = true;
                                isVisible4 = false;
                              });
                            },
                          ),
                          FilterChip(
                            label: const Text('Inventory Approval'),
                            backgroundColor: Colors.white,
                            // checkmarkColor: HexColor("#F4A62A"),
                            selected: (idSelected == "4") ? true : false,
                            onSelected: (bool value) {
                              setState(() {
                                idSelected = "4";
                                isVisible1 = false;
                                isVisible2 = false;
                                isVisible3 = false;
                                isVisible4 = true;
                              });
                            },
                          ),
                        ],
                      ),
                      //kotak putih pertama (cash & bank approval)
                      Visibility(
                        visible: isVisible1,
                        child: Container(
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
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
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
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                Get.to(
                                                    () => CashAdvanceConfirm());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'Cash',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Advance',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/cashadvanceapp.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                Get.to(() =>
                                                    CashAdvanceApproval());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'Cash',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Advance',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/casettlement.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                Get.to(() => CaSettleConfirm());

                                                // Get.to(() => StockTable2());
                                                // Get.offAll(() => const StockTable2());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'C/A',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Settlement',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/casettlementapp.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fitWidth,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                Get.to(() => CaSetApproval());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'C/A',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Settlement',
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
                      ),
                      //kotak putih kedua (sales approval)
                      Visibility(
                        visible: isVisible2,
                        child: Container(
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
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
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
                                    left: 34, right: 24, top: 24),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/arreceipt.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                Get.to(() => ArApproval());
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
                                              'Approval',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                Get.to(
                                                    () => SalesOrderApproval());
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
                      ),
                      //kotak putih ketiga (purchase approval)
                      Visibility(
                        visible: isVisible3,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                size.width * 0.03, //atur lebar kotak putih
                            vertical:
                                size.height * 0.02, //atur lokasi kotak putih
                          ),
                          height: size.height * 0.43, //atur panjang kotak putih
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
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/sppbj.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                Get.to(() => SppbjConfirm());
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/sppbjapp.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                Get.to(() => SppbjApp());
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/poscm.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                Get.to(() => PoScmApp());
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/newpayable.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fitWidth,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                Get.to(() => NpApp());
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/dpreqapp.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                Get.to(() => DpReqApp());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'D/P',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Request',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/aprefund.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                // Get.to(() => CashBank1());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'A/P',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Refund',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/apadjustmentapp.png'),
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
                                              'A/P',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Adjustment',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/dnsupplier.png'),
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
                                              'D/N to',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Supplier',
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
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: Ink.image(
                                              image: const AssetImage(
                                                  'images/poexception.png'),
                                              height: size.height * 0.05,
                                              width: size.width * 0.15,
                                              // fit: BoxFit.fill,
                                              child: InkWell(
                                                splashColor: Colors.black38,
                                                onTap: () async {
                                                  // Get.to(() => CashBank1());
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
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //kotak putih ke empat (purchase approval)
                      Visibility(
                        visible: isVisible4,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                size.width * 0.03, //atur lebar kotak putih
                            vertical:
                                size.height * 0.02, //atur lokasi kotak putih
                          ),
                          height: size.height * 0.63, //atur panjang kotak putih
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
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    child: const Text(
                                      'Inventory Approval',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/muapp.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                // Get.to(() => CashBank1());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'Material',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Used',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/grapp.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                // Get.to(() => CashBank1());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'Goods',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Received',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/itapp.png'),
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
                                              'Internal',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Transfer',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/smapp.png'),
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
                                              'Stock',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Movement',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/stockadjapp.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                // Get.to(() => CashBank1());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'Stock',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Adjustment',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/stockmerger.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                // Get.to(() => CashBank1());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'Stock',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Merger',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/assembling.png'),
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
                                              'Assembling',
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
                                            SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/materialreturnapp.png'),
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
                                              'Material',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Return',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/stocktransferapp.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                // Get.to(() => CashBank1());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'Stock',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Transfer',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/itstockadj.png'),
                                            height: size.height * 0.05,
                                            width: size.width * 0.15,
                                            // fit: BoxFit.fill,
                                            child: InkWell(
                                              splashColor: Colors.black38,
                                              onTap: () async {
                                                // Get.to(() => CashBank1());
                                              },
                                            ),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            Text(
                                              'IT/Stock',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Adjustment',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/stockpriceapp.png'),
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
                                              'Stock',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Price',
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Ink.image(
                                            image: const AssetImage(
                                                'images/updateminmax.png'),
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
                                              'Update Min',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Max Stock',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              'Parameter',
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
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            child: Ink.image(
                                              image: const AssetImage(
                                                  'images/stocktopup.png'),
                                              height: size.height * 0.05,
                                              width: size.width * 0.15,
                                              // fit: BoxFit.fill,
                                              child: InkWell(
                                                splashColor: Colors.black38,
                                                onTap: () async {
                                                  // Get.to(() => CashBank1());
                                                },
                                              ),
                                            ),
                                          ),
                                          const Column(
                                            children: [
                                              Text(
                                                'Stock',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Top Up',
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
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
