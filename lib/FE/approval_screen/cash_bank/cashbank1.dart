import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';

class CashBank1 extends StatefulWidget {
  CashBank1({Key? key}) : super(key: key);

  @override
  State<CashBank1> createState() => _CashBank1State();
}

class _CashBank1State extends State<CashBank1> {
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.off(const Navbar());
            },
          ),
          automaticallyImplyLeading: false,
          title: const Text("Cash & Bank Approval"),
          elevation: 0,
          backgroundColor: HexColor("#F4A62A"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: size.height * 0.2, //atur panjang kotak kuning atas
                decoration: BoxDecoration(
                    color: HexColor("#F4A62A"),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      // bottomRight: Radius.circular(45),
                    )),
              ),
              Positioned(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08, //atur lebar kotak putih
                    vertical: size.height * 0.02, //atur lokasi kotak putih
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
                                    image: const AssetImage(
                                        'images/cashbankapp.png'),
                                    height: size.height * 0.11,
                                    width: size.width * 0.21,
                                    // fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        // Get.to(() => VendorBarcode1());
                                      },
                                    ),
                                  ),
                                ),
                                const Column(
                                  children: [
                                    Text('Cash Advance'),
                                    Text('Confirmation'),
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
                                        const AssetImage('images/salesapp.png'),
                                    height: size.height * 0.11,
                                    width: size.width * 0.21,
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
                                    Text('Cash Advance'),
                                    Text('Approval'),
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
                                    image: const AssetImage(
                                        'images/purchaseapp.png'),
                                    height: size.height * 0.11,
                                    width: size.width * 0.21,
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
                                    Text('C/A Settlement'),
                                    Text('Confirmation'),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      //baris kedua
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
                                    image: const AssetImage(
                                        'images/inventoryapp.png'),
                                    height: size.height * 0.11,
                                    width: size.width * 0.21,
                                    // fit: BoxFit.fill,
                                    child: InkWell(
                                      splashColor: Colors.black38,
                                      onTap: () async {
                                        // Get.to(() => VendorBarcode1());
                                      },
                                    ),
                                  ),
                                ),
                                const Column(
                                  children: [
                                    Text('C/A Settlement'),
                                    Text('Approval'),
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
            ],
          ),
        ),
      ),
    );
  }
}
