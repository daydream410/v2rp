// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/reqip.dart';
import 'package:http/http.dart' as http;
import 'package:v2rp1/BE/resD.dart';

import '../../../../BE/controller.dart';
import '../../../../main.dart';
import '../../../navbar/navbar.dart';
import 'ca_confirm2.dart';

class CashAdvanceConfirm extends StatefulWidget {
  CashAdvanceConfirm({Key? key}) : super(key: key);

  @override
  State<CashAdvanceConfirm> createState() => _CashAdvanceConfirmState();
}

class _CashAdvanceConfirmState extends State<CashAdvanceConfirm> {
  static TextControllers textControllers = Get.put(TextControllers());
  static late List dataaa = <CaConfirmData>[];
  static late List _foundUsers = <CaConfirmData>[];
  late Future dataFuture;

  @override
  void initState() {
    super.initState();
    dataFuture = getDataa();
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = dataaa;
    } else {
      results = dataaa
          .where((dataaa) => dataaa['header']['nokasbon']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

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
      child: isIOS
          ? CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                transitionBetweenRoutes: true,
                middle: const Text("Cash Advance Confirmation"),
                leading: GestureDetector(
                  child: const Icon(CupertinoIcons.back),
                  onTap: () {
                    Get.to(const Navbar());
                  },
                ),
              ),
              child: LiquidPullToRefresh(
                onRefresh: getDataa2,
                color: HexColor("#F4A62A"),
                height: 150,
                showChildOpacityTransition: false,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CupertinoSearchTextField(
                            controller:
                                textControllers.caConfirmController.value,
                            onChanged: (value) => _runFilter(value),
                            itemSize: 30,
                            itemColor: HexColor('#F4A62A'),
                            prefixInsets:
                                const EdgeInsets.only(left: 8, right: 8),
                            suffixInsets: const EdgeInsets.only(right: 8),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          FutureBuilder(
                            future: dataFuture,
                            builder: (context, snapshot) {
                              if (snapshot.error != null) {
                                return const Center(
                                  child: Text('Error Loading Data'),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: Column(
                                  children: [
                                    Text('Loading...'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('Please Kindly Waiting...'),
                                  ],
                                ));
                              } else {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListView.separated(
                                    // shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      );
                                    },
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: _foundUsers.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 5,
                                        child: ListTile(
                                          title: Text(
                                            _foundUsers[index]['header']
                                                ['nokasbon'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            _foundUsers[index]['header']
                                                    ['requestorname'] +
                                                " || " +
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime.parse(
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['tanggal'])),
                                          ),
                                          onTap: () {
                                            Get.to(CashAdvanceConfirm2(
                                              seckey: _foundUsers[index]
                                                  ['seckey'],
                                              nokasbon: _foundUsers[index]
                                                  ['header']['nokasbon'],
                                              ket: _foundUsers[index]['header']
                                                  ['ket'],
                                              tanggal: _foundUsers[index]
                                                  ['header']['tanggal'],
                                              requestor: _foundUsers[index]
                                                  ['header']['requestor'],
                                              requestorname: _foundUsers[index]
                                                  ['header']['requestorname'],
                                              updstatus: _foundUsers[index]
                                                  ['header']['updstatus'],
                                              kasir: _foundUsers[index]
                                                  ['header']['kasir'],
                                              kasirname: _foundUsers[index]
                                                  ['header']['kasirname'],
                                            ));
                                          },
                                          trailing: IconButton(
                                            icon: const Icon(Icons
                                                .arrow_forward_ios_rounded),
                                            onPressed: () {
                                              Get.to(CashAdvanceConfirm2(
                                                seckey: _foundUsers[index]
                                                    ['seckey'],
                                                nokasbon: _foundUsers[index]
                                                    ['header']['nokasbon'],
                                                ket: _foundUsers[index]
                                                    ['header']['ket'],
                                                tanggal: _foundUsers[index]
                                                    ['header']['tanggal'],
                                                requestor: _foundUsers[index]
                                                    ['header']['requestor'],
                                                requestorname:
                                                    _foundUsers[index]['header']
                                                        ['requestorname'],
                                                updstatus: _foundUsers[index]
                                                    ['header']['updstatus'],
                                                kasir: _foundUsers[index]
                                                    ['header']['kasir'],
                                                kasirname: _foundUsers[index]
                                                    ['header']['kasirname'],
                                              ));
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
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text("Cash Advance Confirmation"),
                centerTitle: true,
                backgroundColor: HexColor("#F4A62A"),
                foregroundColor: Colors.white,
                elevation: 1,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.to(() => const Navbar());
                  },
                ),
              ),
              body: LiquidPullToRefresh(
                onRefresh: getDataa2,
                color: HexColor("#F4A62A"),
                height: 150,
                showChildOpacityTransition: false,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 0,
                      top: 15.0,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: textControllers.caConfirmController.value,
                          onChanged: (value) => _runFilter(value),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.assignment),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              color: HexColor('#F4A62A'),
                              onPressed: () async {},
                              splashColor: HexColor('#F4A62A'),
                              tooltip: 'Search',
                              hoverColor: HexColor('#F4A62A'),
                            ),
                            hintText: 'Cash Advance NO',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 0.8,
                          height: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Item List'),
                            const SizedBox(height: 25.0),
                            FutureBuilder(
                              future: dataFuture,
                              builder: (context, snapshot) {
                                if (snapshot.error != null) {
                                  return const Center(
                                    child: Text('Error Loading Data'),
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: Column(
                                    children: [
                                      Text('Loading...'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CircularProgressIndicator(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('Please Kindly Waiting...'),
                                    ],
                                  ));
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.65,
                                        child: ListView.separated(
                                          // shrinkWrap: true,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            );
                                          },
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: _foundUsers.length,
                                          // itemCount: 5,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              elevation: 5,
                                              child: ListTile(
                                                title: Text(
                                                  _foundUsers[index]['header']
                                                      ['nokasbon'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  _foundUsers[index]['header']
                                                          ['requestorname'] +
                                                      " || " +
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(DateTime.parse(
                                                              _foundUsers[index]
                                                                      ['header']
                                                                  ['tanggal'])),
                                                ),
                                                onTap: () {
                                                  Get.to(CashAdvanceConfirm2(
                                                    seckey: _foundUsers[index]
                                                        ['seckey'],
                                                    nokasbon: _foundUsers[index]
                                                        ['header']['nokasbon'],
                                                    ket: _foundUsers[index]
                                                        ['header']['ket'],
                                                    tanggal: _foundUsers[index]
                                                        ['header']['tanggal'],
                                                    requestor:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['requestor'],
                                                    requestorname:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['requestorname'],
                                                    updstatus:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['updstatus'],
                                                    kasir: _foundUsers[index]
                                                        ['header']['kasir'],
                                                    kasirname:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['kasirname'],
                                                  ));
                                                },
                                                trailing: IconButton(
                                                  icon: const Icon(Icons
                                                      .arrow_forward_rounded),
                                                  onPressed: () {
                                                    Get.to(CashAdvanceConfirm2(
                                                      seckey: _foundUsers[index]
                                                          ['seckey'],
                                                      nokasbon:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['nokasbon'],
                                                      ket: _foundUsers[index]
                                                          ['header']['ket'],
                                                      tanggal:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['tanggal'],
                                                      requestor:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['requestor'],
                                                      requestorname:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['requestorname'],
                                                      updstatus:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['updstatus'],
                                                      kasir: _foundUsers[index]
                                                          ['header']['kasir'],
                                                      kasirname:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['kasirname'],
                                                    ));
                                                  },
                                                  color: HexColor('#F4A62A'),
                                                  hoverColor:
                                                      HexColor('#F4A62A'),
                                                  splashColor:
                                                      HexColor('#F4A62A'),
                                                ),
                                                tileColor: Colors.white,
                                                textColor: Colors.black,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
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
      // http://156.67.217.113/api/v1/mobile
      var getData = await http.get(
        // Uri.http('156.67.217.113', '/api/v1/mobile/confirmation/kasbon/'),
        Uri.https('v2rp.net', '/api/v1/mobile/confirmation/kasbon/'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);

      // final data = caConfirmData['data'];
      setState(() {
        dataaa = caConfirmData['data'];
        _foundUsers = dataaa;
      });

      print("getdataaaa " + caConfirmData.toString());
      print("dataaaaaaaaaaaaaaa " + dataaa.toString());
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
        // Uri.http('156.67.217.113', '/api/v1/mobile/confirmation/kasbon/'),
        Uri.https('v2rp.net', '/api/v1/mobile/confirmation/kasbon/'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);

      // final data = caConfirmData['data'];
      setState(() {
        dataaa = caConfirmData['data'];
        _foundUsers = dataaa;
      });

      print("getdataaaa " + caConfirmData.toString());
      print("dataaaaaaaaaaaaaaa " + dataaa.toString());
    } catch (e) {
      print(e);
    }
  }
}
