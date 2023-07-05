// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class UploadImageDemo extends StatefulWidget {
//   UploadImageDemo() : super();

//   final String title = "Upload Image Demo";

//   @override
//   UploadImageDemoState createState() => UploadImageDemoState();
// }

// class UploadImageDemoState extends State<UploadImageDemo> {
//   //
//   static const String uploadEndPoint =
//       'www.v2rp.net/codebase/php/uploadfmmobile.php';
//   late Future<File> file;
//   String status = '';
//   late String base64Image;
//   late File tmpFile;
//   String errMessage = 'Error Uploading Image';

//   chooseImage() {
//     setState(() {
//       file =
//           ImagePicker().pickImage(source: ImageSource.gallery) as Future<File>;
//     });
//     setStatus('');
//   }

//   setStatus(String message) {
//     setState(() {
//       status = message;
//     });
//   }

//   startUpload() {
//     setStatus('Uploading Image...');
//     if (null == tmpFile) {
//       setStatus(errMessage);
//       return;
//     }
//     String fileName = tmpFile.path.split('/').last;
//     upload(fileName);
//   }

//   upload(String fileName) {
//     http.post(Uri.parse(uploadEndPoint), body: {
//       "image": base64Image,
//       "name": fileName,
//     }).then((result) {
//       setStatus(result.statusCode == 200 ? result.body : errMessage);
//     }).catchError((error) {
//       setStatus(error);
//     });
//   }

//   Widget showImage() {
//     return FutureBuilder<File>(
//       future: file,
//       builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done &&
//             null != snapshot.data) {
//           tmpFile = snapshot.data!;
//           base64Image = base64Encode(snapshot.data!.readAsBytesSync());
//           return Flexible(
//             child: Image.file(
//               snapshot.data!,
//               fit: BoxFit.fill,
//             ),
//           );
//         } else if (null != snapshot.error) {
//           return const Text(
//             'Error Picking Image',
//             textAlign: TextAlign.center,
//           );
//         } else {
//           return const Text(
//             'No Image Selected',
//             textAlign: TextAlign.center,
//           );
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Upload Image Demo"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: chooseImage,
//               child: const Text('Choose Image'),
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//             showImage(),
//             const SizedBox(
//               height: 20.0,
//             ),
//             ElevatedButton(
//               onPressed: startUpload,
//               child: const Text('Upload Image'),
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//             Text(
//               status,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.green,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20.0,
//               ),
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
