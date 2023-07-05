// // ignore_for_file: avoid_print, unused_field, unrelated_type_equality_checks, unnecessary_new, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unnecessary_null_comparison, prefer_const_constructors

// import 'dart:convert';
// import 'dart:math';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:v2rp1/BE/controller.dart';
// import 'package:v2rp1/BE/reqip.dart';
// import 'package:v2rp1/BE/resD.dart';
// import 'package:v2rp1/FE/StockTable/stocktable_scanner.dart';
// import 'package:v2rp1/FE/navbar/navbar.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';

// class StockTable extends StatefulWidget {
//   const StockTable({Key? key}) : super(key: key);

//   @override
//   State<StockTable> createState() => _StockTableState();
// }

// class _StockTableState extends State<StockTable> {
//   static var hasilSearch;
//   static var conve = MsgHeader.conve;
//   static var trxid = MsgHeader.trxid;
//   static var datetime = MsgHeader.datetime;
//   static TextControllers textControllers = Get.put(TextControllers());
//   // static var searchVal = textControllers.stocktableController.value.text;
//   static var serverKeyValue;
//   static TextField codebar = TextField();

//   static late List _dataaa = <ResultData>[];
//   static late int selectedIndex;

//   @override
//   void dispose() {
//     // _debounce?.cancel();
//     super.dispose();
//   }

//   // _onSearchChanged(String query) {
//   //   if (_debounce?.isActive ?? false) _debounce?.cancel();
//   //   _debounce = Timer(const Duration(milliseconds: 500), () {
//   //     searchProcess();
//   //   });
//   // }

//   Future<String> getData() async {
//     String? searchValue = textControllers.stocktableController.value.text;
//     var sendSearch = await http.post(Uri.https('www.v2rp.net', '/ptemp/'),
//         headers: {'x-v2rp-key': '$conve'},
//         body: jsonEncode({
//           "trxid": "$trxid",
//           "datetime": "$datetime",
//           "reqid": "0002",
//           "id": "$searchValue"
//         }));
//     print(searchValue);
//     final resultData = json.decode(sendSearch.body);
//     serverKeyValue = resultData['serverkey'];
//     var responsecode = resultData['responsecode'];
//     var responseMessage = resultData['message'];
//     // print(selectedImage);
//     if (responsecode == '00') {
//       setState(() {
//         _dataaa = json.decode(sendSearch.body)['result'];
//         textControllers.stocktableController.value.clear();
//       });
//     } else {
//       Get.snackbar(
//         'Failed!',
//         '$responseMessage',
//         icon: Icon(Icons.warning),
//         backgroundColor: Colors.red,
//         isDismissible: true,
//         dismissDirection: DismissDirection.horizontal,
//       );
//       setState(() {
//         _dataaa.clear();
//         textControllers.stocktableController.value.clear();
//       });
//     }
//     print(sendSearch.body);
//     // print(_dataaa);
//     print(searchValue);

