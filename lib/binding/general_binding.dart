import 'package:datawedge_zebra/utils/helpers/data_wedge_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DataWedgeManager());
  }
}
