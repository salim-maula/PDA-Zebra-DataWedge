import 'package:datawedge_zebra/utils/helpers/data_wedge_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PageScan extends StatefulWidget {
  const PageScan({
    super.key,
  });

  @override
  State<PageScan> createState() => _PageScanState();
}

class _PageScanState extends State<PageScan> {
  final dataWedgeController = DataWedgeManager.instance;

  @override
  void initState() {
    super.initState();
    dataWedgeController.fdw.enableScanner(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataWedgeController.initScannerResult,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Scaffold(
          body: Obx(
             () {
              return ListView.builder(
                itemCount: dataWedgeController.log.length,
                itemBuilder: (context, index) =>
                    dataWedgeController.log.reversed.elementAt(index),
              );
            }
          ),
        );
      },
    );
  }
}
