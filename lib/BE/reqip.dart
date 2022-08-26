// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, unused_local_variable, unrelated_type_equality_checks, unnecessary_this
import 'dart:convert';
import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:v2rp1/BE/resD.dart';
// import 'package:v2rp1/BE/controller.dart';
// import 'package:v2rp1/FE/mainScreen/login_screen4.dart';
import 'package:v2rp1/main.dart';
import 'package:crypto/crypto.dart' as crypto;
// import 'package:uuid/uuid.dart';
// import 'package:mac_address/mac_address.dart';

class MsgHeader {
  static int trxid = DateTime.now().millisecondsSinceEpoch;
  static var ipValue = '';
  static var datetime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
  static var conve = '';
  static var hasilLogin;
  static var responseCodeResult;
  static var ipResult;
  static var hasilBarcode;
  static var barcodeResult;
  static var hasilSearch;
  static var resultSearch;
  static var dataResult;
  static var messageResult;
  // static var uuid = const Uuid();
  // static var id;
  static var macAddress = 'Unknown';

  static Future<void> Reqip() async {
    HttpOverrides.global = MyHttpOverrides();
    try {
      var response = await http.post(Uri.https('www.v2rp.net', '/ptemp/'),
          body: jsonEncode({
            "trxid": "$trxid",
            "datetime": "$datetime",
            "requestip": "true"
          }));
      print(response.body);
      var hasil = jsonDecode(response.body);
      // print('${hasil['responsecode']}');
      // print('${hasil['ip']}');

      //sudah menjadi object
      var responsecodee = '${hasil['responsecode']}';
      ipValue = '${hasil['ip']}';
      // print('Response Code = ' + responsecodee);
      // print('Your IP = ' + ipValue);
      messageResult = '${hasil['res']}';
    } catch (e) {
      print(e);
    }
  }

  static convi(String userVal, String passVal) async {
    var userValue = userVal;
    var passValue = passVal;
    var data = userValue + trxid.toString() + passValue + ipValue;
    var md5 = crypto.md5;
    conve = md5.convert(utf8.encode(data)).toString();
    var msgHead = 'x-v2rp-key:' + conve;

    print('Your IPPP = ' + ipValue);
    print('Your MD5 = ' + conve);
    print('Your Message Header = ' + msgHead);
    print('Your USERNAME = ' + userVal);
    print('Your PASSWORD = ' + passVal);
  }

  static Future<void> Login(String userVal) async {
    // id = uuid.v5(Uuid.NAMESPACE_URL, userVal);
    // var macAddress = await GetMac.macAddress;
    // try {
    //   macAddress = await GetMac.macAddress;
    // } on PlatformException {
    //   macAddress = 'Failed to get Device MAC Address';
    // }
    try {
      var sendLogin = await http.post(Uri.https('www.v2rp.net', '/ptemp/'),
          headers: {'x-v2rp-key': '$conve', 'DEVICE-KEY': '$macAddress'},
          // headers: {'x-v2rp-key': '$conve'},
          body: jsonEncode({
            "trxid": "$trxid",
            "datetime": "$datetime",
            "reqid": "login",
            // "macAddress": "$macAddress",
          }));
      print(sendLogin.body);
      hasilLogin = jsonDecode(sendLogin.body);
      print('${hasilLogin['responsecode']}');
      responseCodeResult = {hasilLogin['responsecode']};
      print(responseCodeResult);
      ipResult = {hasilLogin['ip']};
      messageResult = hasilLogin['message'];
      // print('Mac Address = ' + macAddress);
    } catch (e) {
      print(e);
    }
  }

  static searchRequest(String searchVal, hasilSearch) async {
    var searchValue = searchVal;
    try {
      var sendSearch = await http.post(Uri.https('www.v2rp.net', '/ptemp/'),
          headers: {'x-v2rp-key': '$conve'},
          body: jsonEncode({
            "trxid": "$trxid",
            "datetime": "$datetime",
            "reqid": "0002",
            "id": "$searchValue"
          }));
      /////////////////////////
      print(sendSearch.body);
      ResultData outputResult = ResultData.fromMap(jsonDecode(sendSearch.body));
      print(outputResult.responsecode);
    } catch (e) {
      print(e);
    }
  }
}
