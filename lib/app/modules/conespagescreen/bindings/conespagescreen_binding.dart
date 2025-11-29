import 'package:get/get.dart';

import '../controllers/conespagescreen_controller.dart';

class ConespagescreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConespagescreenController>(
      () => ConespagescreenController(),
    );
  }
}
