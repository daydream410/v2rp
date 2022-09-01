// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/FA/fixasset2.dart';
import 'package:v2rp1/FE/OTP/otp.dart';
import 'package:v2rp1/FE/OTP/otp2.dart';
// import 'package:v2rp1/FE/GR/goods_receive.dart';
// import 'package:v2rp1/FE/IT/internal_transfer.dart';
// import 'package:v2rp1/FE/MU/scan_mu.dart';
// import 'package:v2rp1/FE/SM/stock_movement.dart';
// import 'package:v2rp1/FE/SO/stock_opname.dart';
// import 'package:v2rp1/FE/ST/stock_transfer.dart';
import 'package:v2rp1/FE/StockTable/stocktable2.dart';
import 'package:v2rp1/FE/VB/vendor_barcode.dart';
import 'package:v2rp1/FE/VB/vendor_barcode1.dart';
import 'package:v2rp1/additional/mt_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are You sure?'),
            content: Text('Do you want to exit the App?'),
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
          title: const Text("V2RP Mobile"),
          elevation: 0,
          backgroundColor: HexColor("#F4A62A"),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
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
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 90,
                  ),
                  //ukuran kotak putih
                  height: size.height * 0.60,
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
                        'Main Menu',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      SizedBox(height: 30.0),

                      ///row 1---------------------------
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
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
                                    image: AssetImage('images/ic_gr.png'),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        // Get.to(GoodsReceive());
                                        Get.to(MaintenanceScreen());
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Text('Goods'),
                                    Text('Received'),
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
                                    image: AssetImage('images/ic_mu.png'),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        // Get.to(ScanWh());
                                        // Get.to(MaintenanceScreen());
                                        Get.to(OtpScreen2());
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Text('Material'),
                                    Text('Use'),
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
                                    image: AssetImage('images/ic_it.png'),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        // Get.to(InternalTransfer());
                                        Get.to(MaintenanceScreen());
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Text('Internal'),
                                    Text('Transfer'),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      ///row 2----------------------
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
                                    image: AssetImage('images/ic_sm.png'),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        // Get.to(StockMovement());
                                        Get.to(MaintenanceScreen());
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Text('Stock'),
                                    Text('Movement'),
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
                                    image: AssetImage('images/ic_trans.png'),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        // Get.to(StockTransfer());
                                        Get.to(MaintenanceScreen());
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Text('Stock'),
                                    Text('Transfer'),
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
                                    image: AssetImage('images/is_so.png'),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        // Get.to(StockOpname());
                                        Get.to(MaintenanceScreen());
                                      },
                                    ),
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Text('Stock'),
                                    Text('Opname'),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

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
                                    image:
                                        AssetImage('images/barcoderegist.png'),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
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
                                    image: AssetImage('images/ic_st.png'),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
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
                                    image: AssetImage('images/fixedassets.png'),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Column(
                      //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       ///////////////////row pertama
                      //       SizedBox(height: 10.0),
                      //       Text(
                      //         'Main Menu',
                      //         textAlign: TextAlign.left,
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold, fontSize: 20.0),
                      //       ),
                      //       SizedBox(height: 30.0),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Material(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                 child: Ink.image(
                      //                   image: AssetImage('images/ic_gr.png'),
                      //                   height: 80,
                      //                   width: 80,
                      //                   fit: BoxFit.fill,
                      //                   child: InkWell(
                      //                     splashColor: Colors.black38,
                      //                     onTap: () async {
                      //                       Get.to(GoodsReceive());
                      //                     },
                      //                   ),
                      //                 ),
                      //               ),
                      //               Text('Goods Received')
                      //             ],
                      //           ),
                      //           Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Material(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                 child: Ink.image(
                      //                   image: AssetImage('images/ic_mu.png'),
                      //                   height: 80,
                      //                   width: 80,
                      //                   fit: BoxFit.fill,
                      //                   child: InkWell(
                      //                     splashColor: Colors.black38,
                      //                     onTap: () async {
                      //                       Get.to(ScanWh());
                      //                     },
                      //                   ),
                      //                 ),
                      //               ),
                      //               Text('Material Use')
                      //             ],
                      //           ),
                      //           Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Material(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                 child: Ink.image(
                      //                   image: AssetImage('images/ic_it.png'),
                      //                   height: 80,
                      //                   width: 80,
                      //                   fit: BoxFit.fill,
                      //                   child: InkWell(
                      //                     splashColor: Colors.black38,
                      //                     onTap: () async {
                      //                       Get.to(InternalTransfer());
                      //                     },
                      //                   ),
                      //                 ),
                      //               ),
                      //               Text('Internal Transfer')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       /////////////////////////Row kedua
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Material(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                 child: Ink.image(
                      //                   image: AssetImage('images/ic_sm.png'),
                      //                   height: 80,
                      //                   width: 80,
                      //                   fit: BoxFit.fill,
                      //                   child: InkWell(
                      //                     splashColor: Colors.black38,
                      //                     onTap: () async {
                      //                       Get.to(StockMovement());
                      //                     },
                      //                   ),
                      //                 ),
                      //               ),
                      //               Text('Stock Movement')
                      //             ],
                      //           ),
                      //           Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Material(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                 child: Ink.image(
                      //                   image: AssetImage('images/ic_st.png'),
                      //                   height: 80,
                      //                   width: 80,
                      //                   fit: BoxFit.fill,
                      //                   child: InkWell(
                      //                     splashColor: Colors.black38,
                      //                     onTap: () async {
                      //                       Get.to(StockTransfer());
                      //                     },
                      //                   ),
                      //                 ),
                      //               ),
                      //               Text('Stock Transfer')
                      //             ],
                      //           ),
                      //           Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Material(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                 child: Ink.image(
                      //                   image: AssetImage('images/ic_st.png'),
                      //                   height: 80,
                      //                   width: 80,
                      //                   fit: BoxFit.fill,
                      //                   child: InkWell(
                      //                     splashColor: Colors.black38,
                      //                     onTap: () async {
                      //                       Get.to(StockOpname());
                      //                     },
                      //                   ),
                      //                 ),
                      //               ),
                      //               Text('Stock Opname')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(left: 12),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 Material(
                      //                   borderRadius: BorderRadius.circular(20),
                      //                   clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                   child: Ink.image(
                      //                     image: AssetImage(
                      //                         'images/barcoderegist.png'),
                      //                     height: 80,
                      //                     width: 80,
                      //                     fit: BoxFit.fill,
                      //                     child: InkWell(
                      //                       splashColor: Colors.black38,
                      //                       onTap: () async {
                      //                         Get.to(() => VendorBarcode());
                      //                       },
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Text('Barcode'),
                      //                 Text('Registration'),
                      //               ],
                      //             ),
                      //             Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 Material(
                      //                   borderRadius: BorderRadius.circular(20),
                      //                   clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                   child: Ink.image(
                      //                     image: AssetImage('images/ic_st.png'),
                      //                     height: 80,
                      //                     width: 80,
                      //                     fit: BoxFit.fill,
                      //                     child: InkWell(
                      //                       splashColor: Colors.black38,
                      //                       onTap: () async {
                      //                         Get.to(() => StockTable2());
                      //                       },
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Text('Stock'),
                      //                 Text('Table'),
                      //               ],
                      //             ),
                      //             Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 Material(
                      //                   borderRadius: BorderRadius.circular(20),
                      //                   clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                   child: Ink.image(
                      //                     image:
                      //                         AssetImage('images/fixedassets.png'),
                      //                     height: 80,
                      //                     width: 80,
                      //                     fit: BoxFit.fill,
                      //                     child: InkWell(
                      //                       splashColor: Colors.black38,
                      //                       onTap: () async {
                      //                         Get.to(() => FixAsset2());
                      //                       },
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Text('Fixed'),
                      //                 Text('Assets'),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
