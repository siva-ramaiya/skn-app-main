import 'package:get/get.dart';

import '../controllers/familypackspage_controller.dart';

class FamilypackspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FamilypackspageController>(
      () => FamilypackspageController(),
    );
  }
}
