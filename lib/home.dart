import 'dart:io';

import 'package:datawedge_zebra/page_no_scan.dart';
import 'package:datawedge_zebra/page_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterDataWedge fdw;
  Future<void>? initScannerResult;

  @override
  void initState() {
    super.initState();
    initScannerResult = initScanner();
  }

  Future<void> initScanner() async {
    if (Platform.isAndroid) {
      fdw = FlutterDataWedge();
      await fdw.initialize();
      await fdw.createDefaultProfile(
          profileName: "com.example.datawedge_zebra");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initScannerResult,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Scaffold(
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.to(() => PageScan());
                    },
                    child: const Text("Page Scan")),
                ElevatedButton(
                    onPressed: () {
                      Get.to(() => PageNoScan());
                    },
                    child: const Text("Page Canot Scan")),
              ],
            ),
          ),
        );
      },
    );
  }
}
