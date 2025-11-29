import 'package:get/get.dart';

import '../controllers/profilescreenpage_controller.dart';

class ProfilescreenpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilescreenpageController>(
      () => ProfilescreenpageController(),
    );
  }
}
