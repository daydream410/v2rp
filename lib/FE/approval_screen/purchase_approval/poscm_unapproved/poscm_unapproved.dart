import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:v2rp1/FE/approval_screen/purchase_approval/poscm_unapproved/poscm_unapproved2.dart';

import '../../../../BE/controller.dart';
import '../../../../BE/reqip.dart';
import '../../../../BE/resD.dart';
import '../../../../main.dart';
import '../../../navbar/navbar.dart';

class PoUnapproved extends StatefulWidget {
  PoUnapproved({Key? key}) : super(key: key);

  @override
  State<PoUnapproved> createState() => _PoUnapprovedState();
}

class _PoUnapprovedState extends State<PoUnapproved> {
  static TextControllers textControllers = Get.put(TextControllers());
  static late List dataaa = <CaConfirmData>[];
  static late List dataaa2 = <CaConfirmData>[];
  static late List gabung = <CaConfirmData>[];
  static late List _foundUsers = <CaConfirmData>[];
  static late var tipe;

  @override
  void initState() {
    super.initState();
    getDataa();
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = dataaa;
    } else {
      results = dataaa
          .where((dataaa) => dataaa['header']['pono']
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
                middle: const Text("PO Supplier Unapproved Approval"),
                leading: GestureDetector(
                  child: const Icon(CupertinoIcons.back),
                  onTap: () {
                    Get.to(const Navbar());
                  },
                ),
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CupertinoSearchTextField(
                          controller:
                              textControllers.PoUnapprovedController.value,
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
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListView.separated(
                            // shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              );
                            },
                            physics: const BouncingScrollPhysics(),
                            itemCount: _foundUsers.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(
                                    _foundUsers[index]['header']['pono'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    _foundUsers[index]['header']
                                            ['requestorname'] +
                                        " || " +
                                        DateFormat('yyyy-MM-dd').format(
                                            DateTime.parse(_foundUsers[index]
                                                ['header']['tanggal'])) +
                                        " || " +
                                        _foundUsers[index]['header']
                                            ['suppliername'],
                                  ),
                                  onTap: () {
                                    Get.to(PoUnapproved2(
                                      seckey: _foundUsers[index]['seckey'],
                                      pono: _foundUsers[index]['header']
                                          ['pono'],
                                      tanggal: _foundUsers[index]['header']
                                          ['tanggal'],
                                      requestorname: _foundUsers[index]
                                          ['header']['requestorname'],
                                      supplier: _foundUsers[index]['header']
                                          ['suppliername'],
                                      ccy: _foundUsers[index]['header']['ccy'],
                                      disc: _foundUsers[index]['header']
                                          ['disc'],
                                      tipe: tipe,
                                    ));
                                  },
                                  trailing: IconButton(
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    onPressed: () {
                                      Get.to(PoUnapproved2(
                                        seckey: _foundUsers[index]['seckey'],
                                        pono: _foundUsers[index]['header']
                                            ['pono'],
                                        tanggal: _foundUsers[index]['header']
                                            ['tanggal'],
                                        requestorname: _foundUsers[index]
                                            ['header']['requestorname'],
                                        supplier: _foundUsers[index]['header']
                                            ['suppliername'],
                                        ccy: _foundUsers[index]['header']
                                            ['ccy'],
                                        disc: _foundUsers[index]['header']
                                            ['disc'],
                                        tipe: tipe,
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text("PO Supplier Unapproved Approval"),
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
              body: SingleChildScrollView(
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
                        controller:
                            textControllers.PoUnapprovedController.value,
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
                          hintText: 'PO No.',
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.65,
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
                                          _foundUsers[index]['header']['pono'],
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
                                                          ['tanggal'])) +
                                              " || " +
                                              _foundUsers[index]['header']
                                                  ['suppliername'],
                                        ),
                                        onTap: () {
                                          Get.to(PoUnapproved2(
                                            seckey: _foundUsers[index]
                                                ['seckey'],
                                            pono: _foundUsers[index]['header']
                                                ['pono'],
                                            tanggal: _foundUsers[index]
                                                ['header']['tanggal'],
                                            requestorname: _foundUsers[index]
                                                ['header']['requestorname'],
                                            supplier: _foundUsers[index]
                                                ['header']['suppliername'],
                                            ccy: _foundUsers[index]['header']
                                                ['ccy'],
                                            disc: _foundUsers[index]['header']
                                                ['disc'],
                                            tipe: tipe,
                                          ));
                                        },
                                        trailing: IconButton(
                                          icon: const Icon(
                                              Icons.arrow_forward_rounded),
                                          onPressed: () {
                                            Get.to(PoUnapproved2(
                                              seckey: _foundUsers[index]
                                                  ['seckey'],
                                              pono: _foundUsers[index]['header']
                                                  ['pono'],
                                              tanggal: _foundUsers[index]
                                                  ['header']['tanggal'],
                                              requestorname: _foundUsers[index]
                                                  ['header']['requestorname'],
                                              supplier: _foundUsers[index]
                                                  ['header']['suppliername'],
                                              ccy: _foundUsers[index]['header']
                                                  ['ccy'],
                                              disc: _foundUsers[index]['header']
                                                  ['disc'],
                                              tipe: tipe,
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
      var getData = await http.get(
        Uri.https('v2rp.net', '/api/v1/mobile/approval/supplier/poscm'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      var getData2 = await http.get(
        Uri.https('v2rp.net', '/api/v1/mobile/approval/supplier/pononscm'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final responseData = json.decode(getData.body);
      final responseData2 = json.decode(getData2.body);

      // final data = responseData['data'];
      setState(() {
        dataaa = responseData['data'];
        dataaa2 = responseData2['data'];
        gabung = dataaa + dataaa2;
        _foundUsers = gabung;
        tipe = '0';
      });

      if (dataaa.isNotEmpty) {
        setState(() {
          tipe = '0';
        });
      } else {
        setState(() {
          tipe = '1';
        });
      }

      // print("getdataaaa " + responseData.toString());
      print("dataaaaaaaaaaaaaaa " + dataaa.toString());
      print("data2 " + dataaa2.toString());
      print("gabung " + gabung.toString());
      print("tipe " + tipe.toString());
    } catch (e) {
      print(e);
    }
  }
}