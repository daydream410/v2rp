import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:v2rp1/routes/api_name.dart';
import '../../../../BE/reqip.dart';
import '../../../../BE/resD.dart';
// import 'package:v2rp1/BE/controller.dart';

import '../../../../main.dart';
import 'we_completed.dart';

class WoCompleted2 extends StatefulWidget {
  final seckey;
  final reffno;
  final tanggal;
  final duedate;
  final amount;
  final username;
  final projectid;
  final locationname;
  final description;
  final wipacc;
  final wipaccName;

  WoCompleted2({
    Key? key,
    required this.seckey,
    required this.reffno,
    required this.tanggal,
    required this.duedate,
    required this.amount,
    required this.username,
    required this.projectid,
    required this.locationname,
    required this.description,
    required this.wipacc,
    required this.wipaccName,
  }) : super(key: key);

  @override
  State<WoCompleted2> createState() => _WoCompleted2State();
}

final fromdate = TextEditingController().obs;
late DateTime fromdatee;
List listWoAcc = [];

class _WoCompleted2State extends State<WoCompleted2> {
  static late List dataaa = <CaConfirmData>[];

  late Future dataFuture;

  @override
  void initState() {
    super.initState();

    // Reset date input every time page is opened
    fromdate.value.text = '';

    dataFuture = getDataa();
    getWoAcc();
  }

