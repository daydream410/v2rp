// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:v2rp1/BE/controller.dart';

import 'package:v2rp1/FE/home_screen/StockTable/stocktable2.dart';

import '../../../additional/qr_overlay.dart';

class ScanSTable extends StatefulWidget {
  const ScanSTable({Key? key}) : super(key: key);

  @override
  State<ScanSTable> createState() => _ScanSTableState();
}

class _ScanSTableState extends State<ScanSTable> {
  MobileScannerController cameraController = MobileScannerController();

  static var codeBarcode;
  static var codeBarcode2;
  static TextControllers textControllers = Get.put(TextControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanner"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            color: const Color.fromARGB(255, 139, 0, 0),
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: const Color.fromARGB(255, 106, 0, 0),
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            // allowDuplicates: false,
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                codeBarcode = barcode.rawValue;
                codeBarcode2 = codeBarcode.split('|').last;
                debugPrint(
                    'Barcode found! raw valuee ====== ${barcode.rawValue}');
              }
              // codeBarcode = bar.rawValue;
              debugPrint('Barcode found! $codeBarcode2');
              Get.snackbar(
                "Barcode Found!",
                "$codeBarcode",
                icon: const Icon(Icons.qr_code),
                backgroundColor: Colors.green,
                isDismissible: true,
                dismissDirection: DismissDirection.vertical,
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.to(() => const StockTable2());
              setState(() {
                cameraController.stop();
                textControllers.stocktableController.value.text = codeBarcode2;
              });
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.65)),
        ],
      ),
    );
  }
}
