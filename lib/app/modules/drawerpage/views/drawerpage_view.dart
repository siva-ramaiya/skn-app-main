import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/Calendereventpage/views/calendereventpage_view.dart';
import 'package:foodapp/app/modules/aboutscreenpage/views/aboutscreenpage_view.dart';
import 'package:foodapp/app/modules/feedbackpage/views/feedbackpage_view.dart';
import 'package:foodapp/app/modules/myorderpage/views/myorderpage_view.dart';
import 'package:foodapp/app/modules/orderconfrompageview/views/orderconfrompageview_view.dart';
import 'package:foodapp/app/modules/orderhistorypage/views/orderhistorypage_view.dart';
import 'package:foodapp/app/modules/profilescreenpage/views/profilescreenpage_view.dart';
import 'package:foodapp/app/modules/trackingpage/views/trackingpage_view.dart';
import 'package:foodapp/themes/ThemeController%20.dart';
import 'package:foodapp/widgets/showLogoutPopup.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/storage_helper.dart';
import '../../bottomnavgationbar/views/bottomnavgationbar_view.dart';
import '../controllers/drawerpage_controller.dart';

class DrawerView extends GetView<DrawerpageController> {
  final themeController = Get.find<ThemeController>();
  final List<dynamic> cartItems = [];
  DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // ✅ Scale values based on screen width
    final bool isWeb = screenWidth > 600;
    final double textScale = isWeb ? 1.3 : 1.0;
    final double iconSize = isWeb ? 26 : 20;
    final double avatarRadius = isWeb ? screenWidth * 0.05 : screenWidth * 0.09;

    return Drawer(
      width: isWeb ? screenWidth * 0.28 : null, // ✅ Wider drawer for web
      backgroundColor: isDark ? Colors.black : Colors.white,
      elevation: 1,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(() {
              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color.fromARGB(255, 245, 202, 75)
                      : Colors.pink,
                ),
                accountName: Text(
                  controller.userData['name'] ?? "Guest User",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: isWeb ? 16 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  controller.userData['email'] ?? "Guest User",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: isWeb ? 14 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      radius: avatarRadius,
                      backgroundImage: controller.profileImage.value != null
                          ? FileImage(controller.profileImage.value!)
                          : const AssetImage('assets/images/profile1.jpg')
                                as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: controller.pickImage,
                        child: Container(
                          height: isWeb ? 40 : 31 * textScale,
                          width: isWeb ? 40 : 30 * textScale,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            CupertinoIcons.camera_fill,
                            color: Colors.white,
                            size: isWeb ? 20 : 18 * textScale,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // ✅ Drawer Items
            buildDrawerTile(
              CupertinoIcons.home,
              'HOME',
              () {
                Get.offAll(() => BottomnavigationbarView());
              },
              textScale,
              isDark,
              iconSize,
            ),
            buildDrawerTile(
              Icons.info_outline,
              'About',
              () {
                Get.offAll(() => AboutpageView());
              },
              textScale,
              isDark,
              iconSize,
            ),
            buildDrawerTile(
              Icons.receipt_long,
              'My Orders',
              () {
                Get.to(MyorderpageView());
              },
              textScale,
              isDark,
              iconSize,
            ),
            // buildDrawerTile(
            //   Icons.track_changes,
            //   'Live Tracking',
            //   () {
            //     Get.to(
            //       () => TrackingpageView(),
            //       arguments: {'cartItems': cartItems},
            //     );
            //   },
            //   textScale,
            //   isDark,
            //   iconSize,
            // ),
            buildDrawerTile(
              Icons.feedback,
              'Feedback',
              () {
                Get.to(FeedbackpageView());
              },
              textScale,
              isDark,
              iconSize,
            ),

            buildDrawerTile(
              Icons.history,
              'Order History',
              () {
                Get.to(() => OrderhistorypageView());
              },
              textScale,
              isDark,
              iconSize,
            ),
            // buildDrawerTile(
            //   Icons.event_available,
            //   'event booking',
            //   () {
            //     Get.to(CalendereventpageView());
            //   },
            //   textScale,
            //   isDark,
            //   iconSize,
            // ),
            buildDrawerTile(
              Icons.logout,
              'Logout',
              () {

                showLogoutPopup(
                  isDark: isDark,

                );
              },
              textScale,
              isDark,
              iconSize,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerTile(
    IconData icon,
    String label,
    VoidCallback onTap,
    double textScale,
    bool isDark,
    double iconSize,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDark ? Colors.white : Colors.black,
        size: iconSize,
      ),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 13 * textScale,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}
