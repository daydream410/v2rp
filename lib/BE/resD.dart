// // ignore_for_file: file_names

// import 'dart:convert';

// ResultData resultDataFromMap(String str) =>
//     ResultData.fromMap(json.decode(str));

// String resultDataToMap(ResultData data) => json.encode(data.toMap());

// class ResultData {
//   ResultData({
//     required this.trxid,
//     required this.datetime,
//     required this.reqid,
//     required this.id,
//     required this.responsecode,
//     required this.message,
//     required this.serverkey,
//     required this.result,
//   });

//   String trxid;
//   String datetime;
//   String reqid;
//   String id;
//   String responsecode;
//   String message;
//   int serverkey;
//   List<Result> result;

//   factory ResultData.fromMap(Map<String, dynamic> json) => ResultData(
//         trxid: json["trxid"],
//         datetime: json["datetime"],
//         reqid: json["reqid"],
//         id: json["id"],
//         responsecode: json["responsecode"],
//         message: json["message"],
//         serverkey: json["serverkey"],
//         result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "trxid": trxid,
//         "datetime": datetime,
//         "reqid": reqid,
//         "id": id,
//         "responsecode": responsecode,
//         "message": message,
//         "serverkey": serverkey,
//         "result": List<dynamic>.from(result.map((x) => x.toMap())),
//       };
// }

// class Result {
//   Result({
//     required this.stockid,
//     required this.itemname,
//     required this.unit,
//     required this.costperunit,
//     required this.image,
//   });

//   String stockid;
//   String itemname;
//   String unit;
//   String costperunit;
//   String image;

//   factory Result.fromMap(Map<String, dynamic> json) => Result(
//         stockid: json["stockid"],
//         itemname: json["itemname"],
//         unit: json["unit"],
//         costperunit: json["costperunit"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toMap() => {
//         "stockid": stockid,
//         "itemname": itemname,
//         "unit": unit,
//         "costperunit": costperunit,
//         "image": image,
//       };
// }

//-------------------
// To parse this JSON data, do
//
//     final resultData = resultDataFromMap(jsonString);

// import 'dart:convert';

// ResultData resultDataFromMap(String str) =>
//     ResultData.fromMap(json.decode(str));

// String resultDataToMap(ResultData data) => json.encode(data.toMap());

// class ResultData {
//   ResultData({
//     required this.trxid,
//     required this.datetime,
//     required this.reqid,
//     required this.id,
//     required this.serverkey,
//     required this.responsecode,
//     required this.message,
//     required this.result,
//   });

//   String trxid;
//   String datetime;
//   String reqid;
//   String id;
//   int serverkey;
//   String responsecode;
//   String message;
//   List<Result> result;

//   factory ResultData.fromMap(Map<String, dynamic> json) => ResultData(
//         trxid: json["trxid"],
//         datetime: json["datetime"],
//         reqid: json["reqid"],
//         id: json["id"],
//         serverkey: json["serverkey"],
//         responsecode: json["responsecode"],
//         message: json["message"],
//         result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "trxid": trxid,
//         "datetime": datetime,
//         "reqid": reqid,
//         "id": id,
//         "serverkey": serverkey,
//         "responsecode": responsecode,
//         "message": message,
//         "result": List<dynamic>.from(result.map((x) => x.toMap())),
//       };
// }

// class Result {
//   Result({
//     required this.stockid,
//     required this.itemname,
//     required this.unit,
//     required this.costperunit,
//     required this.image,
//   });

//   String stockid;
//   String itemname;
//   String unit;
//   String costperunit;
//   List<String> image;

//   factory Result.fromMap(Map<String, dynamic> json) => Result(
//         stockid: json["stockid"],
//         itemname: json["itemname"],
//         unit: json["unit"],
//         costperunit: json["costperunit"],
//         image: List<String>.from(json["image"].map((x) => x)),
//       );

//   Map<String, dynamic> toMap() => {
//         "stockid": stockid,
//         "itemname": itemname,
//         "unit": unit,
//         "costperunit": costperunit,
//         "image": List<dynamic>.from(image.map((x) => x)),
//       };
// }

