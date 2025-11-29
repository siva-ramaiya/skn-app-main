import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controllers/favouritepageview_controller.dart';
import 'package:foodapp/app/modules/productdetailspage/views/productdetailspage_view.dart';

class FavouritepageviewView extends StatelessWidget {
  const FavouritepageviewView({super.key});

  @override
  Widget build(BuildContext context) {
    // Safe controller initialization inside build()
    final controller = Get.put(FavouritepageviewController());
    // final controller = Get.isRegistered<FavouritepageviewController>()
    //     ? Get.find<FavouritepageviewController>()
    //     : Get.put(FavouritepageviewController());

    final isDark = Get.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Obx(() {
        if (controller.favouriteItems.isEmpty) {
          return _emptyState(context, isDark);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.favouriteItems.length,
          itemBuilder: (context, index) {
            final item = controller.favouriteItems[index];
            print("⭐ Rendering favorite item: $item");
            return _favoriteCard(context, item, controller, isDark);
          },
        );
      }),
    );
  }

  // ------------------------------------------------------------------
  // Empty State Widget
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

  // ------------------------------------------------------------------
  // Favorite Card
  // ------------------------------------------------------------------
  Widget _favoriteCard(
    BuildContext context,
    Map<String, dynamic> item,
    FavouritepageviewController controller,
    bool isDark,
  ) {
    // Safe read from API
    final String name = item['name']?.toString() ?? "No Title";
    // SAFE IMAGE URL FIX
    final String rawImage = item['image_url']?.toString() ?? "";
    final String imageUrl = rawImage.startsWith("http")
        ? rawImage
        : "https://api.skandaswamyandsons.com$rawImage";

    // final String imageUrl = item['image_url']?.toString() ?? "";
    final double price =
        double.tryParse(item['price']?.toString() ?? "") ?? 0.0;

    final double rating =
        double.tryParse(item['rating']?.toString() ?? "") ?? 4.0;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (_) => controller.toggleFavourite(item),

      // ---------------- CARD UI (unchanged) ----------------
      child: Card(
        elevation: 4,
        color: isDark ? Colors.grey.shade900 : Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 110,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  "assets/images/placeholder.png",
                  width: 110,
                  height: 100,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white70 : Colors.grey.shade800,
                    ),
                  ),

                  const SizedBox(height: 4),

                  RatingBarIndicator(
                    rating: rating,
                    itemCount: 5,
                    itemSize: 18,
                    itemBuilder: (_, __) =>
                        const Icon(Icons.star, color: Colors.amber),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "₹ $price",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow button
            GestureDetector(
              onTap: () {
                Get.to(
                  () => ProductDetailsViewpageView(),
                  arguments: {
                    "id": item['id'],
                    "title": name,
                    "image": imageUrl,
                    "price": price,
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
