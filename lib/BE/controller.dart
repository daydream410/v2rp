import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TextControllers extends GetxController {
  @override
  void onInit() {
    super.onInit();
    usernameController.value.clear();
    passwordController.value.clear();
    vendor1Controller.value.clear();
    stocktableController.value.clear();
    fixassetController.value.clear();
    remarksController.value.clear();
    materialusedController.value.clear();
  }

//login
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  //barcode regist
  Rx<TextEditingController> vendor1Controller = TextEditingController().obs;
  Rx<TextEditingController> remarksController = TextEditingController().obs;

  //stock table
  Rx<TextEditingController> stocktableController = TextEditingController().obs;

  //fix assets
  Rx<TextEditingController> fixassetController = TextEditingController().obs;

  //material used
  Rx<TextEditingController> materialusedController =
      TextEditingController().obs;
  Rx<TextEditingController> muWarehouseController = TextEditingController().obs;
  Rx<TextEditingController> muSppbjController = TextEditingController().obs;

  //goods reveiced
  Rx<TextEditingController> grController = TextEditingController().obs;
  Rx<TextEditingController> grSupController = TextEditingController().obs;
  Rx<TextEditingController> grWhController = TextEditingController().obs;
  Rx<TextEditingController> grPoController = TextEditingController().obs;

  //it
  Rx<TextEditingController> itReffController = TextEditingController().obs;
  Rx<TextEditingController> itWhController = TextEditingController().obs;
  Rx<TextEditingController> itSppbjController = TextEditingController().obs;

  //sm
  Rx<TextEditingController> smReffController = TextEditingController().obs;
  Rx<TextEditingController> smWhController = TextEditingController().obs;

  //st
  Rx<TextEditingController> stReffController = TextEditingController().obs;
  Rx<TextEditingController> stWhController = TextEditingController().obs;

  //so
  Rx<TextEditingController> soReffController = TextEditingController().obs;
  Rx<TextEditingController> soWhController = TextEditingController().obs;
}
