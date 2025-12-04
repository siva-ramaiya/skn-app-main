import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodapp/app/data/services/api_profile.dart';

class ProfilescreenpageController extends GetxController {
  // Observable variables
  var profileImage =
      'https://ui-avatars.com/api/?name=User&background=random&color=fff&size=200'
          .obs;
  var selectedLanguage = 'English'.obs;
  var userName = 'John Doe'.obs;
  var email = 'john.doe@example.com'.obs;
  var favoriteCuisine = 'Italian'.obs;
  var phone = '123-456-7890'.obs;

  final ImagePicker _picker = ImagePicker();
  final ApiProfile apiProfile = ApiProfile();

  @override
  void onInit() {
    super.onInit();
    fetchAndSetUserDetails();

    // Set up error handling for profile image loading
    ever(profileImage, (String imagePath) {
      // This will be triggered whenever profileImage changes
      // We can add additional logging or error handling here if needed
      print('🖼️ Profile image updated: $imagePath');
    });
  }

  // Fetch user details from API
  Future<void> fetchAndSetUserDetails() async {
    try {
      print('🔍 Fetching user details...');
      final response = await apiProfile.fetchUserDetails();

      if (response != null && response.isNotEmpty) {
        print('📦 Received user data: $response');

        // Update user details from the response
        if (response['data'] != null) {
          final userData = response['data'];
          userName.value = userData['name']?.toString() ?? userName.value;
          email.value = userData['email']?.toString() ?? email.value;
          phone.value = userData['phone_number']?.toString() ?? phone.value;

          print('✅ User details updated successfully');
          print('   Name: ${userName.value}');
          print('   Email: ${email.value}');
          print('   Phone: ${phone.value}');
        } else {
          print('⚠️ No user data found in response');
        }
      } else {
        print('⚠️ Empty or invalid response from server');
      }
    } catch (e) {
      print('❌ Error fetching user details: $e');
      // You might want to show an error message to the user here
      Get.snackbar(
        'Error',
        'Failed to load profile data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Pick profile image from gallery
  Future<void> pickImageFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage.value = picked.path;
    }
  }

  // Logout user
  void logout() {
    Get.offAllNamed('/login');
  }
}
