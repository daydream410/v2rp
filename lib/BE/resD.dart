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

//------------------- CA CONFIRM DATA
CaConfirmData caConfirmDataFromMap(String str) =>
    CaConfirmData.fromMap(json.decode(str));

String caConfirmDataToMap(CaConfirmData data) => json.encode(data.toMap());

class CaConfirmData {
  CaConfirmData({
    required this.success,
    required this.kode,
    required this.status,
    required this.message,
    required this.data,
  });

  bool success;
  String kode;
  String status;
  String message;
  List<Data> data;

  factory CaConfirmData.fromMap(Map<String, dynamic> json) => CaConfirmData(
        success: json["trxid"],
        kode: json["datetime"],
        status: json["reqid"],
        message: json["id"],
        data: List<Data>.from(json["data"].map((x) => Data.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "kode": kode,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Data {
  Data({
    required this.seckey,
    required this.header,
    required this.detail,
  });

  String seckey;
  List<String> header;
  List<String> detail;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        seckey: json["seckey"],
        header: List<String>.from(json["header"].map((x) => x)),
        detail: List<String>.from(json["detail"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "seckey": seckey,
        "header": List<dynamic>.from(header.map((x) => x)),
        "detail": List<dynamic>.from(detail.map((x) => x)),
      };
}

class Header {
  Header({
    required this.nokasbon,
    required this.ket,
    required this.tanggal,
    required this.requestor,
    required this.requestorname,
    required this.updstatus,
    required this.kasir,
    required this.kasirname,
  });

  String nokasbon;
  String ket;
  String tanggal;
  String requestor;
  String requestorname;
  int updstatus;
  String kasir;
  String kasirname;

  factory Header.fromMap(Map<String, dynamic> json) => Header(
        nokasbon: json["nokasbon"],
        ket: json["ket"],
        tanggal: json["tanggal"],
        requestor: json["requestor"],
        requestorname: json["requestorname"],
        updstatus: json["updstatus"],
        kasir: json["kasir"],
        kasirname: json["kasirname"],
      );

  Map<String, dynamic> toMap() => {
        "nokasbon": nokasbon,
        "ket": ket,
        "tanggal": tanggal,
        "requestor": requestor,
        "requestorname": requestorname,
        "updstatus": updstatus,
        "kasir": kasir,
        "kasirname": kasirname,
      };
}

class Detail {
  Detail({
    required this.nokasbon,
    required this.scomp_id,
    required this.sdivisi,
    required this.sdept,
    required this.urutan,
    required this.requestor,
    required this.requestorname,
    required this.tipe,
    required this.itemcoa,
    required this.ket,
    required this.unit,
    required this.qty,
    required this.harga,
    required this.amount,
    required this.amtidr,
    required this.rem,
    required this.projectid,
    required this.projectname,
    required this.tanggal,
  });

  String nokasbon;
  String scomp_id;
  String sdivisi;
  String sdept;
  int urutan;
  String requestor;
  String requestorname;
  int tipe;
  String itemcoa;
  String ket;
  String unit;
  int qty;
  int harga;
  int amount;
  int amtidr;
  String rem;
  String projectid;
  String projectname;
  DateTime tanggal;

  factory Detail.fromMap(Map<String, dynamic> json) => Detail(
        nokasbon: json["nokasbon"],
        scomp_id: json["scomp_id"],
        sdivisi: json["sdivisi"],
        sdept: json["sdept"],
        urutan: json["urutan"],
        requestor: json["requestor"],
        requestorname: json["requestorname"],
        tipe: json["tipe"],
        itemcoa: json["itemcoa"],
        ket: json["ket"],
        unit: json["unit"],
        qty: json["qty"],
        harga: json["harga"],
        amount: json["amount"],
        amtidr: json["amtidr"],
        rem: json["rem"],
        projectid: json["projectid"],
        projectname: json["projectname"],
        tanggal: json["tanggal"],
      );

  Map<String, dynamic> toMap() => {
        "nokasbon": nokasbon,
        "scomp_id": scomp_id,
        "sdivisi": sdivisi,
        "sdept": sdept,
        "urutan": urutan,
        "requestor": requestor,
        "requestorname": requestorname,
        "tipe": tipe,
        "itemcoa": itemcoa,
        "ket": ket,
        "unit": unit,
        "qty": qty,
        "harga": harga,
        "amount": amount,
        "amtidr": amtidr,
        "rem": rem,
        "projectid": projectid,
        "projectname": projectname,
        "tanggal": tanggal,
      };
}
