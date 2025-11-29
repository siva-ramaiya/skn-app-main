import 'package:get/get.dart';

import '../controllers/barsstickspage_controller.dart';

class BarsstickspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarsstickspageController>(
      () => BarsstickspageController(),
    );
  }
}