  String reasonValue = '';
  // static TextControllers textControllers = Get.put(TextControllers());
  var valueChooseRequest = "";
  var valueStatus = "";
  var valueWo = "";
  var updstatus = "0";
  double totalPrice = 0;
  bool allDetailCompleted = false;
  bool isHeaderExpanded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

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
        appBar: AppBar(
          title: const Text("Work Order Completed"),
          centerTitle: true,
          backgroundColor: HexColor("#F4A62A"),
          foregroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => WoCompleted());
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 0,
            top: 5.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card with See More
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.001,
                  vertical: size.height * 0.02,
                ),
                constraints: isHeaderExpanded
                    ? BoxConstraints(
                        maxHeight: size.height * 0.25, // Reduced from 0.5 to 0.25
                      )
                    : null,
                decoration: BoxDecoration(
                  color: HexColor("#F4A62A"),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 60,
                      color: Colors.grey.withOpacity(0.40),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Add this to prevent overflow
                  children: [
                    const SizedBox(height: 10.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: ConstrainedBox(
                              constraints: isHeaderExpanded 
                                  ? BoxConstraints(
                                      maxHeight: size.height * 0.2, // Constraint for scrollable area
                                    )
                                  : const BoxConstraints(),
                              child: SingleChildScrollView(
                                physics: isHeaderExpanded
                                    ? const AlwaysScrollableScrollPhysics()
                                    : const NeverScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Reff No : ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            widget.reffno ?? "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text(
                                          'Date : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            DateFormat('yyyy-MM-dd').format(
                                                DateTime.parse(widget.tanggal)),
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isHeaderExpanded) ...[
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Est. Finish Date : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              DateFormat('yyyy-MM-dd').format(
                                                  DateTime.parse(widget.duedate)),
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Est. Amount : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              NumberFormat.currency(
                                                      locale: 'eu', symbol: '')
                                                  .format(widget.amount),
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Request By : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              widget.username ?? "",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Location : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              widget.locationname ?? "",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Text(
                                            'Project : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              widget.projectid ?? "",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'WIP Account : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              "${widget.wipaccName} (WIP ACC No: ${widget.wipacc})",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Description : ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              widget.description ?? "",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // See More/Less button
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 2.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isHeaderExpanded = !isHeaderExpanded;
                                });
                              },
                              icon: Icon(
                                  isHeaderExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: Colors.white),
                              label: Text(
                                  isHeaderExpanded ? 'See Less' : 'See More',
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // New Card for Complete Work Order
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.001,
                  vertical: size.height * 0.01,
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: HexColor("#F4A62A"),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 20,
                      color: Colors.grey.withOpacity(0.20),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Input
                    Row(
                      children: [
                        const Text(
                          "Date : ",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white70,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 36,
                            child: TextField(
                              controller: fromdate.value,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                hintText: 'Select Date',
                                hintStyle: const TextStyle(
                                    color: Colors.white54, fontSize: 13),
                                prefixIcon: const Icon(Icons.calendar_today,
                                    size: 18, color: Colors.white),
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white24),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              readOnly: true,
                              onTap: () {
                                selectDateFrom();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Show type and button only if date is selected
                    if (fromdate.value.text.isNotEmpty) ...[
                      // Radio Buttons
                      Row(
                        children: [
                          const Text(
                            "Type : ",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white70,
                            ),
                          ),
                          Radio<String>(
                            value: '1',
                            groupValue: valueStatus,
                            onChanged: (val) {
                              setState(() {
                                valueStatus = val!;
                                valueWo =
                                    ""; // reset dropdown when type changes
                              });
                            },
                            activeColor: Colors.white,
                          ),
                          const Text('Capitalized',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                          Radio<String>(
                            value: '-1',
                            groupValue: valueStatus,
                            onChanged: (val) {
                              setState(() {
                                valueStatus = val!;
                                valueWo =
                                    ""; // reset dropdown when type changes
                              });
                            },
                            activeColor: Colors.white,
                          ),
                          const Text('Expended',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Posted to Account Dropdown (only show if Capitalized selected)
                      if (valueStatus == '1')
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Posted to Account : ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white24),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                dropdownColor: HexColor("#F4A62A"),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13),
                                value: valueWo.isNotEmpty ? valueWo : null,
                                items: listWoAcc
                                    .map<DropdownMenuItem<String>>((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['ket'].toString(),
                                    child: Text(
                                      item['ket'].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    valueWo = val as String;
                                    print('Posted to Account selected: ' +
                                        valueWo);
                                  });
                                },
                                hint: const Text('Select Account',
                                    style: TextStyle(color: Colors.white54)),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 10),
                      // Complete Work Order Button
                      // Button moved to bottomNavigationBar
                    ],
                  ],
                ),
              ),
              FutureBuilder(
                future: dataFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.error != null) {
                    return const Center(
                      child: Text('Error Loading Data'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: Column(
                      children: [
                        Text('Loading Detail...'),
                        SizedBox(
                          height: 20,
                        ),
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        // Text('Please Kindly Waiting...'),
                      ],
                    ));
                  } else {
                    print("snapshot data " + snapshot.data.toString());
                    if (dataaa.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.inbox, size: 48, color: Colors.grey),
                                SizedBox(height: 16),
                                Text(
                                  'No Detail',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Tidak ada data detail untuk work order ini.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: DataTable2(
                        columnSpacing: 15,
                        horizontalMargin: 12,
                        minWidth: 1700,
                        dataRowHeight: 70,
                        columns: const [
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'SPPBJ No',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Status',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Item / Budget',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Unit',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'QTY',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Column(
                              children: [
                                Text(
                                  'Closing',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            numeric: true,
                            size: ColumnSize.S,
                          ),
                        ],
                        rows: dataaa
                            .map((e) => DataRow(cells: [
                                  DataCell(Text(
                                    e['sppbjno'] ??
                                        e['nolpjk'] ??
                                        e['nokasbon'] ??
                                        '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['tanggal'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['statusname'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  )),
                                  DataCell(Text(
                                    '${e['itemcoa']} - ${e['itemname']} - ${e['ket']}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['unit'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    e['qty'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '')
                                        .format(e['harga']),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '')
                                        .format(e['amount']),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                  DataCell(Text(
                                    (e['completedate'] ?? '').toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  )),
                                ]))
                            .toList(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: dataFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.error != null) {
                    return const Center(
                      child: Text('Error Loading Data'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text('Please Kindly Waiting...'),
                      ],
                    ));
                  } else {
                    if (dataaa.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'TOTAL = ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'eu', symbol: '')
                              .format(totalPrice),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            // Only show if date sudah dipilih
            if (fromdate.value.text.isNotEmpty) {
              // Button enable conditions:
              // 1. Type sudah dipilih dan semua detail Completed
              // 2. Type Expended (-1) dan tidak ada data detail
              bool enableButton = valueStatus.isNotEmpty && 
                  (allDetailCompleted || (valueStatus == '-1' && dataaa.isEmpty));
              print("Debug button enable conditions:");
              print("Date selected: ${fromdate.value.text.isNotEmpty}");
              print("Type selected: ${valueStatus.isNotEmpty} (value: $valueStatus)");
              print("All detail completed: $allDetailCompleted");
              print("Data is empty: ${dataaa.isEmpty}");
              print("Is Expended with no data: ${valueStatus == '-1' && dataaa.isEmpty}");
              print("Button enabled: $enableButton");
              return SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: HexColor("#F4A62A"),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: enableButton
                      ? () {
                          if (valueStatus == '1') {
                            // Capitalized: posted to account harus dipilih
                            if (valueWo.isEmpty) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                title: 'Peringatan',
                                text:
                                    'Pilih Posted to Account terlebih dahulu!',
                              );
                            } else {
                              sendConfirm();
                            }
                          } else {
                            sendConfirm();
                          }
                        }
                      : null,
                  child: const Text('Complete Work Order'),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ),
      ),
    );
  }

  Future<dynamic> getDataa() async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    try {
      var getData = await http.get(
        Uri.https(ApiName.v2rp, ApiName.woCompleted + widget.seckey),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);
      dataaa = caConfirmData['data']['detail'];
      print("totalllll  " + totalPrice.toString());
      print("dataaa " + dataaa.toString());

      //hitung total
      totalPrice = 0;
      bool allCompleted = true;
      for (var item in dataaa) {
        // Safe conversion for amount - handle both int and double
        var amount = item["amount"];
        if (amount != null) {
          if (amount is int) {
            totalPrice += amount.toDouble();
          } else if (amount is double) {
            totalPrice += amount;
          } else {
            // Fallback: try to parse as double
            try {
              totalPrice += double.parse(amount.toString());
            } catch (e) {
              print("Error parsing amount: $amount, error: $e");
            }
          }
        }
        
        String statusNameRaw = (item["statusname"] ?? '').toString().trim();
        String statusNameLower = statusNameRaw.toLowerCase();
        print("Item status raw: '$statusNameRaw'");
        print("Item status processed: '$statusNameLower'");
        
        // Check multiple possible variations of "completed"
        bool isCompleted = statusNameRaw == 'Completed' ||  // Exact match with capital C
                          statusNameLower == 'completed' ||   // lowercase match
                          statusNameLower == 'complete' ||
                          statusNameLower.contains('complet');
        
        print("Is completed: $isCompleted");
        if (!isCompleted) {
          allCompleted = false;
          print("Found non-completed item: '$statusNameRaw'");
        }
      }
      print("All details completed: $allCompleted");
      setState(() {
        allDetailCompleted = allCompleted;
      });
      return dataaa;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getWoAcc() async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    try {
      var getData = await http.get(
        Uri.https(ApiName.v2rp, ApiName.woCompletedAcc),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);
      var result = caConfirmData['data'];
      print("dataaa acccccc" + result.toString());
      print(result[0]['ket']);
      setState(() {
        listWoAcc = result;
      });
      for (var item in result) {
        print(item['ket']);
      }
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendConfirm() async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    var status;
    var message;
    var messageError;

    // Build request body
    String? wipaccBody;
    if (valueStatus == '1') {
      // Capitalized: cari coa_acc dari listWoAcc berdasarkan valueWo (ket)
      final acc = listWoAcc.firstWhereOrNull((item) => item['ket'] == valueWo);
      wipaccBody = acc != null ? acc['coa_acc']?.toString() : null;
    }
    // tglselesai dari date input
    String tglselesaiBody = fromdate.value.text;
    // hasil: 1 jika Capitalized, -1 jika Expended (as int)
    int? hasilBody;
    if (valueStatus == '1') {
      hasilBody = 1;
    } else if (valueStatus == '-1') {
      hasilBody = -1;
    }
    print('Debug sendConfirm: valueStatus = '
        '$valueStatus, hasilBody = $hasilBody, wipaccBody = $wipaccBody, tglselesaiBody = $tglselesaiBody');

    var body = json.encode({
      'wipacc': wipaccBody,
      'tglselesai': tglselesaiBody,
      'hasil': hasilBody,
    });
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Submitting your data',
      barrierDismissible: false,
      disableBackBtn: true,
    );
    try {
      var getData = await http.put(
        Uri.https(
          ApiName.v2rp,
          ApiName.woCompleted + widget.seckey + '/' + '1',
        ),
        body: body,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final response = json.decode(getData.body);
      print(response.toString());
      setState(() {
        status = response['success'];
        messageError = response['message'];
      });
      if (status == true) {
        setState(() {
          message = response['data']['message'];
        });
        
        // Invalidate cache for completed transaction - remove only specific transaction
        try {
          final prefs = await SharedPreferences.getInstance();
          
          // Load current main cache
          final cacheData = prefs.getString('wo_completed_cache');
          if (cacheData != null) {
            List cachedList = json.decode(cacheData);
            
            // Remove completed transaction from main cache
            cachedList.removeWhere((item) => 
              item is Map && 
              item['header'] is Map && 
              item['header']['reffno'] == widget.reffno);
            
            // Update main cache with JSON-safe data
            List jsonSafeList = [];
            try {
              String jsonString = json.encode(cachedList);
              jsonSafeList = json.decode(jsonString);
            } catch (e) {
              print("Error converting cache to JSON-safe format: $e");
              jsonSafeList = cachedList; // Use original if conversion fails
            }
            
            await prefs.setString('wo_completed_cache', json.encode(jsonSafeList));
            print("Transaction ${widget.reffno} removed from main cache");
          }
          
          // Load and update page-specific cache
          final cachedPagesData = prefs.getString('wo_completed_cache_pages');
          if (cachedPagesData != null) {
            try {
              final Map<String, dynamic> pages = json.decode(cachedPagesData);
              bool cacheUpdated = false;
              
              // Remove transaction from each cached page
              pages.forEach((pageKey, pageData) {
                if (pageData is List) {
                  int initialLength = pageData.length;
                  pageData.removeWhere((item) => 
                    item is Map && 
                    item['header'] is Map && 
                    item['header']['reffno'] == widget.reffno);
                  
                  if (pageData.length != initialLength) {
                    cacheUpdated = true;
                    print("Transaction ${widget.reffno} removed from cached page $pageKey");
                  }
                }
              });
              
              if (cacheUpdated) {
                // Save updated page cache
                await prefs.setString('wo_completed_cache_pages', json.encode(pages));
                print("Page cache updated - transaction removed but cache preserved");
              }
            } catch (e) {
              print("Error updating page cache: $e");
              // Don't clear cache on error, just log it
            }
          }
          
          // Update last access time to keep cache valid
          await prefs.setInt('wo_completed_cache_last_access', DateTime.now().millisecondsSinceEpoch);
          print("Cache last access time updated to keep cache valid");
          
        } catch (e) {
          print("Error invalidating cache: $e");
        }
        
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Success $message Data!',
            barrierDismissible: false,
            disableBackBtn: true,
            // confirmBtnText: 'OK',
            onConfirmBtnTap: () async {
              Get.to(WoCompleted());
            },
            showCancelBtn: true,
            cancelBtnText: 'Home',
            onCancelBtnTap: () async {
              Get.to(const Navbar());
            });
      } else {
        setState(() {
          message = response['data']['message'];
        });
        await Future.delayed(const Duration(milliseconds: 1000));
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          disableBackBtn: true,
          title: 'Failed! ' + widget.reffno,
          text: '$message',
          onConfirmBtnTap: () async {
            Get.to(WoCompleted());
          },
        );
      }
    } catch (e) {
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        disableBackBtn: true,
        title: 'Error! ' + widget.reffno,
        text: '$messageError',
        onConfirmBtnTap: () async {
          Get.to(WoCompleted());
        },
      );
    }
  }

  Future<void> selectDateFrom() async {
    DateTime? pickedFrom = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: HexColor("#F4A62A"), // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: HexColor("#F4A62A"), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedFrom != null) {
      setState(() {
        fromdate.value.text = pickedFrom.toString().split(" ")[0];
        fromdatee = pickedFrom;
      });
      print(fromdate.value.text);
      print(fromdatee.toString());
    }
  }
}
