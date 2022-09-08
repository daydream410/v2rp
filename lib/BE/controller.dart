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

  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> vendor1Controller = TextEditingController().obs;
  Rx<TextEditingController> stocktableController = TextEditingController().obs;
  Rx<TextEditingController> fixassetController = TextEditingController().obs;
  Rx<TextEditingController> remarksController = TextEditingController().obs;
  Rx<TextEditingController> materialusedController =
      TextEditingController().obs;
  Rx<TextEditingController> muWarehouseController = TextEditingController().obs;
  Rx<TextEditingController> muSppbjController = TextEditingController().obs;
  Rx<TextEditingController> grController = TextEditingController().obs;
  Rx<TextEditingController> grSupController = TextEditingController().obs;
  Rx<TextEditingController> grWhController = TextEditingController().obs;
  Rx<TextEditingController> grPoController = TextEditingController().obs;
}
