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
import 'package:v2rp1/FE/approval_screen/inventory_approval/mu_approval/mu_app2.dart';
import 'package:http/http.dart' as http;
import 'package:v2rp1/BE/resD.dart';
import '../../../../BE/controller.dart';
import '../../../../BE/reqip.dart';
import '../../../../main.dart';
import '../../../navbar/navbar.dart';

class MuApp extends StatefulWidget {
  MuApp({Key? key}) : super(key: key);

  @override
  State<MuApp> createState() => _MuAppState();
}

class _MuAppState extends State<MuApp> {
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
          .where((dataaa) => dataaa['header']['dono']
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
                middle: const Text("Material Used Approval"),
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
                height: 140,
                showChildOpacityTransition: false,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CupertinoSearchTextField(
                            controller: textControllers.muAppController.value,
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
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      child: Text(
                                        'Loading...',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    DefaultTextStyle(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                        child:
                                            Text('Please Kindly Waiting...')),
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
                                                ['dono'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            _foundUsers[index]['header']
                                                    ['userid'] +
                                                " || " +
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime.parse(
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['tanggal'])),
                                          ),
                                          onTap: () {
                                            Get.to(MuApp2(
                                              seckey: _foundUsers[index]
                                                  ['seckey'],
                                              ket: _foundUsers[index]['header']
                                                  ['ket'],
                                              tanggal: _foundUsers[index]
                                                  ['header']['tanggal'],
                                              dono: _foundUsers[index]['header']
                                                  ['dono'],
                                              userid: _foundUsers[index]
                                                  ['header']['userid'],
                                            ));
                                          },
                                          trailing: IconButton(
                                            icon: const Icon(Icons
                                                .arrow_forward_ios_rounded),
                                            onPressed: () {
                                              Get.to(MuApp2(
                                                seckey: _foundUsers[index]
                                                    ['seckey'],
                                                ket: _foundUsers[index]
                                                    ['header']['ket'],
                                                tanggal: _foundUsers[index]
                                                    ['header']['tanggal'],
                                                dono: _foundUsers[index]
                                                    ['header']['dono'],
                                                userid: _foundUsers[index]
                                                    ['header']['userid'],
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
                title: const Text("Material Used Approval"),
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
                          controller: textControllers.muAppController.value,
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
                            hintText: 'Material Used No.',
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
                                          itemBuilder: (context, index) {
                                            return Card(
                                              elevation: 5,
                                              child: ListTile(
                                                title: Text(
                                                  _foundUsers[index]['header']
                                                      ['dono'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  _foundUsers[index]['header']
                                                          ['userid'] +
                                                      " || " +
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(DateTime.parse(
                                                              _foundUsers[index]
                                                                      ['header']
                                                                  ['tanggal'])),
                                                ),
                                                onTap: () {
                                                  Get.to(MuApp2(
                                                    seckey: _foundUsers[index]
                                                        ['seckey'],
                                                    ket: _foundUsers[index]
                                                        ['header']['ket'],
                                                    tanggal: _foundUsers[index]
                                                        ['header']['tanggal'],
                                                    dono: _foundUsers[index]
                                                        ['header']['dono'],
                                                    userid: _foundUsers[index]
                                                        ['header']['userid'],
                                                  ));
                                                },
                                                trailing: IconButton(
                                                  icon: const Icon(Icons
                                                      .arrow_forward_rounded),
                                                  onPressed: () {
                                                    Get.to(MuApp2(
                                                      seckey: _foundUsers[index]
                                                          ['seckey'],
                                                      ket: _foundUsers[index]
                                                          ['header']['ket'],
                                                      tanggal:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['tanggal'],
                                                      dono: _foundUsers[index]
                                                          ['header']['dono'],
                                                      userid: _foundUsers[index]
                                                          ['header']['userid'],
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
        // Uri.http('156.67.217.113', '/api/v1/mobile/approval/materialused'),
        Uri.https('v2rp.net', '/api/v1/mobile/approval/materialused'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final responseData = json.decode(getData.body);

      // final data = responseData['data'];
      setState(() {
        dataaa = responseData['data'];
        _foundUsers = dataaa;
      });

      print("getdataaaa " + responseData.toString());
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
        // Uri.http('156.67.217.113', '/api/v1/mobile/approval/materialused'),
        Uri.https('v2rp.net', '/api/v1/mobile/approval/materialused'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final responseData = json.decode(getData.body);

      // final data = responseData['data'];
      setState(() {
        dataaa = responseData['data'];
        _foundUsers = dataaa;
      });

      print("getdataaaa " + responseData.toString());
      print("dataaaaaaaaaaaaaaa " + dataaa.toString());
    } catch (e) {
      print(e);
    }
  }
}
