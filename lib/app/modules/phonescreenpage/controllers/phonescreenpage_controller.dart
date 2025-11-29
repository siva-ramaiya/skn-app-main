import 'package:foodapp/app/modules/optscreenpage/bindings/optscreenpage_binding.dart';
import 'package:foodapp/app/modules/optscreenpage/views/optscreenpage_view.dart';
import 'package:get/get.dart';


class PhonescreenpageController extends GetxController {
  var phoneNumber = ''.obs;
  var isValid = false.obs;

  void validatePhone(String number) {
    isValid.value = number.length >= 10; 
  }

  void onContinue() {
    Get.to(() =>OptscreenpageView(
          // phone: phoneNumber.value,
          // generatedOtp: '123456',
        ));
  }
}
