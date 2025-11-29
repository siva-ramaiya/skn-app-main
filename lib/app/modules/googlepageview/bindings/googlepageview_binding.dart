import 'package:get/get.dart';

import '../controllers/googlepageview_controller.dart';

class GooglepageviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GooglepageviewController>(
      () => GooglepageviewController(),
    );
  }
}
