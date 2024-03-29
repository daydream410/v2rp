// ignore_for_file: avoid_print, unused_field, unrelated_type_equality_checks, unnecessary_new, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unnecessary_null_comparison, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/controller.dart';
import 'package:v2rp1/BE/reqip.dart';
import 'package:v2rp1/FE/home_screen/FA/fixasset_scanner.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:async';

class FixAsset2 extends StatefulWidget {
  const FixAsset2({Key? key}) : super(key: key);

  @override
  State<FixAsset2> createState() => _FixAsset2State();
}

class _FixAsset2State extends State<FixAsset2> {
  static var hasilSearch;
  static var conve = MsgHeader.conve;
  static var trxid = MsgHeader.trxid;
  static var datetime = MsgHeader.datetime;
  static late TextControllers textControllers = Get.put(TextControllers());
  static var serverKeyValue;
  late File uploadImage;

  late List _dataaa = <FixAsset2>[];
  late final List _dataaa1 = <FixAsset2>[];
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    if (textControllers.fixassetController.value.text != null) {
      getData();
      print('null = ' + textControllers.fixassetController.value.text);
    }
  }

  // @override
  // void dispose() {
  //   // textControllers.dispose();
  //   super.dispose();
  // }

  Future<String> getData() async {
    var searchValue = textControllers.fixassetController.value.text;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;

    var sendSearch =
        // await http.post(Uri.http('156.67.217.113', '/api/v1/mobile/assets'),
        await http.post(Uri.https('v2rp.net', '/api/v1/mobile/assets'),
            headers: {
              'Content-Type': 'application/json; charset=utf-8',
              'kulonuwun': finalKulonuwun ?? kulonuwun,
              'monggo': finalMonggo ?? monggo,
            },
            body: jsonEncode({
              "id": searchValue,
            }));

    final fixAsset = json.decode(sendSearch.body);
    // serverKeyValue = fixAsset['serverkey'];
    var succuss = fixAsset['success'];
    var responseMessage = fixAsset['message'];

    if (succuss == true) {
      setState(() {
        _dataaa = fixAsset['data'];
        textControllers.fixassetController.value.clear();
      });
    } else if (succuss == false) {
      Get.snackbar(
        'Hint',
        'Keywords At Least 3 Characters',
        colorText: Colors.white,
        icon: Icon(
          Icons.tips_and_updates,
          color: Colors.white,
        ),
        backgroundColor: HexColor('#F4A62A'),
        isDismissible: true,
        dismissDirection: DismissDirection.vertical,
      );
    } else {
      Get.snackbar(
        'Failed',
        '$responseMessage',
        colorText: Colors.white,
        icon: Icon(
          Icons.warning,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.vertical,
      );
      setState(() {
        _dataaa.clear();
        textControllers.fixassetController.value.clear();
      });
    }
    print(sendSearch.body);

    print(serverKeyValue);
    return "Successfull";
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
            content: const Text('Do you want to exit the App?'),
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
                middle: Text("Fixed Assets"),
                leading: GestureDetector(
                  child: Icon(CupertinoIcons.back),
                  onTap: () {
                    Get.to(Navbar());
                  },
                ),
              ),
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CupertinoSearchTextField(
                        controller: textControllers.fixassetController.value,
                        itemSize: 30,
                        itemColor: HexColor('#F4A62A'),
                        prefixInsets: EdgeInsets.only(left: 8, right: 8),
                        suffixInsets: EdgeInsets.only(right: 8),
                        suffixMode: OverlayVisibilityMode.notEditing,
                        suffixIcon: Icon(CupertinoIcons.barcode_viewfinder),
                        onSuffixTap: () => Get.to(ScanFixAsset()),
                        onSubmitted: (value) {
                          searchProcess();
                          setState(() {
                            textControllers.fixassetController.value.clear();
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                            );
                          },
                          physics: const BouncingScrollPhysics(),
                          itemCount: _dataaa.length,
                          itemBuilder: (context, index) {
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 10,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Stack(
                                    children: [
                                      InkWell(
                                        onDoubleTap: () {
                                          dialogImage();
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                        },
                                        child: Ink.image(
                                          image: NetworkImage(
                                            _dataaa[index]['img'],
                                          ),
                                          height: 300,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, top: 10),
                                            child: Text(
                                              _dataaa[index]['ket'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 0,
                                            top: 10,
                                            bottom: 0,
                                            right: 0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    'F/Assets No.    ',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Description',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Category',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Brand',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Made In',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Reff.No.',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Req.No.',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'P/O No.',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Request By',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Serial No.',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Location',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _dataaa[index]['fdatano'],
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      _dataaa[index]['ket'],
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _dataaa[index]
                                                                  ['catname'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        const Text(
                                                          ' - ',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        Text(
                                                          _dataaa[index][
                                                                  'subcatname'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _dataaa[index][
                                                                  'brandname'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        const Text(
                                                          ' - ',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        Text(
                                                          _dataaa[index][
                                                                  'tipebrandname'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      _dataaa[index]
                                                              ['countryname'] ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      _dataaa[index]
                                                              ['docreffno'] ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      _dataaa[index]['reqno'] ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      _dataaa[index]['pono'] ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      _dataaa[index]['reqby'] ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      _dataaa[index]
                                                              ['serialno'] ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      _dataaa[index]
                                                              ['locationnm'] ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontSize: 15,
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
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text("Fixed Assets"),
                centerTitle: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 1,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.to(() => Navbar());
                  },
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Fixed Assets',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: textControllers.fixassetController.value,
                        onSubmitted: (value) {
                          searchProcess();
                          setState(() {
                            textControllers.fixassetController.value.clear();
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.assignment),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.qr_code_2),
                            color: HexColor('#F4A62A'),
                            onPressed: () async {
                              Get.to(() => ScanFixAsset());
                            },
                            splashColor: HexColor('#F4A62A'),
                            tooltip: 'Scan',
                            hoverColor: HexColor('#F4A62A'),
                          ),
                          hintText: 'FA Number / Item Name',
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
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                    );
                                  },
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: _dataaa.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 10,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Stack(
                                            children: [
                                              InkWell(
                                                onDoubleTap: () {
                                                  dialogImage();
                                                  setState(() {
                                                    selectedIndex = index;
                                                  });
                                                },
                                                child: Ink.image(
                                                  image: NetworkImage(
                                                    _dataaa[index]['img'],
                                                  ),
                                                  height: 300,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, top: 10),
                                                    child: Text(
                                                      _dataaa[index]['ket'],
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 0,
                                                    top: 10,
                                                    bottom: 0,
                                                    right: 0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: const [
                                                          Text(
                                                            'F/Assets No.    ',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Description',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Category',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Brand',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Made In',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Reff.No.',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Req.No.',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'P/O No.',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Request By',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Serial No.',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Location',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Flexible(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              _dataaa[index]
                                                                  ['fdatano'],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              _dataaa[index]
                                                                  ['ket'],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  _dataaa[index]
                                                                          [
                                                                          'catname'] ??
                                                                      '',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                                const Text(
                                                                  ' - ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  _dataaa[index]
                                                                          [
                                                                          'subcatname'] ??
                                                                      '',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  _dataaa[index]
                                                                          [
                                                                          'brandname'] ??
                                                                      '',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                                const Text(
                                                                  ' - ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  _dataaa[index]
                                                                          [
                                                                          'tipebrandname'] ??
                                                                      '',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              _dataaa[index][
                                                                      'countryname'] ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              _dataaa[index][
                                                                      'docreffno'] ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              _dataaa[index][
                                                                      'reqno'] ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              _dataaa[index][
                                                                      'pono'] ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              _dataaa[index][
                                                                      'reqby'] ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              _dataaa[index][
                                                                      'serialno'] ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Text(
                                                              _dataaa[index][
                                                                      'locationnm'] ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
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
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  dialogImage() {
    Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text("Upload Image"),
                content: Text("Please Click Button Below"),
                actions: [
                  CupertinoDialogAction(
                    child: Text(
                      "Choose Image",
                      style: TextStyle(
                        color: HexColor('#F4A62A'),
                      ),
                    ),
                    onPressed: () {
                      pilihGambar();
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      "Take Picture",
                      style: TextStyle(
                        color: HexColor('#F4A62A'),
                      ),
                    ),
                    onPressed: () {
                      takeImage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          )
        : Get.defaultDialog(
            radius: 5,
            title: "Upload Image",
            middleText: "",
            backgroundColor: Colors.white,
            confirm: SizedBox(
              width: 115.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor('#F4A62A'),
                ),
                onPressed: () {
                  pilihGambar();
                  Get.back();
                },
                child: Text(
                  'Choose Image',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            cancel: SizedBox(
              width: 115.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: HexColor('#F4A62A'),
                ),
                onPressed: () {
                  takeImage();
                  Get.back();
                },
                child: Text(
                  'Take Picture',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          );
  }

  Future<void> pilihGambar() async {
    var choosedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (choosedimage == null) return;
    setState(() {
      uploadImage = File(choosedimage.path);
    });

    if (uploadImage != null) {
      print('Ada Gambar = ' + uploadImage.toString());
    } else {
      print('Tidak Ada GAmbar');
    }
    sendImage();
  }

  Future<void> takeImage() async {
    var choosedimage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    if (choosedimage == null) return;
    setState(() {
      uploadImage = File(choosedimage.path);
    });

    if (uploadImage != null) {
      print('Ada Gambar = ' + uploadImage.toString());
    } else {
      print('Tidak Ada GAmbar');
    }
    sendImage();
  }

  Future<void> sendImage() async {
    var tesA = _dataaa[selectedIndex]['fdatano'];
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(tesA);
    print("encoded = " + encoded);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    String tipe = "FA";
    final dioo = dio.Dio();
    try {
      String fileName = uploadImage.path.split('/').last;
      print('filename = ' + fileName);
      print('upload image path = ' + uploadImage.path);

      dio.FormData formData = new dio.FormData.fromMap({
        "image": await dio.MultipartFile.fromFile(
          uploadImage.path,
          filename: fileName,
          contentType: new MediaType('image', 'jpg'),
        ),
      });
      dio.Response response = await dioo.post(
        // 'http://156.67.217.113/api/v1/mobile/uploader/$tipe/$encoded',
        'https://v2rp.net/api/v1/mobile/uploader/$tipe/$encoded',
        // '156.67.217.113/api/v1/mobile/uploader/' + tipe + '/' + encoded,
        data: formData,
        options: dio.Options(headers: {
          'Content-Type': 'multipart/form-data',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        }),
      );
      print('connect to server');
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Image is Uploaded",
          colorText: Colors.white,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
        );

        Get.offAll(const Navbar());
      } else {
        Get.snackbar(
          "Failed",
          "Please Try Again!",
          colorText: Colors.white,
          icon: Icon(
            Icons.warning,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
        );
      }
    } catch (e) {
      print('Error connect to server');
      Get.snackbar(
        "Error Connect To Server",
        "Please Try Again!",
        colorText: Colors.white,
        icon: Icon(
          Icons.warning,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.vertical,
      );
    }
  }

  Future<void> searchProcess() async {
    var searchResult = textControllers.fixassetController.value.text;
    try {
      if (searchResult.length >= 3) {
        getData();
      } else {
        Get.snackbar(
          "Error!",
          "Please Enter Valid FA Number / Item Name",
          icon: Icon(Icons.close),
          backgroundColor: Colors.red,
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
