// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, unused_local_variable, unrelated_type_equality_checks, unnecessary_this
import 'dart:convert';
import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/resD.dart';
// import 'package:v2rp1/BE/controller.dart';
// import 'package:v2rp1/FE/mainScreen/login_screen4.dart';
import 'package:v2rp1/main.dart';
import 'package:crypto/crypto.dart' as crypto;

import 'controller.dart';
// import 'package:uuid/uuid.dart';
// import 'package:mac_address/mac_address.dart';

class MsgHeader {
  static TextControllers textControllers = Get.put(TextControllers());

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
  static var kulonuwun;
  static var monggo;
  static var success;

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
      // print(response.body);
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

  static Future<void> convi(String? userVal, String? passVal) async {
    var userValue = userVal;
    var passValue = passVal;

    var data = userValue.toString() +
        trxid.toString() +
        passValue.toString() +
        ipValue;
    var md5 = crypto.md5;
    conve = md5.convert(utf8.encode(data)).toString();
    var msgHead = 'x-v2rp-key:' + conve;

    // print('Your IPPP = ' + ipValue);
    // print('Your MD5 = ' + conve);
    // print('Your Message Header = ' + msgHead);
    // print('Your USERNAME = ' + userVal.toString());
    // print('Your PASSWORD = ' + passVal.toString());
  }

  static Future<void> Login(String? userVal, passVal) async {
    // id = uuid.v5(Uuid.NAMESPACE_URL, userVal);
    // var macAddress = await GetMac.macAddress;
    // try {
    //   macAddress = await GetMac.macAddress;
    // } on PlatformException {
    //   macAddress = 'Failed to get Device MAC Address';
    // }
    String encryptData(String plaintext, String secretKey) {
      final key = utf8.encode(secretKey);
      final text = utf8.encode(plaintext);

      final hmac = crypto.Hmac(crypto.sha256, key);
      final digest = hmac.convert(text);

      final encryptedData = base64Encode(digest.bytes);
      return encryptedData;
    }

// x-v2rp-key2: '$encoded'
    try {
      var sendLogin = await http.post(Uri.https('www.v2rp.net', '/ptemp/'),
          // headers: {'x-v2rp-key': '$conve', 'DEVICE-KEY': '$macAddress'},
          headers: {
            'x-v2rp-key': '$conve',
            'DEVICE-KEY': '$macAddress',
          },
          // headers: {'x-v2rp-key': '$conve'},
          body: jsonEncode({
            "trxid": "$trxid",
            "datetime": "$datetime",
            "reqid": "login",
            // "macAddress": "$macAddress",
          }));
      // print(sendLogin.body);
      hasilLogin = jsonDecode(sendLogin.body);
      // print('${hasilLogin['responsecode']}');
      responseCodeResult = {hasilLogin['responsecode']};
      // print(responseCodeResult);
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
      // print(sendSearch.body);
      ResultData outputResult = ResultData.fromMap(jsonDecode(sendSearch.body));
      // print(outputResult.responsecode);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> loginProcessNEW() async {
    var emailVal = textControllers.emailController.value.text;
    var userVal = textControllers.usernameController.value.text;
    var passVal = textControllers.passwordController.value.text;
    print('Email =======' + emailVal);
    print('role =======' + userVal);
    print('pw =======' + passVal);

    try {
      // http://156.67.217.113/api/v1/mobile
      var sendLogin =
          await http.post(Uri.http('156.67.217.113', '/api/v1/mobile/login'),
              // await http.post(Uri.parse(Api.loginApi),
              headers: {'Content-Type': 'application/json; charset=utf-8'},
              body: jsonEncode({
                "email": emailVal,
                "role": userVal,
                "password": passVal,
              }));

      print('sendlogin ===' + sendLogin.body);
      var hasilLogin = jsonDecode(sendLogin.body);
      var data = hasilLogin['data'];
      success = hasilLogin['success'];
      kulonuwun = data['kulonuwun'];
      monggo = data['monggo'];
      // print('status' + status);
      // print('kulooo = ' + kulonuwun);
      // print('monggo = ' + monggo);

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('kulonuwun', kulonuwun);
      sharedPreferences.setString('monggo', monggo);
    } catch (e) {
      print(e);
    }
  }
}

// class Api {
//   static const _baseUrl = '156.67.217.113';

//   static const loginApi = _baseUrl + '/api/v1/mobile/login';
//   static const caConfirmApi = _baseUrl + '/api/v1/mobile/confirmation/kasbon/';
//   static const sppbjConfirmApi =
//       _baseUrl + '/api/v1/mobile/confirmation/sppbj/';
// }
