// ignore_for_file: avoid_print, unused_field, unrelated_type_equality_checks, unnecessary_new, prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unnecessary_null_comparison, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:v2rp1/BE/controller.dart';
import 'package:v2rp1/BE/reqip.dart';
import 'package:v2rp1/BE/resD.dart';
import 'package:v2rp1/FE/StockTable/stocktable_scanner.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../main.dart';

class StockTable2 extends StatefulWidget {
  const StockTable2({Key? key}) : super(key: key);

  @override
  State<StockTable2> createState() => _StockTable2State();
}

class _StockTable2State extends State<StockTable2> {
  static var hasilSearch;
  static var conve = MsgHeader.conve;
  static var trxid = MsgHeader.trxid;
  static var datetime = MsgHeader.datetime;
  static TextControllers textControllers = Get.put(TextControllers());
  static var serverKeyValue;
  static TextField codebar = TextField();

  static late List dataaa = <ResultData>[];
  static late var result;

  static late var urlImages = [];

  static late int selectedIndex;
  late File uploadImage;

  @override
  void initState() {
    super.initState();
    if (textControllers.stocktableController.value.text != null) {
      getData();
    }
    // runBarcode();
    setState(() {
      dataaa.clear();
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

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
                middle: Text("Stock Table"),
                leading: GestureDetector(
                  child: Icon(CupertinoIcons.back),
                  onTap: () {
                    Get.to(Navbar());
                  },
                ),
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CupertinoSearchTextField(
                          controller:
                              textControllers.stocktableController.value,
                          itemSize: 30,
                          itemColor: HexColor('#F4A62A'),
                          prefixInsets: EdgeInsets.only(left: 8, right: 8),
                          suffixInsets: EdgeInsets.only(right: 8),
                          suffixMode: OverlayVisibilityMode.notEditing,
                          suffixIcon: Icon(CupertinoIcons.barcode_viewfinder),
                          onSuffixTap: () => Get.to(ScanSTable()),
                          onSubmitted: (value) {
                            searchProcess();
                            setState(() {
                              textControllers.stocktableController.value
                                  .clear();
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
                          // color: Colors.black,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListView.separated(
                            separatorBuilder: ((context, index) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              );
                            }),
                            itemCount: dataaa.length,
                            itemBuilder: (context, index) {
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 5,
                                // color: HexColor('#F4A62A'),
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onDoubleTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => GalleryWidget(
                                                urlImages: urlImages),
                                          ),
                                        );
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                        getImage();
                                        print(selectedIndex);
                                      },
                                      splashColor: Colors.blue,
                                      child: Ink.image(
                                        image: NetworkImage(
                                          'https://www.v2rp.net' +
                                              dataaa[index]['image'][0],
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            dataaa[index]['itemname'],
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            dataaa[index]['stockid'],
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 30,
                                              right: 15,
                                            ),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    selectedIndex = index;
                                                  });
                                                  dialogImage();
                                                },
                                                child: Text(
                                                  'Add Image',
                                                  style: TextStyle(
                                                    color: HexColor('#F4A62A'),
                                                  ),
                                                ),
                                              ),
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
                ],
              ),
            )
          //-----------------------------------ANDROID
          : Scaffold(
              appBar: AppBar(
                title: const Text("Stock Table"),
                centerTitle: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 1,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Navbar()),
                    );
                  },
                ),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Stock Table',
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
                        controller: textControllers.stocktableController.value,
                        onSubmitted: (value) {
                          searchProcess();
                          setState(() {
                            textControllers.stocktableController.value.clear();
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.assignment),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.qr_code_2),
                            color: HexColor('#F4A62A'),
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ScanSTable(),
                              ));
                            },
                            splashColor: HexColor('#F4A62A'),
                            tooltip: 'Scan',
                            hoverColor: HexColor('#F4A62A'),
                          ),
                          hintText: 'Stock Code / Item Name',
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
                          const SizedBox(height: 15.0),
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
                                              0.02,
                                    );
                                  },
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: dataaa.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 5,
                                      // color: HexColor('#F4A62A'),
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onDoubleTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => GalleryWidget(
                                                      urlImages: urlImages),
                                                ),
                                              );
                                              setState(() {
                                                selectedIndex = index;
                                              });
                                              getImage();
                                              print(selectedIndex);
                                            },
                                            splashColor: Colors.blue,
                                            child: Ink.image(
                                              image: NetworkImage(
                                                'https://www.v2rp.net' +
                                                    dataaa[index]['image'][0],
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.20,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  dataaa[index]['itemname'],
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  dataaa[index]['stockid'],
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 30,
                                                    right: 15,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          selectedIndex = index;
                                                        });
                                                        dialogImage();
                                                      },
                                                      child: Text(
                                                        'Add Image',
                                                        style: TextStyle(
                                                          color: HexColor(
                                                              '#F4A62A'),
                                                        ),
                                                      ),
                                                    ),
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
            middleText: "Please Click Button Below",
            backgroundColor: Colors.white,
            confirm: SizedBox(
              width: 125.0,
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
              width: 125.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor('#F4A62A'),
                ),
                onPressed: () {
                  takeImage();
                  Get.back();
                },
                child: Text(
                  'Take Picture',
                  style: TextStyle(fontSize: 12),
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
    var choosedimage =
        await ImagePicker().pickImage(source: ImageSource.camera);
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
    var tesA = dataaa[selectedIndex]['stockid'];
    try {
      List<int> imageBytes = uploadImage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var sendSearch = await http.post(
        Uri.https('www.v2rp.net', '/codebase/php/uploadfmmobile.php'),
        headers: {'x-v2rp-key': '$conve'},
        body: jsonEncode({
          "trxid": "$trxid",
          "datetime": "$datetime",
          "reqid": "0002",
          // "id": "$selectedIndex",
          "id": "$tesA",
          "image": baseimage,
        }),
      );
      var hasil = json.decode(sendSearch.body);
      print(hasil);
      print(tesA);
      var responseCode = hasil['responsecode'];
      print(responseCode);
      if (responseCode == '00') {
        Get.snackbar(
          "Success",
          "Successfull Uploading Image",
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 58, 245, 11),
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed Uploading Image!!",
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
        );
      }
    } catch (e) {
      // print("Failed Connect To Server");
    }
  }

  Future<void> searchProcess() async {
    var searchResult = textControllers.stocktableController.value.text;
    try {
      if (searchResult.length >= 3) {
        getData();
      } else {
        Get.snackbar(
          "Error",
          "Please Enter Valid Stock Code / Item Name",
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getData() async {
    HttpOverrides.global = MyHttpOverrides();
    String? searchValue = textControllers.stocktableController.value.text;
    var sendSearch = await http.post(Uri.https('www.v2rp.net', '/ptemp/'),
        headers: {'x-v2rp-key': '$conve'},
        body: jsonEncode({
          "trxid": "$trxid",
          "datetime": "$datetime",
          "reqid": "0002",
          "id": "$searchValue"
        }));
    print(searchValue);
    final resultData = json.decode(sendSearch.body);

    serverKeyValue = resultData['serverkey'];
    var responsecode = resultData['responsecode'];
    var responseMessage = resultData['message'];
    result = resultData['result'];

    //jadi

    print("AAAAAAAAAAAAAAAAA = " + result.toString());

    if (responsecode == '00') {
      setState(() {
        dataaa = resultData['result'];
        textControllers.stocktableController.value.clear();
      });
    } else if (responsecode == '30') {
      Get.snackbar(
        'Hint',
        '$responseMessage',
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
        dataaa.clear();
        textControllers.stocktableController.value.clear();
      });
    }
    print(sendSearch.body);
    // print(dataaa);
    print(searchValue);

    print(serverKeyValue);
    return "Successfull";
  }

  static Future<void> getImage() async {
    var gambarr = result[selectedIndex]['image'];
    print("bbbbbbbbbbb = " + gambarr.toString());

    urlImages = gambarr;
  }
}

class GalleryWidget extends StatefulWidget {
  final List<dynamic> urlImages;
  // final List<dynamic> gambar;
  const GalleryWidget({
    Key? key,
    required this.urlImages,
    // required this.gambar,
  }) : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Photo Gallery"),
              leading: GestureDetector(
                child: Icon(
                  CupertinoIcons.back,
                ),
                onTap: () => Get.to(StockTable2()),
              ),
            ),
            child: PhotoViewGallery.builder(
              itemCount: widget.urlImages.length,
              builder: (context, index) {
                final dataGambar = widget.urlImages;
                return PhotoViewGalleryPageOptions(
                  imageProvider:
                      NetworkImage("https://www.v2rp.net" + dataGambar[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4,
                );
              },
              backgroundDecoration: BoxDecoration(color: Colors.white),
            ),
          )
        : Scaffold(
            body: PhotoViewGallery.builder(
              itemCount: widget.urlImages.length,
              builder: (context, index) {
                final dataGambar = widget.urlImages;
                return PhotoViewGalleryPageOptions(
                  imageProvider:
                      NetworkImage("https://www.v2rp.net" + dataGambar[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4,
                );
              },
              backgroundDecoration: BoxDecoration(color: Colors.white),
            ),
          );
  }
}
