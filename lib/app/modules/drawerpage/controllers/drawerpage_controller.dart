import 'dart:io';

import 'package:foodapp/app/utils/storage_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DrawerpageController extends GetxController {
   final Rx<File?> profileImage = Rx<File?>(null);
   final userData = <String, dynamic>{}.obs;

  get cartItems => null;

    @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    userData.value = StorageHelper.getUserData() ?? {};
    print('User Data: $userData');
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage.value = File(picked.path);
    }
  }
}
