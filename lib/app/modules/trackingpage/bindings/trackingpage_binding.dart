import 'package:get/get.dart';

import '../controllers/trackingpage_controller.dart';

class TrackingpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackingpageController>(
      () => TrackingpageController(),
    );
  }
}