//--------------------
// To parse this JSON data, do
//
//     final resultData = resultDataFromMap(jsonString);

// To parse this JSON data, do
//
//     final resultData = resultDataFromMap(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ResultData resultDataFromMap(String str) =>
    ResultData.fromMap(json.decode(str));

String resultDataToMap(ResultData data) => json.encode(data.toMap());

class ResultData {
  ResultData({
    required this.trxid,
    required this.datetime,
    required this.reqid,
    required this.id,
    required this.serverkey,
    required this.responsecode,
    required this.message,
    required this.result,
  });

  String trxid;
  String datetime;
  String reqid;
  String id;
  int serverkey;
  String responsecode;
  String message;
  List<Result> result;

  factory ResultData.fromMap(Map<String, dynamic> json) => ResultData(
        trxid: json["trxid"],
        datetime: json["datetime"],
        reqid: json["reqid"],
        id: json["id"],
        serverkey: json["serverkey"],
        responsecode: json["responsecode"],
        message: json["message"],
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "trxid": trxid,
        "datetime": datetime,
        "reqid": reqid,
        "id": id,
        "serverkey": serverkey,
        "responsecode": responsecode,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    required this.stockid,
    required this.itemname,
    required this.unit,
    required this.costperunit,
    required this.image,
  });

  String stockid;
  String itemname;
  String unit;
  String costperunit;
  List<String> image;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        stockid: json["stockid"],
        itemname: json["itemname"],
        unit: json["unit"],
        costperunit: json["costperunit"],
        image: List<String>.from(json["image"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "stockid": stockid,
        "itemname": itemname,
        "unit": unit,
        "costperunit": costperunit,
        "image": List<dynamic>.from(image.map((x) => x)),
      };
}

//-------------------
// To parse this JSON data, do
//
//     final resultData = resultDataFromMap(jsonString);

// import 'dart:convert';

// ResultData resultDataFromMap(String str) =>
//     ResultData.fromMap(json.decode(str));

// String resultDataToMap(ResultData data) => json.encode(data.toMap());

// class ResultData {
//   ResultData({
//     this.trxid,
//     this.datetime,
//     this.reqid,
//     this.id,
//     this.serverkey,
//     this.responsecode,
//     this.message,
//     this.result,
//   });

//   String? trxid;
//   String? datetime;
//   String? reqid;
//   String? id;
//   int? serverkey;
//   String? responsecode;
//   String? message;
//   List<Result>? result;

//   factory ResultData.fromMap(Map<String, dynamic> json) => ResultData(
//         trxid: json["trxid"],
//         datetime: json["datetime"],
//         reqid: json["reqid"],
//         id: json["id"],
//         serverkey: json["serverkey"],
//         responsecode: json["responsecode"],
//         message: json["message"],
//         result: json["result"] == null
//             ? null
//             : List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "trxid": trxid,
//         "datetime": datetime,
//         "reqid": reqid,
//         "id": id,
//         "serverkey": serverkey,
//         "responsecode": responsecode,
//         "message": message,
//         "result": result == null
//             ? null
//             : List<dynamic>.from(result!.map((x) => x.toMap())),
//       };
// }

// class Result {
//   Result({
//     this.stockid,
//     this.itemname,
//     this.unit,
//     this.costperunit,
//     this.image,
//   });

//   String? stockid;
//   String? itemname;
//   String? unit;
//   String? costperunit;
//   List<String>? image;

//   factory Result.fromMap(Map<String, dynamic> json) => Result(
//         stockid: json["stockid"],
//         itemname: json["itemname"],
//         unit: json["unit"],
//         costperunit: json["costperunit"],
//         image: json["image"] == null
//             ? null
//             : List<String>.from(json["image"].map((x) => x)),
//       );

//   Map<String, dynamic> toMap() => {
//         "stockid": stockid,
//         "itemname": itemname,
//         "unit": unit,
//         "costperunit": costperunit,
//         "image":
//             image == null ? null : List<dynamic>.from(image!.map((x) => x)),
//       };
// }
