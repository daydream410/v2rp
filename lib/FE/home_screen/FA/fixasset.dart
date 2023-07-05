// // ignore_for_file: avoid_print, unused_field, unrelated_type_equality_checks, unnecessary_new, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unnecessary_null_comparison, prefer_const_constructors

// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:v2rp1/BE/controller.dart';
// import 'package:v2rp1/BE/reqip.dart';
// import 'package:v2rp1/FE/FA/fixasset_scanner.dart';
// import 'package:v2rp1/FE/navbar/navbar.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';

// class FixAsset extends StatefulWidget {
//   const FixAsset({Key? key}) : super(key: key);

//   @override
//   State<FixAsset> createState() => _FixAssetState();
// }

// class _FixAssetState extends State<FixAsset> {
//   static var hasilSearch;
//   static var conve = MsgHeader.conve;
//   static var trxid = MsgHeader.trxid;
//   static var datetime = MsgHeader.datetime;
//   static late TextControllers textControllers = Get.put(TextControllers());
//   static var serverKeyValue;
//   // late File image;
//   late File uploadImage;

//   late List _dataaa = <FixAsset>[];
//   late final List _dataaa1 = <FixAsset>[];
//   // late List _foto;
//   late int selectedIndex;
//   // late var imageName;

//   @override
//   void initState() {
//     super.initState();
//     if (textControllers.fixassetController.value != null) {
//       searchProcess();
//     }
//   }

//   @override
//   void dispose() {
//     textControllers.dispose();
//     super.dispose();
//   }

//   Future<String> getData() async {
//     var searchValue = textControllers.fixassetController.value.text;
//     var sendSearch = await http.post(Uri.https('www.v2rp.net', '/ptemp/'),
//         headers: {'x-v2rp-key': '$conve'},
//         body: jsonEncode({
//           "trxid": "$trxid",
//           "datetime": "$datetime",
//           "reqid": "501001",
//           "id": "$searchValue"
//         }));
//     // final resultData = json.decode(sendSearch.body);
//     // serverKeyValue = resultData['serverkey'];

//     final fixAsset = json.decode(sendSearch.body);
//     serverKeyValue = fixAsset['serverkey'];
//     var responsecode = fixAsset['responsecode'];
//     var responseMessage = fixAsset['message'];

//     if (responsecode == '00') {
//       setState(() {
//         _dataaa = json.decode(sendSearch.body)['result'];
//         textControllers.fixassetController.value.clear();
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
//         textControllers.fixassetController.value.clear();
//       });
//     }
//     print(sendSearch.body);

