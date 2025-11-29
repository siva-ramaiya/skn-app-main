import 'package:get/get.dart';

import '../controllers/calendereventpage_controller.dart';

class CalendereventpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendereventpageController>(
      () => CalendereventpageController(),
    );
  }
}
