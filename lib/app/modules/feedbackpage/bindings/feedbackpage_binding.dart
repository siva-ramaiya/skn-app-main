import 'package:get/get.dart';

import '../controllers/feedbackpage_controller.dart';

class FeedbackpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackpageController>(
      () => FeedbackpageController(),
    );
  }
}
