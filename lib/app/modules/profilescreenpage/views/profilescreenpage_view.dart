import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/helpsupportpage/views/helpsupportpage_view.dart';
import 'package:foodapp/app/modules/notificationspage/views/notificationspage_view.dart';
import 'package:foodapp/app/modules/orderhistorypage/views/orderhistorypage_view.dart';
import 'package:foodapp/app/modules/profilescreenpage/controllers/profilescreenpage_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfilescreenpageView extends GetView<ProfilescreenpageController> {
  const ProfilescreenpageView({super.key});

  List get cartItems => [];

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final mq = MediaQuery.of(context).size;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: mq.height * 0.01),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: const Border(
              left: BorderSide(color: Colors.pink, width: 3),
              right: BorderSide(color: Colors.pink, width: 3),
            ),
          ),
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mq.width * 0.04,
                  vertical: mq.height * 0.01,
                ),
                child: Text(
                  'Select Profile Image',
                  style: GoogleFonts.lato(
                    fontSize: mq.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: mq.width * 0.05,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: mq.width * 0.05,
                  ),
                ),
                title: Text(
                  'Take a photo',
                  style: GoogleFonts.lato(
                    fontSize: mq.width * 0.038,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? pickedFile = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 70,
                  );
                  if (pickedFile != null) {
                    controller.profileImage.value = pickedFile.path;
                  }
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: mq.width * 0.05,
                  backgroundColor: Colors.green.shade100,
                  child: Icon(
                    Icons.photo_library,
                    color: Colors.green,
                    size: mq.width * 0.05,
                  ),
                ),
                title: Text(
                  'Choose from gallery',
                  style: GoogleFonts.lato(
                    fontSize: mq.width * 0.038,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 70,
                  );
                  if (pickedFile != null) {
                    controller.profileImage.value = pickedFile.path;
                  }
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: mq.width * 0.05,
                  backgroundColor: Colors.red.shade100,
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: mq.width * 0.05,
                  ),
                ),
                title: Text(
                  'Cancel',
                  style: GoogleFonts.lato(
                    fontSize: mq.width * 0.038,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mq = MediaQuery.of(context).size;

    final nameController = TextEditingController(
      text: controller.userName.value,
    );
    final emailController = TextEditingController(text: controller.email.value);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark
                ? const Color.fromARGB(255, 244, 193, 104)
                : Colors.pink,
            width: 1.5,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            fontSize: mq.width * 0.045,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: GoogleFonts.poppins(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: mq.width * 0.038,
              ),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: mq.width * 0.036,
                ),
                filled: true,
                fillColor: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.pink, width: 1.5),
                ),
              ),
            ),
            SizedBox(height: mq.height * 0.015),
            TextField(
              controller: emailController,
              style: GoogleFonts.poppins(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: mq.width * 0.038,
              ),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: mq.width * 0.036,
                ),
                filled: true,
                fillColor: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.pink, width: 1.5),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: mq.width * 0.035,
                color: isDark
                    ? const Color.fromARGB(255, 244, 193, 104)
                    : Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark
                  ? const Color.fromARGB(255, 244, 193, 104)
                  : Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              controller.userName.value = nameController.text;
              controller.email.value = emailController.text;
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: isDark ? Colors.black : Colors.white,
                fontSize: mq.width * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeLanguage(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mq = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isDark
                ? const Color.fromARGB(255, 236, 198, 86)
                : Colors.pink,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Select Language',
          style: GoogleFonts.poppins(
            fontSize: mq.width * 0.04,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'English',
                style: GoogleFonts.poppins(
                  fontSize: mq.width * 0.038,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.language),
              onTap: () {
                controller.selectedLanguage.value = 'English';
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'தமிழ்',
                style: GoogleFonts.poppins(
                  fontSize: mq.width * 0.038,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.language),
              onTap: () {
                controller.selectedLanguage.value = 'Tamil';
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mq = MediaQuery.of(context).size;
    final screenWidth = mq.width;
    final screenHeight = mq.height;

    final headerHeight = screenHeight * 0.15;
    final profileImageRadius = screenWidth * 0.13;
    final profileCardHorizontalMargin = screenWidth * 0.05;
    final profileCardVerticalPadding = screenHeight * 0.025;
    final cameraIconSize = screenWidth * 0.05;
    final cameraIconPadding = screenWidth * 0.015;
    final textSpacing = screenHeight * 0.015;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: headerHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color.fromARGB(255, 243, 200, 83)
                    : Colors.pink,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -headerHeight * 0.22),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: profileCardHorizontalMargin,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: profileCardVerticalPadding,
                  horizontal: profileCardHorizontalMargin * 0.5,
                ),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? const Color.fromARGB(255, 244, 193, 104)!
                        : Colors.grey[300]!,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Obx(() {
                      final imagePath = controller.profileImage.value;
                      final isNetworkImage = imagePath.startsWith('http');
                      final isFileImage = imagePath.startsWith('/');

                      return Stack(
                        children: [
                          CircleAvatar(
                            radius: profileImageRadius,
                            backgroundColor: isDark ? Colors.grey[800] : Colors
                                .grey[200],
                            backgroundImage: isNetworkImage
                                ? NetworkImage(imagePath)
                                : isFileImage
                                ? FileImage(File(imagePath)) as ImageProvider
                                : null,
                            child: isNetworkImage || isFileImage
                                ? null
                                : Icon(
                              Icons.person,
                              size: profileImageRadius,
                              color: isDark ? Colors.white70 : Colors.grey[600],
                            ),
                            onBackgroundImageError: (exception, stackTrace) {
                              print(
                                  '❌ Failed to load profile image: $exception');
                              // Fallback to default avatar if image fails to load
                              if (isNetworkImage) {
                                controller.profileImage.value =
                                'https://ui-avatars.com/api/?name=${Uri
                                    .encodeComponent(controller.userName
                                    .value)}&background=random&color=fff&size=200';
                              }
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => _pickImage(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color.fromARGB(255, 237, 199, 84)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(cameraIconPadding),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: cameraIconSize,
                                  color: isDark ? Colors.black : Colors.pink,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: textSpacing),
                    Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.userName.value,
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: screenWidth * 0.045,
                              color: isDark ? Colors.amber : Colors.pink,
                            ),
                            onPressed: () => _editProfile(context),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Obx(
                          () => Text(
                        controller.phone.value,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    Obx(
                          () => Text(
                        controller.email.value,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.012),
            // _buildMenuTile(
            //   icon: Icons.history,
            //   title: "Order History",
            //   onTap: () =>
            //       Get.to(() => OrderhistorypageView()),
            //   context: context,
            // ),
            _buildMenuTile(
              icon: Icons.language,
              title: "Language (${controller.selectedLanguage.value})",
              onTap: () => _changeLanguage(context),
              context: context,
            ),
            _buildMenuTile(
              icon: Icons.help_outline,
              title: "Help & Support",
              onTap: () => Get.to(HelpsupportpageView()),
              context: context,
            ),
            _buildMenuTile(
              icon: Icons.notifications,
              title: "Notifications",
              onTap: () => Get.to( NotificationspageView()),
              context: context,
            ),
            SizedBox(height: screenHeight * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;
    final mq = MediaQuery.of(context!).size;

    return ListTile(
      leading: Icon(
        icon,
        color: theme?.iconTheme.color ?? Colors.pink,
        size: mq.width * 0.055,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: mq.width * 0.038,
          fontWeight: FontWeight.bold,
          color: theme?.textTheme.bodyLarge?.color ?? Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: mq.width * 0.04,
        color:
            theme?.iconTheme.color ?? const Color.fromARGB(255, 241, 239, 239),
      ),
      onTap: onTap,
    );
  }
}
