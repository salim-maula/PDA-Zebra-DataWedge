import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'package:get/get.dart';

class DataWedgeManager extends GetxController {
  static DataWedgeManager get instance => Get.find();

  late FlutterDataWedge fdw;
  Future<void>? initScannerResult;

  late final StreamSubscription<ActionResult> scannerEventSubscription;
  late final StreamSubscription<ScanResult> scanResultSubscription;
  late final StreamSubscription<ScannerStatus> scannerStatusSubscription;

  RxList<dynamic> log = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initScannerResult = initScanner();

    scanResultSubscription = fdw.onScanResult.listen(onScanResult);
  }

  Future<void> initScanner() async {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge();
      await fdw.initialize();
      await fdw.createDefaultProfile(
          profileName: "com.example.datawedge_zebra");
    }
  }

  void onScanResult(ScanResult event) {
    print(event.data);
    log.add(_ScanResultLogTile(event));
  }
}

class _ScanResultLogTile extends StatelessWidget {
  const _ScanResultLogTile(this.scanResult);

  final ScanResult scanResult;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(scanResult.labelType),
      subtitle: Text(scanResult.data),
    );
  }
}