//     print(serverKeyValue);
//     return "Successfull";
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
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
//           title: const Text("Fixed Assets"),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 1,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Get.to(() => Navbar());
//             },
//           ),
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       'Fixed Assets',
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
//                   controller: textControllers.fixassetController.value,
//                   onSubmitted: (value) {
//                     searchProcess();
//                     setState(() {
//                       textControllers.fixassetController.value.clear();
//                     });
//                   },
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.assignment),
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.qr_code_2),
//                       onPressed: () async {
//                         Get.to(() => ScanFixAsset());
//                       },
//                       splashColor: Colors.green,
//                       tooltip: 'Scan',
//                       hoverColor: Colors.green,
//                     ),
//                     hintText: 'FA Number / Item Name',
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
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 15.0),
//                       SizedBox(
//                         height: size.height * 0.80,
//                         child: ListView.separated(
//                           scrollDirection: Axis.horizontal,
//                           physics: const BouncingScrollPhysics(),
//                           separatorBuilder: (context, index) {
//                             return SizedBox(
//                               width: size.width * 0.10,
//                             );
//                           },
//                           shrinkWrap: true,
//                           itemCount: _dataaa.length,
//                           itemBuilder: (context, index) {
//                             return Card(
//                               clipBehavior: Clip.antiAlias,
//                               shadowColor: HexColor('#F4A62A'),
//                               elevation: 5,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(24),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Stack(
//                                     children: [
//                                       InkWell(
//                                         onLongPress: () {
//                                           dialogImage();
//                                           setState(() {
//                                             selectedIndex = index;
//                                           });
//                                         },
//                                         child: Ink.image(
//                                           image: NetworkImage(
//                                             'https://v2rp.net/' +
//                                                 _dataaa[index]['imagedir'],
//                                           ),
//                                           height: 300,
//                                           width: 350,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       Positioned(
//                                         bottom: 0,
//                                         right: 0,
//                                         left: 0,
//                                         child: Container(
//                                           color: HexColor('#F4A62A'),
//                                           child: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 20),
//                                             child: Text(
//                                               _dataaa[index]['description'],
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Color.fromARGB(
//                                                     255, 255, 255, 255),
//                                                 fontSize: 24,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                       left: 20,
//                                       top: 10,
//                                       bottom: 0,
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: const [
//                                             Text(
//                                               'F/Assets No.    ',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Description',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Category',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Brand',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Made In',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Reff.No.',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Req.No.',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'P/O No.',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Request By',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Serial No.',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Location',
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               _dataaa[index]['fadatano'],
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             Text(
//                                               _dataaa[index]['description'],
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   _dataaa[index]
//                                                       ['categoryname'],
//                                                   style: const TextStyle(
//                                                     fontSize: 15,
//                                                   ),
//                                                 ),
//                                                 const Text(
//                                                   ' - ',
//                                                   style: TextStyle(
//                                                     fontSize: 15,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   _dataaa[index]
//                                                       ['subcategoryname'],
//                                                   style: const TextStyle(
//                                                     fontSize: 15,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   _dataaa[index]['brandname'],
//                                                   style: const TextStyle(
//                                                     fontSize: 15,
//                                                   ),
//                                                 ),
//                                                 const Text(
//                                                   ' - ',
//                                                   style: TextStyle(
//                                                     fontSize: 15,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   _dataaa[index]
//                                                       ['brandtipename'],
//                                                   style: const TextStyle(
//                                                     fontSize: 15,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Text(
//                                               _dataaa[index]['countryname'],
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               _dataaa[index]['reffno'],
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               _dataaa[index]['reqno'],
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               _dataaa[index]['pono'],
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               _dataaa[index]['requestby'],
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               _dataaa[index]['serialno'],
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               _dataaa[index]['locationname'],
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     ]),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   dialogImage() {
//     Get.defaultDialog(
//       title: "Upload Foto Fixed Assets",
//       middleText: "Please Click Below",
//       backgroundColor: HexColor('#F4A62A'),
//       confirm: ElevatedButton(
//         onPressed: () {
//           pilihGambar();
//         },
//         child: Text('Choose Image'),
//       ),
//       cancel: ElevatedButton(
//         onPressed: () {
//           // takeImage();
//         },
//         child: Text('Take Picture'),
//       ),
//     );
//   }

//   // Future<void> chooseImage() async {
//   //   try {
//   //     final image =
//   //         await ImagePicker().pickImage(source: ImageSource.gallery);
//   //     if (image == null) return;
//   //     final imageTemporary = File(image.path);
//   //     // setState(() => this.image = imageTemporary);
//   //     setState(() {
//   //       this.choosedimage = imageTemporary;
//   //       // imageName = basename(image.path);
//   //     });
//   //     if (image != null) {
//   //       print("sukses memilih gambar");
//   //     } else {
//   //       print("tidak ada gambar yang dipilih");
//   //     }
//   //     uploadImage();
//   //   } on PlatformException catch (e) {
//   //     print('Failed to pick image: $e');
//   //   }
//   // }

//   //-------------------------
//   Future<void> pilihGambar() async {
//     var choosedimage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (choosedimage == null) return;
//     setState(() {
//       uploadImage = File(choosedimage.path);
//     });

//     if (uploadImage != null) {
//       print('Ada Gambar = ' + uploadImage.toString());
//     } else {
//       print('Tidak Ada GAmbar');
//     }
//     sendImage();
//   }
// //---------------
//   // Future<void> sendImage() async {
//   //   try {
//   //     List<int> imageBytes = uploadImage.readAsBytesSync();
//   //     String baseimage = base64Encode(imageBytes);
//   //     var response = await http.post(
//   //       Uri.https('www.v2rp.net', '/codebase/php/uploadfmmobile.php'),
//   //       body: jsonEncode({
//   //         "trxid": "$trxid",
//   //         "datetime": "$datetime",
//   //         "reqid": "Upload",
//   //         "id": "$selectedIndex",
//   //         "image": "$baseimage",
//   //       }),
//   //     );
//   //     var hasil = json.decode(response.body);
//   //     print(hasil);
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
//   //------------------
//   // Future<void> takeImage() async {
//   //   try {
//   //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
//   //     if (image == null) return;

//   //     final imageTemporary = File(image.path);
//   //     setState(() => this.image = imageTemporary);
//   //   } on PlatformException catch (e) {
//   //     print('Failed to pick image: $e');
//   //   }
//   //   // setState(() {
//   //   //   uploadImage = choosedImage as File;
//   //   // });
//   // }

//   // Future<void> sendImage() async {
//   //   try {
//   //     //       // var response = await http.post(
//   //     //       //   Uri.https('www.v2rp.net', '/codebase/php/uploadfmmobile.php'),
//   //     //       //   headers: {'x-v2rp-key': '$conve'},
//   //     //       //   body: jsonEncode({
//   //     //       //     "id": "FA/PNEP/000044",
//   //     //       //     // "id": "$_dataaa['itemname']",
//   //     //       //     // "image": "$image",
//   //     //       //   }
//   //     //       //   ));
//   //     List<int> imageBytes = uploadImage.readAsBytesSync();
//   //     String baseimage = base64Encode(imageBytes);
//   //     var sendSearch = await http.post(
//   //       Uri.https('www.v2rp.net', 'codebase/php/uploadfmmobile.php'),
//   //       headers: {'x-v2rp-key': '$conve'},
//   //       body: jsonEncode({
//   //         "trxid": "$trxid",
//   //         "datetime": "$datetime",
//   //         "reqid": "Upload",
//   //         "id": "$selectedIndex",
//   //         // "file": "$image",
//   //         "image": baseimage,
//   //       }),
//   //     );
//   //     var hasil = json.decode(sendSearch.body);
//   //     print(hasil);
//   //     //       //-------------------------------------
//   //     //       // var stream = new http.ByteStream(image.openRead());
//   //     //       // stream.cast();
//   //     //       // var length = await image.length();
//   //     //       // var uri = Uri.parse('https://www.v2rp.com/ptemp/');
//   //     //       // var request = new http.MultipartRequest('POST', uri);
//   //     //       // request.fields['fadatano'];
//   //     //       // var multiport = new http.MultipartFile('image', stream, length);
//   //     //       // request.files.add(multiport);
//   //     //       // var response = await request.send();

//   //     //       // print(response.stream);

//   //     //       // if (response.statusCode == 200) {
//   //     //       //   print('Image Uploaded');
//   //     //       // } else {
//   //     //       //   print('Failed upload');
//   //     //       // }
//   //     //       //------------
//   //     //       // var request = http.MultipartRequest(
//   //     //       //   'POST',
//   //     //       //   Uri.parse("https://www.v2rp.net/codebase/php/uploadfmmobile.php"),
//   //     //       // );
//   //     //       // request.files.add(http.MultipartFile(
//   //     //       //   'image',
//   //     //       //   image.readAsBytes().asStream(),
//   //     //       //   image.lengthSync(),
//   //     //       // contentType: MediaType('image','jpeg'),
//   //     //       // ));
//   //     //       // request.fields.addAll(
//   //     //       //   "id" : "$selectedIndex",
//   //     //       // );
//   //   } catch (e) {
//   //     print("Failed Connect To Server");
//   //   }
//   // }

//   Future<void> sendImage() async {
//     String uploadurl = "https://www.v2rp.net/codebase/php/uploadfmmobile.php";

//     try {
//       List<int> imageBytes = uploadImage.readAsBytesSync();
//       String baseimage = base64Encode(imageBytes);
//       var response = await http.post(
//         Uri.parse(uploadurl),
//         body: jsonEncode(
//           {
//             // "id": "$selectedIndex",
//             "id": "$_dataaa['fadatano']",
//             "image": baseimage,
//           },
//         ),
//       );
//       print("base image = " + baseimage.toString());
//       print("berhasil upload");
//       var hasil = await json.decode(json.encode(response.body));
//       print("hasil = " + hasil.toString());
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> searchProcess() async {
//     var searchResult = textControllers.fixassetController.value.text;
//     try {
//       if (searchResult.length >= 3) {
//         getData();
//       } else {
//         Get.snackbar(
//           "Error!",
//           "Please Enter Valid FA Number / Item Name",
//           backgroundColor: Colors.red,
//           isDismissible: true,
//           dismissDirection: DismissDirection.horizontal,
//         );
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   listData() async {
//     if (_dataaa.length != null) {
//       return ListView.builder(
//         shrinkWrap: true,
//         // itemCount: _dataaa == null ? 0 : _dataaa.length,
//         itemCount: _dataaa.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Text(_dataaa[index]['itemname']),
//               subtitle: Text(_dataaa[index]['stockid']),
//               tileColor: HexColor('#F4A62A'),
//               textColor: Colors.white,
//             ),
//           );
//         },
//       );
//     } else if (_dataaa1.length != null) {
//       return ListView.builder(
//         shrinkWrap: true,
//         itemCount: _dataaa1.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Text(_dataaa1[index]['itemname']),
//               subtitle: Text(_dataaa1[index]['stockid']),
//               tileColor: HexColor('#F4A62A'),
//               textColor: Colors.white,
//             ),
//           );
//         },
//       );
//     }
//   }
// }
