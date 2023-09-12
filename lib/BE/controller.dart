import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TextControllers extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // passwordController.value.clear();
    vendor1Controller.value.clear();
    stocktableController.value.clear();
    fixassetController.value.clear();
    remarksController.value.clear();
    materialusedController.value.clear();
  }

//login
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  //barcode regist
  Rx<TextEditingController> vendor1Controller = TextEditingController().obs;
  Rx<TextEditingController> remarksController = TextEditingController().obs;

  //stock table
  Rx<TextEditingController> stocktableController = TextEditingController().obs;
  Rx<TextEditingController> warehouseStController = TextEditingController().obs;
  Rx<TextEditingController> barcodeStController = TextEditingController().obs;

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

  //approval menu

  //cash advance confirmation
  Rx<TextEditingController> caConfirmController = TextEditingController().obs;

  //cash approval confirmation
  Rx<TextEditingController> caApprovalController = TextEditingController().obs;

  //ca set confirm
  Rx<TextEditingController> caSetConfController = TextEditingController().obs;

  //ca set app
  Rx<TextEditingController> caSetAppController = TextEditingController().obs;

  //ar app
  Rx<TextEditingController> arAppController = TextEditingController().obs;

  //sales order app
  Rx<TextEditingController> salesAppController = TextEditingController().obs;

  //sppbj confirm
  Rx<TextEditingController> sppbjConfirmController =
      TextEditingController().obs;

  //sppbj app
  Rx<TextEditingController> sppbjAppController = TextEditingController().obs;

  //po SCM APP
  Rx<TextEditingController> poScmAppController = TextEditingController().obs;

  //new ap app
  Rx<TextEditingController> newapAppController = TextEditingController().obs;

  //dpreq app
  Rx<TextEditingController> dpreqAppController = TextEditingController().obs;

  //ap refund
  Rx<TextEditingController> aprefundAppController = TextEditingController().obs;

  //apadjustment app
  Rx<TextEditingController> apadjAppController = TextEditingController().obs;

  //debit notes
  Rx<TextEditingController> debitnotesAppController =
      TextEditingController().obs;

  //po exception
  Rx<TextEditingController> poexAppController = TextEditingController().obs;

  //mu approval
  Rx<TextEditingController> muAppController = TextEditingController().obs;

  //gr app
  Rx<TextEditingController> grAppController = TextEditingController().obs;

  //it app
  Rx<TextEditingController> itAppController = TextEditingController().obs;

  //sm app
  Rx<TextEditingController> smAppController = TextEditingController().obs;

  //stockadjApp
  Rx<TextEditingController> stockadjAppController = TextEditingController().obs;

  //stock topup
  Rx<TextEditingController> stocktopupAppController =
      TextEditingController().obs;

  //Assembling app
  Rx<TextEditingController> assemblingAppController =
      TextEditingController().obs;

  //mr app
  Rx<TextEditingController> mrAppController = TextEditingController().obs;

  //stocktransfer app
  Rx<TextEditingController> stocktransferAppController =
      TextEditingController().obs;

  //it stock adj
  Rx<TextEditingController> itstockadjAppController =
      TextEditingController().obs;

  //stock price
  Rx<TextEditingController> stockpriceAppController =
      TextEditingController().obs;

  //minmax app
  Rx<TextEditingController> minmaxAppController = TextEditingController().obs;

  //stock merger app
  Rx<TextEditingController> stockmergerAppController =
      TextEditingController().obs;
}
