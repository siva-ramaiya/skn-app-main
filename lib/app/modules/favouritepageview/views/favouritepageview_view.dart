import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/favouritepageview/views/favourite_card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
 import '../controllers/favouritepageview_controller.dart';

class FavouritepageviewView extends StatefulWidget {
    FavouritepageviewView({super.key});

  @override
  State<FavouritepageviewView> createState() => _FavouritepageviewViewState();
}

class _FavouritepageviewViewState extends State<FavouritepageviewView> {
  final controller = Get.put(FavouritepageviewController());

  final isDark = Get.isDarkMode.obs;
  @override
  void initState() {
    super.initState();
    print('refresh-------');
    // Load favorites when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark.value ? Colors.black : Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(
            backgroundColor: Colors.pink,
            color: Colors.white,
          ));
        }

        if (controller.favouriteItems.isEmpty) {
          return _emptyState(context, isDark.value);
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshFavorites(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.favouriteItems.length,
            itemBuilder: (context, index) {
              final item = controller.favouriteItems[index];
              return FavoriteCard(
                item: item,
                controller: controller,
                isDark: isDark.value,
              );
            },
          ),
        );
      }),
    );
  }

  // ------------------------------------------------------------------
  Widget _emptyState(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              "assets/images/favtouriteesese.png",
              height: 180,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'No favorites yet!',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Start exploring and save what you love!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
