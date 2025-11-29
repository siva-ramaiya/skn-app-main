import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodapp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../addcartpageviews/views/addcartpageviews_view.dart';
import '../../notificationspage/views/notificationspage_view.dart';
import '../../productdetailspage/views/productdetailspage_view.dart';
import '../controllers/categorydetailspage_controller.dart';

class CategoryDetailspageView extends StatelessWidget {
  CategoryDetailspageView({super.key});

  final CategoryDetailspageController controller = Get.put(
    CategoryDetailspageController(),
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    final padding = screenWidth * 0.04;
    final imageSize = screenWidth * 0.35;
    final titleFontSize = screenWidth < 600 ? 12 : 16;
    final descFontSize = screenWidth * 0.03;

    final crossAxisCount = screenWidth >= 900
        ? 5
        : screenWidth >= 600
        ? 3
        : 2;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Obx(
          () => Text(
            controller.categoryLabel.value,
            style: GoogleFonts.poppins(
              fontSize: titleFontSize + 2,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),

        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: textColor),
                onPressed: () => Get.to(() => AddcartpageviewsView()),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: screenWidth * 0.02,
                  backgroundColor: Colors.red,
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontSize: screenWidth * 0.025,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: textColor),
            onPressed: () => Get.to(() => NotificationspageView()),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.pink),
              );
            }

            if (controller.isError.value || controller.items.isEmpty) {
              return Center(
                child: Text(
                  "No products found in this category.",
                  style: GoogleFonts.acme(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              );
            }

            final products = controller.items;

            return AnimationLimiter(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: products.length, // ✅ show all products
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = products[index]; // ✅ current product

                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: crossAxisCount,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            // Get.offAllNamed(Routes.HOME);
                            Get.offAllNamed(Routes.PRODUCTDETAILSPAGE,
                              arguments: {
                                'images': [product['image_url']],
                                'title': product['name'],
                                'id': product['id'],
                                'price': "₹50/kg",
                                'oldPrice': '₹450',
                              },
                            );
                          },
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: imageSize,
                                    height: imageSize,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isDark
                                          ? const Color.fromARGB(
                                              255,
                                              40,
                                              39,
                                              39,
                                            )
                                          : const Color.fromARGB(
                                              255,
                                              239,
                                              238,
                                              238,
                                            ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          product['image_url']
                                                  .toString()
                                                  .startsWith('http')
                                              ? product['image_url']
                                              : 'https://api.skandaswamyandsons.com${product['image_url']}',
                                        ),

                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Obx(() {
                                      final isFav = controller.isFavourite(
                                        product['id'],
                                      );
                                      return GestureDetector(
                                        onTap: () => controller.toggleFavourite(
                                          product['name'],
                                          product['id'],
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(
                                            screenWidth * 0.015,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? Colors.grey[800]
                                                : Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFav
                                                ? Colors.amber
                                                : Colors.grey,
                                            size: screenWidth * 0.045,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: titleFontSize.toDouble(),
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product['description'] ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: descFontSize,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₹50/kg",
                                style: GoogleFonts.poppins(
                                  fontSize: descFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
