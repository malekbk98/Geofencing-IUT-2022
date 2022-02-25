import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geofencing/screens/spot_page.dart';
import 'package:geofencing/theme/app_theme.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrService extends StatefulWidget {
  const QrService({Key? key}) : super(key: key);

  @override
  _QrServiceState createState() => _QrServiceState();
}

class _QrServiceState extends State<QrService> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
          ],
        ),
      ),
    );
  }

  buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQrViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: AppTheme.mainColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQrViewCreated(QRViewController controller) {
    this.controller = controller;
    bool scanned = false;
    controller.scannedDataStream.listen((scanData) {
      if (!scanned) {
        scanned = true;
        checkScanResult(scanData.code!);
      }
    });
  }

  // get permission
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void checkScanResult(String code) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SpotPage(code)),
    );
  }
}
