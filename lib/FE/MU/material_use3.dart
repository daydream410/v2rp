// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:v2rp1/FE/MU/material_use2.dart';

import 'dialog_box.dart';

class MaterialUse3 extends StatelessWidget {
  const MaterialUse3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Transaction Detail"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const MaterialUse2()),
              // );
              Get.to(MaterialUse2());
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  image: AssetImage('images/vb_conf.jpg'),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Material Used No.'),
                                Text(
                                  'NEP/IJ2200003',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Warehouse'),
                                Text(
                                  'Varita',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Admin'),
                                Text(
                                  'Log & WH Staff PAP 1',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('SPPBJ No.'),
                                Text(
                                  'SPPBJ/2022/03-00001',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Requestor'),
                                Text(
                                  'BM Crewing 1',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Item List'),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Delete All',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Slidable(
                            key: const ValueKey(0),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(
                                onDismissed: () {},
                              ),
                              children: const [
                                SlidableAction(
                                  onPressed: null,
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              title: const Text('SEPATUSAFETY001'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Sepatu Safety Caterpillar High Ankle'),
                                  Text('Untuk kru kapal'),
                                ],
                              ),
                              trailing: Text(
                                '20x',
                                style: TextStyle(
                                  color: HexColor('#F4A62A'),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                          Slidable(
                            key: const ValueKey(1),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(
                                onDismissed: () {},
                              ),
                              children: const [
                                SlidableAction(
                                  onPressed: null,
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              title: const Text('BUKU001'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Buku Panduan K3'),
                                  Text('Untuk pelatihan kru baru'),
                                ],
                              ),
                              trailing: Text(
                                '10x',
                                style: TextStyle(
                                  color: HexColor('#F4A62A'),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('SUBMIT'),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogBox(
                      title: "SUCCESSFUL DATA SUBMIT",
                      descriptions: "Material Used  No.NEP/IJ2200003",
                      text: "Home",
                      home: "OK",
                      img: Image.asset("images/success.gif"),
                    );
                  });
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: HexColor('#F4A62A'),
            ),
          ),
        ),
      ),
    );
  }
}

// class _MaterialUse3State extends State<MaterialUse3> {
//   @override
//   Widget buisld(BuildContext context) {
//     return Scaffold(
      
//     );
//   }
// }
