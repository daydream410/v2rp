// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/home_screen/FA/fixasset2.dart';
// import 'package:v2rp1/FE/MU/material_use.dart';
// import 'package:v2rp1/FE/SO/stock_opname.dart';
import 'package:v2rp1/FE/home_screen/StockTable/stocktable2.dart';
import 'package:v2rp1/FE/home_screen/VB/vendor_barcode1.dart';
// import 'package:v2rp1/FE/notif/notif_screen.dart';

import '../../BE/controller.dart';
// import '../../additional/mt_screen.dart';
// import '../GR/goods_receive.dart';
// import '../IT/internal_transfer.dart';
// import '../SM/stock_movement.dart';
// import '../ST/stock_transfer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static TextControllers textControllers = Get.put(TextControllers());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int counterNotif = NotifScreen.countNotif;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are You sure?'),
            content: Text('Do you want to exit V2RP Mobile?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
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
          title: Text("V2RP Mobile"),
          elevation: 0,
          backgroundColor: HexColor("#F4A62A"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: size.height * 0.2,
                decoration: BoxDecoration(
                    color: HexColor("#F4A62A"),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(46),
                      bottomRight: Radius.circular(46),
                    )),
              ),
              Positioned(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08, //atur lebar kotak putih
                    vertical: size.height * 0.02, //atur lokasi kotak putih
                  ),
                  //ukuran kotak putih
                  // height: size.height * 0.70,
                  height: size.height * 0.35,
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
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///////////////////row pertama
                      SizedBox(height: 10.0),
                      Text(
                        'Entry Menu',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      SizedBox(height: 30.0),

                      ///row 1---------------------------
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 24, right: 24),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Material(
                      //             borderRadius: BorderRadius.circular(20),
                      //             clipBehavior: Clip.antiAliasWithSaveLayer,
                      //             child: Ink.image(
                      //               image: AssetImage('images/ic_gr.jpg'),
                      //               height: size.height * 0.11,
                      //               width: size.width * 0.21,
                      //               fit: BoxFit.fill,
                      //               child: InkWell(
                      //                 splashColor: Colors.black38,
                      //                 onTap: () async {
                      //                   // Get.to(GoodsReceive());
                      //                   Get.to(MaintenanceScreen());
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //           Column(
                      //             children: const [
                      //               Text('Goods'),
                      //               Text('Received'),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //       Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Material(
                      //             borderRadius: BorderRadius.circular(20),
                      //             clipBehavior: Clip.antiAliasWithSaveLayer,
                      //             child: Ink.image(
                      //               image: AssetImage('images/ic_mu.jpg'),
                      //               height: size.height * 0.11,
                      //               width: size.width * 0.21,
                      //               fit: BoxFit.fill,
                      //               child: InkWell(
                      //                 splashColor: Colors.black38,
                      //                 onTap: () async {
                      //                   // Get.to(ScanWh());
                      //                   Get.to(MaintenanceScreen());
                      //                   // Get.to(OtpScreen2());
                      //                   // Get.to(MaterialUse());
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //           Column(
                      //             children: const [
                      //               Text('Material'),
                      //               Text('Use'),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //       Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Material(
                      //             borderRadius: BorderRadius.circular(20),
                      //             clipBehavior: Clip.antiAliasWithSaveLayer,
                      //             child: Ink.image(
                      //               image: AssetImage('images/ic_it.jpg'),
                      //               height: size.height * 0.11,
                      //               width: size.width * 0.21,
                      //               fit: BoxFit.fill,
                      //               child: InkWell(
                      //                 splashColor: Colors.black38,
                      //                 onTap: () async {
                      //                   // Get.to(InternalTransfer());
                      //                   Get.to(MaintenanceScreen());
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //           Column(
                      //             children: const [
                      //               Text('Internal'),
                      //               Text('Transfer'),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // // ///row 2----------------------
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 24, right: 24, top: 24),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Material(
                      //             borderRadius: BorderRadius.circular(20),
                      //             clipBehavior: Clip.antiAliasWithSaveLayer,
                      //             child: Ink.image(
                      //               image: AssetImage('images/ic_sm.jpg'),
                      //               height: size.height * 0.11,
                      //               width: size.width * 0.21,
                      //               fit: BoxFit.fill,
                      //               child: InkWell(
                      //                 splashColor: Colors.black38,
                      //                 onTap: () async {
                      //                   // Get.to(StockMovement());
                      //                   Get.to(MaintenanceScreen());
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //           Column(
                      //             children: const [
                      //               Text('Stock'),
                      //               Text('Movement'),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //       Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Material(
                      //             borderRadius: BorderRadius.circular(20),
                      //             clipBehavior: Clip.antiAliasWithSaveLayer,
                      //             child: Ink.image(
                      //               image: AssetImage('images/ic_TRANS.jpg'),
                      //               height: size.height * 0.11,
                      //               width: size.width * 0.21,
                      //               fit: BoxFit.fill,
                      //               child: InkWell(
                      //                 splashColor: Colors.black38,
                      //                 onTap: () async {
                      //                   // Get.to(StockTransfer());
                      //                   Get.to(MaintenanceScreen());
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //           Column(
                      //             children: const [
                      //               Text('Stock'),
                      //               Text('Transfer'),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //       Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Material(
                      //             borderRadius: BorderRadius.circular(20),
                      //             clipBehavior: Clip.antiAliasWithSaveLayer,
                      //             child: Ink.image(
                      //               image: AssetImage('images/is_so.png'),
                      //               height: size.height * 0.11,
                      //               width: size.width * 0.21,
                      //               fit: BoxFit.fill,
                      //               child: InkWell(
                      //                 splashColor: Colors.black38,
                      //                 onTap: () async {
                      //                   // Get.to(StockOpname());
                      //                   Get.to(MaintenanceScreen());
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //           Column(
                      //             children: const [
                      //               Text('Stock'),
                      //               Text('Opname'),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      ///row 3----------------------
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(20),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Ink.image(
                                    image: AssetImage('images/barcodenew.png'),
                                    height: size.height * 0.11,
                                    width: size.width * 0.21,
                                    // fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        Get.to(() => VendorBarcode1());
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Text('Barcode'),
                                    Text('Registration'),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(20),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Ink.image(
                                    image:
                                        AssetImage('images/stocktablenew.png'),
                                    height: size.height * 0.11,
                                    width: size.width * 0.21,
                                    // fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        // Get.to(() => StockTable2());
                                        Get.offAll(() => const StockTable2());
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Text('Stock'),
                                    Text('Table'),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(20),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Ink.image(
                                    image: AssetImage('images/fixedasset.png'),
                                    height: size.height * 0.11,
                                    width: size.width * 0.21,
                                    // fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        Get.to(() => FixAsset2());
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Text('Fixed'),
                                    Text('Assets'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
