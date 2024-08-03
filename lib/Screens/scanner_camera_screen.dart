import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../Models/qr_overlay.dart';


class ScannerCameraScreen extends StatefulWidget {
  static const routeName = "SCANNER_CAMERA_SCREEN";
  const ScannerCameraScreen({Key? key}) : super(key: key);

  @override
  State<ScannerCameraScreen> createState() => _ScannerCameraScreenState();
}
class _ScannerCameraScreenState extends State<ScannerCameraScreen> {
  MobileScannerController cameraController = MobileScannerController();
  int counter = 0;
  @override

  void dispose(){
    super.dispose();
    cameraController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan code",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: (){
                cameraController.switchCamera();
              },
              icon: const Icon(Icons.camera_rear_outlined)
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) async {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              counter++;
              for (final barcode in barcodes) {
                try {
                  if (counter == 1) {
                    cameraController.dispose();
                    Navigator.of(context).pop(barcode.rawValue);
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: "scan again");
                }
              }
            },

          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }
}