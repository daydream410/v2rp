// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, unused_local_variable, unrelated_type_equality_checks, unnecessary_this
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/resD.dart';
import 'package:v2rp1/main.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'controller.dart';

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
  static var seckey;
  static var success;
  static var otpSuccess;
  static var otpMessage;
  static var otpData;
  static var rolesData;
  static var roleSuccess;
  static var roleMessage;
  static var resendOtpSuccess;
  static var resendOtpMessage;

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
    var passVal = textControllers.passwordController.value.text;

    try {
      var sendLogin = await http
          .post(
        Uri.parse('https://v2rp.net/dev/api/v2/mobile/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": emailVal,
          "password": passVal,
        }),
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Connection timeout. Please try again.');
        },
      );

      if (sendLogin.statusCode == 200) {
        var hasilLogin = jsonDecode(sendLogin.body);
        var data = hasilLogin['data'];
        success = hasilLogin['success'] ?? false;

        if (success == true && data != null) {
          seckey = data.toString();

          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString('seckey', seckey);
        } else {
          success = false;
        }
      } else {
        success = false;
        print('Login failed with status code: ${sendLogin.statusCode}');
      }
    } on TimeoutException {
      success = false;
      rethrow;
    } on SocketException {
      success = false;
      rethrow;
    } catch (e) {
      success = false;
      print('Login error: $e');
      rethrow;
    }
  }

  static Future<void> verifyOtp(String seckey, String otp) async {
    otpSuccess = false;
    otpMessage = '';
    otpData = '';

    try {
      var response = await http
          .post(
        Uri.parse('https://v2rp.net/dev/api/v2/mobile/verify/otp/$seckey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "otp": otp,
        }),
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Connection timeout. Please try again.');
        },
      );

      // Parse response body regardless of status code
      try {
        var hasil = jsonDecode(response.body);
        otpSuccess = hasil['success'] ?? false;
        otpMessage = hasil['message'] ?? '';

        // Get error message from "data" field if success is false
        if (otpSuccess == false && hasil['data'] != null) {
          // Handle both string and other types
          if (hasil['data'] is String) {
            otpData = hasil['data'];
          } else {
            otpData = hasil['data'].toString();
          }
          // Debug: Print otpData to verify
          print('OTP Error Data: $otpData');
        } else {
          otpData = '';
        }

        if (otpSuccess == true && hasil['data'] != null) {
          // Save roles data to SharedPreferences
          rolesData = hasil['data'];
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('otp_roles', jsonEncode(rolesData));
        }

        // If status code is not 200, still mark as failed
        if (response.statusCode != 200) {
          otpSuccess = false;
        }
      } catch (e) {
        // If response body cannot be parsed, use default error
        otpSuccess = false;
        otpMessage = 'Failed to verify OTP';
        otpData = '';
        print('Error parsing response: $e');
      }
    } on TimeoutException {
      otpSuccess = false;
      otpMessage = 'Connection timeout. Please try again.';
      rethrow;
    } on SocketException {
      otpSuccess = false;
      otpMessage = 'No internet connection. Please check your network.';
      rethrow;
    } catch (e) {
      otpSuccess = false;
      otpMessage = 'Error verifying OTP: $e';
      print('OTP verification error: $e');
      rethrow;
    }
  }

  static Future<void> resendOtp(String email, String password) async {
    resendOtpSuccess = false;
    resendOtpMessage = '';

    try {
      var sendLogin = await http
          .post(
        Uri.parse('https://v2rp.net/dev/api/v2/mobile/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Connection timeout. Please try again.');
        },
      );

      if (sendLogin.statusCode == 200) {
        var hasilLogin = jsonDecode(sendLogin.body);
        var data = hasilLogin['data'];
        resendOtpSuccess = hasilLogin['success'] ?? false;
        resendOtpMessage = hasilLogin['message'] ?? '';

        if (resendOtpSuccess == true && data != null) {
          // Update seckey dengan yang baru
          seckey = data.toString();

          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString('seckey', seckey);
        } else {
          resendOtpSuccess = false;
        }
      } else {
        resendOtpSuccess = false;
        print('Resend OTP failed with status code: ${sendLogin.statusCode}');
      }
    } on TimeoutException {
      resendOtpSuccess = false;
      resendOtpMessage = 'Connection timeout. Please try again.';
      rethrow;
    } on SocketException {
      resendOtpSuccess = false;
      resendOtpMessage = 'No internet connection. Please check your network.';
      rethrow;
    } catch (e) {
      resendOtpSuccess = false;
      resendOtpMessage = 'Error resending OTP: $e';
      print('Resend OTP error: $e');
      rethrow;
    }
  }

  static Future<void> chooseRole(
      String seckey, String fcmToken, String platform) async {
    roleSuccess = false;
    roleMessage = '';
    kulonuwun = '';
    monggo = '';

    try {
      var response = await http
          .post(
        Uri.parse('https://v2rp.net/dev/api/v2/mobile/choose/role/$seckey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "fcmtoken": fcmToken,
          "platform": platform,
        }),
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Connection timeout. Please try again.');
        },
      );

      if (response.statusCode == 200) {
        var hasil = jsonDecode(response.body);
        roleSuccess = hasil['success'] ?? false;
        roleMessage = hasil['message'] ?? '';

        if (roleSuccess == true && hasil['data'] != null) {
          var data = hasil['data'];
          kulonuwun = data['kulonuwun'] ?? '';
          monggo = data['monggo'] ?? '';

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('kulonuwun', kulonuwun);
          await prefs.setString('monggo', monggo);
        } else {
          roleSuccess = false;
        }
      } else {
        roleSuccess = false;
        roleMessage = 'Failed to select role';
        print('Choose role failed with status code: ${response.statusCode}');
      }
    } on TimeoutException {
      roleSuccess = false;
      roleMessage = 'Connection timeout. Please try again.';
      rethrow;
    } on SocketException {
      roleSuccess = false;
      roleMessage = 'No internet connection. Please check your network.';
      rethrow;
    } catch (e) {
      roleSuccess = false;
      roleMessage = 'Error selecting role: $e';
      print('Choose role error: $e');
      rethrow;
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
