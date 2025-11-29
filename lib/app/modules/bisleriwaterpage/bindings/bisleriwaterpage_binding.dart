import 'package:get/get.dart';

import '../controllers/bisleriwaterpage_controller.dart';

class BisleriwaterpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BisleriwaterpageController>(
      () => BisleriwaterpageController(),
    );
  }
}
