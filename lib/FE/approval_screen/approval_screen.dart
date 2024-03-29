import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/approval_screen/cash_bank/cash_advance_confirm/ca_confirm.dart';
import 'package:v2rp1/FE/approval_screen/inventory_approval/gr_approval/gr_app.dart';
import 'package:v2rp1/FE/approval_screen/inventory_approval/it_approval/it_app.dart';
import 'package:v2rp1/FE/approval_screen/inventory_approval/sm_approval/sm_app.dart';
import 'package:v2rp1/FE/approval_screen/inventory_approval/stock_trf_approval/stocktrf_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/ap_adjustment/apadj_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/ap_refund/ap_refund.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/dn_approval/dn_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/dpreq_approval/dpreq_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/np_app/newap_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/po_ex_approval/poex_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/poscm_unapproved/poscm_unapproved.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/sppbj_approval/sppbj_app.dart';
import 'package:v2rp1/FE/approval_screen/purchase_approval/sppbj_confirm/sppbj_confirm.dart';
import 'package:v2rp1/FE/approval_screen/sales_approval/ar_app/ar_app.dart';
import 'package:v2rp1/FE/approval_screen/sales_approval/sales_order_app/sales_order_app.dart';
import 'package:badges/badges.dart' as badges;
import '../../BE/controller.dart';
import '../../BE/reqip.dart';
import '../../BE/resD.dart';
import '../../main.dart';
import '../mainScreen/login_screen4.dart';
import 'cash_bank/ca_set_approval/ca_set_app.dart';
import 'cash_bank/ca_set_confirm/ca_set_confirm.dart';
import 'cash_bank/cash_advance_approval/ca_app.dart';
import 'inventory_approval/assembling_approval/asmb_app.dart';
import 'inventory_approval/itstock_adj_approval/itstock_app.dart';
import 'inventory_approval/mr_approval/mr_app.dart';
import 'inventory_approval/mu_approval/mu_app.dart';
import 'inventory_approval/stock_topup_approval/topup_app.dart';
import 'inventory_approval/stockadj_approval/stockadj_app.dart';
import 'inventory_approval/stockprice_approval/stockprice_app.dart';
import 'inventory_approval/update_minmax_approval/minmax_app.dart';
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
  bool notZero = true;
  int totalSC = 0;
  int totalSA = 0;
  int totalPA = 0;
  int totalPOE = 0;
  int totalPNE = 0;
  int totalKC = 0;
  int totalKA = 0;
  int totalKDA = 0;
  int totalKD = 0;
  int totalLC = 0;
  int totalLA = 0;
  int totalMUA = 0;
  int totalITA = 0;
  int totalMRA = 0;
  int totalGRA = 0;
  int totalSTA = 0;
  int totalSMA = 0;
  int totalSAA = 0;
  int totalSPA = 0;
  int totalMMU = 0;
  int totalSTUA = 0;
  int totalDNA = 0;
  int totalAPRA = 0;
  int totalDPA = 0;
  int totalSOA = 0;
  int totalAPAA = 0;
  int totalAA = 0;
  int totalNA = 0;
  int totalARRA = 0;
  int totalITSA = 0;
  int totalSTSA = 0;
  int poGabung = 0;
  int itGabung = 0;
  int totalPOS = 0;
  int totalPNS = 0;
  int supplierGabung = 0;

  static late List dataaa = <CaConfirmData>[];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      getDataa();
    });
  }

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
        body: LiquidPullToRefresh(
          onRefresh: getDataa2,
          color: HexColor("#F4A62A"),
          height: 150,
          showChildOpacityTransition: false,
          child: SingleChildScrollView(
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
                            height:
                                size.height * 0.20, //atur panjang kotak putih
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalKC == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalKC.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalKC == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            CashAdvanceConfirm());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalKA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalKA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalKA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            CashAdvanceApproval());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalLC == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalLC.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalLC == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            const CaSettleConfirm());

                                                    // Get.to(() => StockTable2());
                                                    // Get.offAll(() => const StockTable2());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalLA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalLA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalLA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            CaSetApproval());
                                                  },
                                                ),
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
                            height:
                                size.height * 0.20, //atur panjang kotak putih
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalARRA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalARRA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalARRA == 0
                                                        ? wakwaw()
                                                        : Get.to(
                                                            () => ArApproval());
                                                  },
                                                ),
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
                                      // const SizedBox(
                                      //   width: 20,
                                      // ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalSOA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalSOA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalSOA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            SalesOrderApproval());
                                                  },
                                                ),
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
                                      Column(
                                        //colum buat ngisi space kosong
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.37,
                                          ),
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
                            height:
                                size.height * 0.50, //atur panjang kotak putih
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalSC == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalSC.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalSC == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            SppbjConfirm());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalSA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalSA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalSA == 0
                                                        ? wakwaw()
                                                        : Get.to(
                                                            () => SppbjApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalPA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalPA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalPA == 0
                                                        ? wakwaw()
                                                        : Get.to(
                                                            () => PoScmApp());
                                                    // Get.offAll(() => const StockTable2());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalNA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalNA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalNA == 0
                                                        ? wakwaw()
                                                        : Get.to(() => NpApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalDPA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalDPA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalDPA == 0
                                                        ? wakwaw()
                                                        : Get.to(
                                                            () => DpReqApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalAPRA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalAPRA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalAPRA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            ApRefundApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalAPAA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalAPAA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalAPAA == 0
                                                        ? wakwaw()
                                                        : Get.to(
                                                            () => ApAdjApp());

                                                    // Get.to(() => StockTable2());
                                                    // Get.offAll(() => const StockTable2());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalDNA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalDNA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalDNA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            DebitNotesApp());
                                                  },
                                                ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                poGabung == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              poGabung.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    poGabung == 0
                                                        ? wakwaw()
                                                        : Get.to(
                                                            () => PoExApp());
                                                  },
                                                ),
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
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge: supplierGabung == 0
                                                ? false
                                                : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              supplierGabung.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: Ink.image(
                                                image: const AssetImage(
                                                    'images/supplier.png'),
                                                height: size.height * 0.05,
                                                width: size.width * 0.15,
                                                // fit: BoxFit.fill,
                                                child: InkWell(
                                                  splashColor: Colors.black38,
                                                  onTap: () async {
                                                    supplierGabung == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            PoUnapproved());
                                                  },
                                                ),
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
                                                'Supplier Unapp',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'roved Approval',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        //colum buat ngisi space kosong
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.37,
                                          ),
                                        ],
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
                            height:
                                size.height * 0.50, //atur panjang kotak putih
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalMUA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalMUA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalMUA == 0
                                                        ? wakwaw()
                                                        : Get.to(() => MuApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalGRA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalGRA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalGRA == 0
                                                        ? wakwaw()
                                                        : Get.to(() => GrApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalITA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalITA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalITA == 0
                                                        ? wakwaw()
                                                        : Get.to(() => ItApp());
                                                    // Get.offAll(() => const StockTable2());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalSMA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalSMA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalSMA == 0
                                                        ? wakwaw()
                                                        : Get.to(() => SmApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalSAA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalSAA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalSAA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            StockAdjApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalSTUA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalSTUA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalSTUA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            StockTopupApp());
                                                  },
                                                ),
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
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalAA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalAA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalAA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            AssemblingApp());
                                                    // Get.offAll(() => const StockTable2());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalMRA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalMRA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalMRA == 0
                                                        ? wakwaw()
                                                        : Get.to(() => MrApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalSTA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalSTA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalSTA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            StockTrfApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                itGabung == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              itGabung.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    itGabung == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            ItStockAdjApp());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalSPA == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalSPA.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    totalSPA == 0
                                                        ? wakwaw()
                                                        : Get.to(() =>
                                                            StockPriceApp());
                                                    // Get.offAll(() => const StockTable2());
                                                  },
                                                ),
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
                                          badges.Badge(
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -12),
                                            showBadge:
                                                totalMMU == 0 ? false : true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              totalMMU.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            badgeAnimation: const badges
                                                .BadgeAnimation.rotation(
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              colorChangeAnimationDuration:
                                                  Duration(seconds: 1),
                                              loopAnimation: false,
                                              curve: Curves.fastOutSlowIn,
                                              colorChangeAnimationCurve:
                                                  Curves.easeInCubic,
                                            ),
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              badgeColor: Colors.red,
                                              padding: const EdgeInsets.all(5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2),
                                              elevation: 0,
                                            ),
                                            child: Material(
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
                                                    Get.to(totalMMU == 0
                                                        ? wakwaw()
                                                        : () =>
                                                            UpdateMinMaxApp());
                                                  },
                                                ),
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
                                // stock merger
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 24, right: 24, top: 24),
                                //   child: Row(
                                //     // mainAxisAlignment:
                                //     //     MainAxisAlignment.spaceAround,
                                //     children: [
                                //       Padding(
                                //         padding: const EdgeInsets.only(left: 12),
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             badges.Badge(
                                //               position:
                                //                   badges.BadgePosition.topEnd(
                                //                       top: -10, end: -12),
                                //               showBadge: false,
                                //               ignorePointer: false,
                                //               badgeContent: Text(
                                //                 totalSA.toString(),
                                //                 style: const TextStyle(
                                //                   color: Colors.white,
                                //                   fontSize: 10.0,
                                //                 ),
                                //               ),
                                //               badgeAnimation: const badges
                                //                   .BadgeAnimation.rotation(
                                //                 animationDuration:
                                //                     Duration(seconds: 1),
                                //                 colorChangeAnimationDuration:
                                //                     Duration(seconds: 1),
                                //                 loopAnimation: false,
                                //                 curve: Curves.fastOutSlowIn,
                                //                 colorChangeAnimationCurve:
                                //                     Curves.easeInCubic,
                                //               ),
                                //               badgeStyle: badges.BadgeStyle(
                                //                 shape: badges.BadgeShape.square,
                                //                 badgeColor: Colors.red,
                                //                 padding: const EdgeInsets.all(5),
                                //                 borderRadius:
                                //                     BorderRadius.circular(20),
                                //                 borderSide: const BorderSide(
                                //                     color: Colors.white,
                                //                     width: 2),
                                //                 elevation: 0,
                                //               ),
                                //               child: Material(
                                //                 borderRadius:
                                //                     BorderRadius.circular(20),
                                //                 clipBehavior:
                                //                     Clip.antiAliasWithSaveLayer,
                                //                 child: Ink.image(
                                //                   image: const AssetImage(
                                //                       'images/stockmerger.png'),
                                //                   height: size.height * 0.05,
                                //                   width: size.width * 0.15,
                                //                   // fit: BoxFit.fill,
                                //                   child: InkWell(
                                //                     splashColor: Colors.black38,
                                //                     onTap: () async {
                                //                       // Get.to(() => CashBank1());
                                //                     },
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //             const Column(
                                //               children: [
                                //                 Text(
                                //                   'Stock',
                                //                   style: TextStyle(
                                //                     fontSize: 12,
                                //                   ),
                                //                 ),
                                //                 Text(
                                //                   'Merger',
                                //                   style: TextStyle(
                                //                     fontSize: 12,
                                //                   ),
                                //                 ),
                                //                 Text(
                                //                   'Approval',
                                //                   style: TextStyle(
                                //                     fontSize: 12,
                                //                   ),
                                //                 ),
                                //               ],
                                //             )
                                //           ],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
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
      ),
    );
  }

  Future<void> getDataa() async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;

    try {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Fetching Approval Data...',
        text: 'Please Wait Until Success Notification is Displayed',
        barrierDismissible: false,
        customAsset: 'images/loading.gif',
        headerBackgroundColor: HexColor("#F4A62A"),
        confirmBtnColor: HexColor("#F4A62A"),
        // autoCloseDuration: const Duration(seconds: 5),
        // headerBackgroundColor: Colors.white,
      );
      // http://156.67.217.113/api/v1/mobile
      var getData = await http.get(
        Uri.https('v2rp.net', '/api/v1/mobile/notif'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );

      final responseData = json.decode(getData.body);
      print("getdataaaa " + responseData.toString());
      if (mounted) {
        setState(() {
          dataaa = responseData['data'];
          // totalSC = dataaa.length;
        });
      }
      if (responseData['kode'] == '77') {
        autoLogout();
      }
      totalSC = 0;
      totalSA = 0;
      totalPA = 0;
      totalPOE = 0;
      totalPNE = 0;
      totalKC = 0;
      totalKA = 0;
      totalKDA = 0;
      totalKD = 0;
      totalLC = 0;
      totalLA = 0;
      totalMUA = 0;
      totalITA = 0;
      totalMRA = 0;
      totalGRA = 0;
      totalSTA = 0;
      totalSMA = 0;
      totalSAA = 0;
      totalSPA = 0;
      totalMMU = 0;
      totalSTUA = 0;
      totalDNA = 0;
      totalAPRA = 0;
      totalDPA = 0;
      totalSOA = 0;
      totalAPAA = 0;
      totalAA = 0;
      totalNA = 0;
      totalARRA = 0;
      totalITSA = 0;
      totalSTSA = 0;
      poGabung = 0;
      totalPOS = 0;
      totalPNS = 0;
      supplierGabung = 0;
      for (var item in dataaa) {
        if (item['tipe'] == 'SC') {
          totalSC += 1;
        } else if (item['tipe'] == 'SA') {
          totalSA += 1;
        } else if (item['tipe'] == 'PA') {
          totalPA += 1;
        } else if (item['tipe'] == 'POE') {
          totalPOE += 1;
        } else if (item['tipe'] == 'PNE') {
          totalPNE += 1;
        } else if (item['tipe'] == 'KC') {
          totalKC += 1;
        } else if (item['tipe'] == 'KA') {
          totalKA += 1;
        } else if (item['tipe'] == 'KDA') {
          totalKDA += 1;
        } else if (item['tipe'] == 'KD') {
          totalKD += 1;
        } else if (item['tipe'] == 'LC') {
          totalLC += 1;
        } else if (item['tipe'] == 'LA') {
          totalLA += 1;
        } else if (item['tipe'] == 'MUA') {
          totalMUA += 1;
        } else if (item['tipe'] == 'ITA') {
          totalITA += 1;
        } else if (item['tipe'] == 'MRA') {
          totalMRA += 1;
        } else if (item['tipe'] == 'GRA') {
          totalGRA += 1;
        } else if (item['tipe'] == 'STA') {
          totalSTA += 1;
        } else if (item['tipe'] == 'SMA') {
          totalSMA += 1;
        } else if (item['tipe'] == 'SAA') {
          totalSAA += 1;
        } else if (item['tipe'] == 'SPA') {
          totalSPA += 1;
        } else if (item['tipe'] == 'MMU') {
          totalMMU += 1;
        } else if (item['tipe'] == 'STUA') {
          totalSTUA += 1;
        } else if (item['tipe'] == 'DNA') {
          totalDNA += 1;
        } else if (item['tipe'] == 'APRA') {
          totalAPRA += 1;
        } else if (item['tipe'] == 'DPA') {
          totalDPA += 1;
        } else if (item['tipe'] == 'SOA') {
          totalSOA += 1;
        } else if (item['tipe'] == 'APAA') {
          totalAPAA += 1;
        } else if (item['tipe'] == 'AA') {
          totalAA += 1;
        } else if (item['tipe'] == 'NA') {
          totalNA += 1;
        } else if (item['tipe'] == 'ARRA') {
          totalARRA += 1;
        } else if (item['tipe'] == 'ITSA') {
          totalITSA += 1;
        } else if (item['tipe'] == 'STSA') {
          totalSTSA += 1;
        } else if (item['tipe'] == 'POS') {
          totalPOS += 1;
        } else if (item['tipe'] == 'PNS') {
          totalPNS += 1;
        }
      }
      poGabung = totalPOE + totalPNE;
      itGabung = totalITSA + totalSTSA;
      supplierGabung = totalPOS + totalPNS;
      // print("totalPOS = " + totalPOS.toString());
      // print("totalPNS = " + totalPNS.toString());
      // print("supplierGabung = " + supplierGabung.toString());
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Fetching Approval Data',
        barrierDismissible: false,
        // onConfirmBtnTap: () {
        //   Get.to(Navbar());
        // },
        // onConfirmBtnTap:
      );
      // final SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      // sharedPreferences.setInt('totalSC', totalSC);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getDataa2() async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;

    try {
      // http://156.67.217.113/api/v1/mobile
      var getData = await http.get(
        Uri.https('v2rp.net', '/api/v1/mobile/notif'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );

      final responseData = json.decode(getData.body);
      print("getdataaaa " + responseData.toString());
      if (mounted) {
        setState(() {
          dataaa = responseData['data'];
          // totalSC = dataaa.length;
        });
      }
      if (responseData['kode'] == '77') {
        autoLogout();
      }
      totalSC = 0;
      totalSA = 0;
      totalPA = 0;
      totalPOE = 0;
      totalPNE = 0;
      totalKC = 0;
      totalKA = 0;
      totalKDA = 0;
      totalKD = 0;
      totalLC = 0;
      totalLA = 0;
      totalMUA = 0;
      totalITA = 0;
      totalMRA = 0;
      totalGRA = 0;
      totalSTA = 0;
      totalSMA = 0;
      totalSAA = 0;
      totalSPA = 0;
      totalMMU = 0;
      totalSTUA = 0;
      totalDNA = 0;
      totalAPRA = 0;
      totalDPA = 0;
      totalSOA = 0;
      totalAPAA = 0;
      totalAA = 0;
      totalNA = 0;
      totalARRA = 0;
      totalITSA = 0;
      totalSTSA = 0;
      poGabung = 0;
      totalPOS = 0;
      totalPNS = 0;
      supplierGabung = 0;
      for (var item in dataaa) {
        if (item['tipe'] == 'SC') {
          totalSC += 1;
        } else if (item['tipe'] == 'SA') {
          totalSA += 1;
        } else if (item['tipe'] == 'PA') {
          totalPA += 1;
        } else if (item['tipe'] == 'POE') {
          totalPOE += 1;
        } else if (item['tipe'] == 'PNE') {
          totalPNE += 1;
        } else if (item['tipe'] == 'KC') {
          totalKC += 1;
        } else if (item['tipe'] == 'KA') {
          totalKA += 1;
        } else if (item['tipe'] == 'KDA') {
          totalKDA += 1;
        } else if (item['tipe'] == 'KD') {
          totalKD += 1;
        } else if (item['tipe'] == 'LC') {
          totalLC += 1;
        } else if (item['tipe'] == 'LA') {
          totalLA += 1;
        } else if (item['tipe'] == 'MUA') {
          totalMUA += 1;
        } else if (item['tipe'] == 'ITA') {
          totalITA += 1;
        } else if (item['tipe'] == 'MRA') {
          totalMRA += 1;
        } else if (item['tipe'] == 'GRA') {
          totalGRA += 1;
        } else if (item['tipe'] == 'STA') {
          totalSTA += 1;
        } else if (item['tipe'] == 'SMA') {
          totalSMA += 1;
        } else if (item['tipe'] == 'SAA') {
          totalSAA += 1;
        } else if (item['tipe'] == 'SPA') {
          totalSPA += 1;
        } else if (item['tipe'] == 'MMU') {
          totalMMU += 1;
        } else if (item['tipe'] == 'STUA') {
          totalSTUA += 1;
        } else if (item['tipe'] == 'DNA') {
          totalDNA += 1;
        } else if (item['tipe'] == 'APRA') {
          totalAPRA += 1;
        } else if (item['tipe'] == 'DPA') {
          totalDPA += 1;
        } else if (item['tipe'] == 'SOA') {
          totalSOA += 1;
        } else if (item['tipe'] == 'APAA') {
          totalAPAA += 1;
        } else if (item['tipe'] == 'AA') {
          totalAA += 1;
        } else if (item['tipe'] == 'NA') {
          totalNA += 1;
        } else if (item['tipe'] == 'ARRA') {
          totalARRA += 1;
        } else if (item['tipe'] == 'ITSA') {
          totalITSA += 1;
        } else if (item['tipe'] == 'STSA') {
          totalSTSA += 1;
        } else if (item['tipe'] == 'POS') {
          totalPOS += 1;
        } else if (item['tipe'] == 'PNS') {
          totalPNS += 1;
        }
      }
      poGabung = totalPOE + totalPNE;
      itGabung = totalITSA + totalSTSA;
      supplierGabung = totalPOS + totalPNS;
      // print("totalPOS = " + totalPOS.toString());
      // print("totalPNS = " + totalPNS.toString());
      // print("supplierGabung = " + supplierGabung.toString());
    } catch (e) {
      print(e);
    }
  }

  Future autoLogout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('username');
    sharedPreferences.remove('email');
    sharedPreferences.remove('password');
    sharedPreferences.remove('kulonuwun');
    sharedPreferences.remove('monggo');
    await sharedPreferences.clear();
    Get.offAll(() => const LoginPage4());
    Get.snackbar(
      "Session Time Out",
      "Please Re-login",
      colorText: Colors.white,
      icon: const Icon(
        Icons.logout,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
      isDismissible: true,
      dismissDirection: DismissDirection.vertical,
    );
  }

  Future wakwaw() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      text: 'No Approval Data',
      barrierDismissible: false,
      confirmBtnText: 'Okay',
    );
  }
}
