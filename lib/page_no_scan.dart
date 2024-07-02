import 'package:datawedge_zebra/utils/helpers/data_wedge_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';

class PageNoScan extends StatefulWidget {
  const PageNoScan({super.key});

  @override
  State<PageNoScan> createState() => _PageNoScanState();
}

class _PageNoScanState extends State<PageNoScan> {
  final dataWedgeController = DataWedgeManager.instance;
  @override
  void initState() {
    super.initState();
    dataWedgeController.fdw.enableScanner(false);
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
          body: Center(
            child: Row(
              children: [
              ],
            ),
          ),
        );
      },
    );
  }
}
