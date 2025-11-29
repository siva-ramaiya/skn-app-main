import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodapp/app/data/services/api_profile.dart';

class ProfilescreenpageController extends GetxController {
  // Observable variables
  var profileImage = 'assets/images/user_avatar.png'.obs;
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
  }

  // Fetch user details using hardcoded token
  Future<void> fetchAndSetUserDetails() async {
    try {
      final userDetails = await apiProfile.fetchUserDetails();
      userName.value = userDetails['name'] ?? userName.value;
      email.value = userDetails['email'] ?? email.value;
      phone.value = userDetails['phone_number'] ?? phone.value;
      favoriteCuisine.value =
          userDetails['favorite_cuisine'] ?? favoriteCuisine.value;

      print('✅ User details loaded successfully');
    } catch (e) {
      print('❌ Error fetching user details: $e');
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
