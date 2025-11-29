import 'package:get/get.dart';

import '../controllers/notificationspage_controller.dart';

class NotificationspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationspageController>(
      () => NotificationspageController(),
    );
  }
}