//     print(serverKeyValue);
//     return "Successfull";
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (textControllers.stocktableController.value != null) {
//       searchProcess();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Are u sure?'),
//             content: const Text('Do you want to exit the App?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 child: const Text('No'),
//               ),
//               TextButton(
//                 onPressed: () => SystemNavigator.pop(),
//                 child: const Text('Yes'),
//               ),
//             ],
//           ),
//         );
//         throw (e);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Stock Table"),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 1,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Navbar()),
//               );
//             },
//           ),
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       'Stock Table',
//                       textAlign: TextAlign.center,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 TextField(
//                   controller: textControllers.stocktableController.value,
//                   onSubmitted: (value) {
//                     searchProcess();
//                     setState(() {
//                       _dataaa.clear();
//                     });
//                   },
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.assignment),
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.qr_code_2),
//                       onPressed: () async {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const ScanSTable(),
//                         ));
//                       },
//                       splashColor: Colors.green,
//                       tooltip: 'Scan',
//                       hoverColor: Colors.green,
//                     ),
//                     hintText: 'Stock Code / Item Name',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(color: Colors.black)),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Divider(
//                   color: Colors.black,
//                   thickness: 0.8,
//                   height: 25,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Item List'),
//                     const SizedBox(height: 15.0),
//                     ListView.builder(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: _dataaa.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child: ListTile(
//                             title: Text(_dataaa[index]['itemname']),
//                             subtitle: Text(_dataaa[index]['stockid']),
//                             tileColor: HexColor('#E6BF00'),
//                             textColor: Colors.white,
//                           ),
//                         );
//                       },
//                     ),
//                     //----------------
//                     // Column(
//                     //   crossAxisAlignment: CrossAxisAlignment.start,
//                     //   mainAxisAlignment: MainAxisAlignment.start,
//                     //   children: [
//                     //     SizedBox(
//                     //       height: MediaQuery.of(context).size.height * 0.63,
//                     //       child: ListView.separated(
//                     //         separatorBuilder: (context, index) {
//                     //           return SizedBox(
//                     //             height:
//                     //                 MediaQuery.of(context).size.height * 0.02,
//                     //           );
//                     //         },
//                     //         physics: const BouncingScrollPhysics(),
//                     //         itemCount: _dataaa.length,
//                     //         itemBuilder: (context, index) {
//                     //           return Card(
//                     //             clipBehavior: Clip.antiAlias,
//                     //             elevation: 5,
//                     //             color: HexColor('#E6BF00'),
//                     //             child: Row(
//                     //               children: [
//                     //                 InkWell(
//                     //                   onDoubleTap: () {
//                     //                     imageBottomSheet();
//                     //                     // setState(() {
//                     //                     //   selectedIndex = index;
//                     //                     // });
//                     //                   },
//                     //                   splashColor: Colors.blue,
//                     //                   child: Ink.image(
//                     //                     image: NetworkImage(
//                     //                       'https://v2rp.net/' +
//                     //                           _dataaa[index]['image'][0],
//                     //                     ),
//                     //                     height:
//                     //                         MediaQuery.of(context).size.height *
//                     //                             0.20,
//                     //                     width:
//                     //                         MediaQuery.of(context).size.width *
//                     //                             0.40,
//                     //                     fit: BoxFit.cover,
//                     //                   ),
//                     //                 ),
//                     //                 SizedBox(
//                     //                   width: 15,
//                     //                 ),
//                     //                 Expanded(
//                     //                   child: Column(
//                     //                     crossAxisAlignment:
//                     //                         CrossAxisAlignment.start,
//                     //                     children: [
//                     //                       SizedBox(
//                     //                         height: 20,
//                     //                       ),
//                     //                       Text(
//                     //                         _dataaa[index]['itemname'],
//                     //                         style:
//                     //                             TextStyle(color: Colors.white),
//                     //                       ),
//                     //                       SizedBox(
//                     //                         height: 5,
//                     //                       ),
//                     //                       Text(
//                     //                         _dataaa[index]['stockid'],
//                     //                         style:
//                     //                             TextStyle(color: Colors.white),
//                     //                       ),
//                     //                       Padding(
//                     //                         padding: const EdgeInsets.only(
//                     //                           top: 30,
//                     //                           right: 15,
//                     //                         ),
//                     //                         child: Align(
//                     //                           alignment: Alignment.bottomRight,
//                     //                           child: ElevatedButton(
//                     //                             onPressed: () {},
//                     //                             child: Text('Add Image'),
//                     //                           ),
//                     //                         ),
//                     //                       ),
//                     //                     ],
//                     //                   ),
//                     //                 ),
//                     //               ],
//                     //             ),
//                     //           );
//                     //         },
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> imageBottomSheet() async {
//     showMaterialModalBottomSheet(
//       context: context,
//       builder: (context) => PhotoViewGallery.builder(
//         scrollPhysics: const BouncingScrollPhysics(),
//         builder: (BuildContext context, int index) {
//           return PhotoViewGalleryPageOptions(
//               imageProvider: NetworkImage('https://v2rp.net/' +
//                   _dataaa[index]['image']), //problem disini
//               initialScale: PhotoViewComputedScale.contained * 0.8,
//               heroAttributes: _dataaa[index]['fadatano']);
//         },
//         itemCount: _dataaa.length, //problem disini
//         loadingBuilder: (context, event) => Center(
//           child: Container(
//             width: 20.0,
//             height: 20.0,
//             child: CircularProgressIndicator(
//               value: event == null
//                   ? 0
//                   : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> searchProcess() async {
//     var searchResult = textControllers.stocktableController.value.text;
//     try {
//       if (searchResult.length >= 3) {
//         getData();
//       } else {
//         Get.snackbar(
//           "Error",
//           "Please Enter Valid Stock Code / Item Name",
//           icon: Icon(Icons.close),
//           backgroundColor: Colors.red,
//           isDismissible: true,
//           dismissDirection: DismissDirection.horizontal,
//         );
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
