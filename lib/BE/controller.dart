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
  Rx<TextEditingController> caConfirmControllerReason =
      TextEditingController().obs;

  //cash approval confirmation
  Rx<TextEditingController> caApprovalController = TextEditingController().obs;
  Rx<TextEditingController> caApprovalControllerReason =
      TextEditingController().obs;

  //ca set confirm
  Rx<TextEditingController> caSetConfController = TextEditingController().obs;
  Rx<TextEditingController> caSetConfControllerReason =
      TextEditingController().obs;

  //ca set app
  Rx<TextEditingController> caSetAppController = TextEditingController().obs;
  Rx<TextEditingController> caSetAppControllerReason =
      TextEditingController().obs;

  //ar app
  Rx<TextEditingController> arAppController = TextEditingController().obs;
  Rx<TextEditingController> arAppControllerReason = TextEditingController().obs;

  //sales order app
  Rx<TextEditingController> salesAppController = TextEditingController().obs;
  Rx<TextEditingController> salesAppControllerReason =
      TextEditingController().obs;

  //sppbj confirm
  Rx<TextEditingController> sppbjConfirmController =
      TextEditingController().obs;
  Rx<TextEditingController> sppbjConfirmControllerReason =
      TextEditingController().obs;

  //sppbj app
  Rx<TextEditingController> sppbjAppController = TextEditingController().obs;
  Rx<TextEditingController> sppbjAppControllerReason =
      TextEditingController().obs;

  //po SCM APP
  Rx<TextEditingController> poScmAppController = TextEditingController().obs;
  Rx<TextEditingController> poScmAppControllerReason =
      TextEditingController().obs;

  //new ap app
  Rx<TextEditingController> newapAppController = TextEditingController().obs;
  Rx<TextEditingController> newapAppControllerReason =
      TextEditingController().obs;

  //dpreq app
  Rx<TextEditingController> dpreqAppController = TextEditingController().obs;
  Rx<TextEditingController> dpreqAppControllerReason =
      TextEditingController().obs;

  //ap refund
  Rx<TextEditingController> aprefundAppController = TextEditingController().obs;
  Rx<TextEditingController> aprefundAppControllerReason =
      TextEditingController().obs;

  //apadjustment app
  Rx<TextEditingController> apadjAppController = TextEditingController().obs;
  Rx<TextEditingController> apadjAppControllerReason =
      TextEditingController().obs;

  //debit notes
  Rx<TextEditingController> debitnotesAppController =
      TextEditingController().obs;
  Rx<TextEditingController> debitnotesAppControllerReason =
      TextEditingController().obs;

  //po exception
  Rx<TextEditingController> poexAppController = TextEditingController().obs;
  Rx<TextEditingController> poexAppControllerReason =
      TextEditingController().obs;

  //mu approval
  Rx<TextEditingController> muAppController = TextEditingController().obs;
  Rx<TextEditingController> muAppControllerReason = TextEditingController().obs;

  //gr app
  Rx<TextEditingController> grAppController = TextEditingController().obs;
  Rx<TextEditingController> grAppControllerReason = TextEditingController().obs;

  //it app
  Rx<TextEditingController> itAppController = TextEditingController().obs;
  Rx<TextEditingController> itAppControllerReason = TextEditingController().obs;

  //sm app
  Rx<TextEditingController> smAppController = TextEditingController().obs;
  Rx<TextEditingController> smAppControllerReason = TextEditingController().obs;

  //stockadjApp
  Rx<TextEditingController> stockadjAppController = TextEditingController().obs;
  Rx<TextEditingController> stockadjAppControllerReason =
      TextEditingController().obs;

  //stock topup
  Rx<TextEditingController> stocktopupAppController =
      TextEditingController().obs;
  Rx<TextEditingController> stocktopupAppControllerReason =
      TextEditingController().obs;

  //Assembling app
  Rx<TextEditingController> assemblingAppController =
      TextEditingController().obs;
  Rx<TextEditingController> assemblingAppControllerReason =
      TextEditingController().obs;

  //mr app
  Rx<TextEditingController> mrAppController = TextEditingController().obs;
  Rx<TextEditingController> mrAppControllerReason = TextEditingController().obs;

  //stocktransfer app
  Rx<TextEditingController> stocktransferAppController =
      TextEditingController().obs;
  Rx<TextEditingController> stocktransferAppControllerReason =
      TextEditingController().obs;

  //it stock adj
  Rx<TextEditingController> itstockadjAppController =
      TextEditingController().obs;
  Rx<TextEditingController> itstockadjAppControllerReason =
      TextEditingController().obs;

  //stock price
  Rx<TextEditingController> stockpriceAppController =
      TextEditingController().obs;
  Rx<TextEditingController> stockpriceAppControllerReason =
      TextEditingController().obs;

  //minmax app
  Rx<TextEditingController> minmaxAppController = TextEditingController().obs;
  Rx<TextEditingController> minmaxAppControllerReason =
      TextEditingController().obs;

  //stock merger app
  Rx<TextEditingController> stockmergerAppController =
      TextEditingController().obs;
  Rx<TextEditingController> stockmergerAppControllerReason =
      TextEditingController().obs;

  //po supplier unapproved app
  Rx<TextEditingController> PoUnapprovedController =
      TextEditingController().obs;
  Rx<TextEditingController> PoUnapprovedControllerReason =
      TextEditingController().obs;

  // wo approval
  Rx<TextEditingController> woAppController = TextEditingController().obs;
  Rx<TextEditingController> WoCompletedController = TextEditingController().obs;
  // Rx<TextEditingController> PoUnapprovedControllerReason =
  //     TextEditingController().obs;
}
