import 'package:get/get.dart';

import '../controllers/chatbotpage_controller.dart';

class ChatbotpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatbotpageController>(
      () => ChatbotpageController(),
    );
  }
}
