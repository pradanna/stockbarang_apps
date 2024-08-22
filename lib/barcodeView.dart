import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class BarcodeScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Barcode'),
      ),
      body: Center(
        child: ScanButton(),
      ),
    );
  }
}

class ScanButton extends StatelessWidget {
  Future<void> _scanBarcode(BuildContext context) async {
    try {
      final String result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Color for the scan line
        'Cancel', // Button text for cancel
        true, // Whether to show the flash icon
        ScanMode.BARCODE, // Scan mode (could also be QR code)
      );

      if (result != '-1') {
        // Handle the scanned result
        String modifiedString = result.substring(1, result.length - 1);
        Get.toNamed("/barangCode", arguments: {
          'barcode' : modifiedString
        });

      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to scan barcode: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _scanBarcode(context),
      child: Text('Start Scanning'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
