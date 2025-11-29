import 'package:get/get.dart';

import '../controllers/favouritepageview_controller.dart';

class FavouritepageviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouritepageviewController>(
      () => FavouritepageviewController(),
    );
  }
}
