import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodapp/app/modules/addcartpageviews/views/addcartpageviews_view.dart';
import 'package:foodapp/app/modules/favouritepageview/controllers/favouritepageview_controller.dart';
import 'package:foodapp/app/modules/favouritepageview/views/favouritepageview_view.dart';
import 'package:foodapp/app/modules/notificationspage/views/notificationspage_view.dart';
import 'package:foodapp/app/modules/productdetailspage/views/productdetailspage_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BarsstickspageView extends StatelessWidget {
  BarsstickspageView({super.key});

  final FavouritepageviewController controller = Get.find();

  final List<Map<String, dynamic>> products = [
    // ---------- Bars & Sticks ----------
    {
      'title': 'Chocobar',
      'image': 'assets/images/Chocobarsss.png',
      'price': '₹50/each',
    },
    {
      'title': 'Mango Dolly',
      'image': 'assets/images/Mango Dolly.png',
      'price': '₹45/each',
    },
    {
      'title': 'Orange Stick',
      'image': 'assets/images/Orange Sticksss.png',
      'price': '₹40/each',
    },
    {
      'title': 'Raspberry Stick',
      'image': 'assets/images/Raspberry Stickss.png',
      'price': '₹55/each',
    },
    {
      'title': 'Pineapple Stick',
      'image': 'assets/images/Pineapple Stickss.png',
      'price': '₹50/each',
    },
    {
      'title': 'Kulfi Stick',
      'image': 'assets/images/Kulfi Stickses.png',
      'price': '₹60/each',
    },
    {
      'title': 'Chocolate Nutty Stick',
      'image': 'assets/images/Chocolate Nutty Stickss.png',
      'price': '₹65/each',
    },
    {
      'title': 'Ice Apple Stick (seasonal)',
      'image': 'assets/images/Ice Apple Stickes.png',
      'price': '₹55/each',
    },
    {
      'title': 'Litchi Stick',
      'image': 'assets/images/Litchi Stickes.png',
      'price': '₹50/each',
    },
    {
      'title': 'Grape Stick',
      'image': 'assets/images/Grape Stickes.png',
      'price': '₹50/each',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey[400] : Colors.grey[700];

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    // 📱💻 Responsiveness
    final padding = screenWidth * 0.04;
    final imageSize = screenWidth * 0.30; // reduced for better grid fit
    final titleFontSize = screenWidth < 600 ? 12 : 16;
    final priceFontSize = screenWidth < 600 ? 12 : 14;
    final ratingSize = screenWidth < 600 ? 14 : 16;
    final crossAxisCount = screenWidth > 1100
        ? 5 // large desktop
        : screenWidth >600
            ? 4 // small desktop / tablet landscape
            : screenWidth > 600
                ? 3 // tablet portrait
                : 2; // mobile

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Bars & Sticks",
          style: GoogleFonts.poppins(
            fontSize: titleFontSize + 2,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: textColor),
                onPressed: () {
                  Get.to(() => AddcartpageviewsView());
                },
              ),
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: screenWidth * 0.02,
                  backgroundColor: Colors.red,
                  child: Text(
                    '2',
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
            onPressed: () {
              Get.to(NotificationspageView());
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border_outlined, color: textColor),
            onPressed: () {
              Get.to(FavouritepageviewView());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10),
          child: AnimationLimiter(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: crossAxisCount,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ProductDetailsViewpageView(),
                            arguments: {
                              'images': [product['image']],
                              'title': product['title'],
                              'price': product['price'],
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
                                        ? const Color.fromARGB(255, 40, 39, 39)
                                        : const Color.fromARGB(
                                            255, 239, 238, 238),
                                    boxShadow: [
                                      if (!isDark)
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4,
                                        ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(product["image"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Obx(() {
                                    final isFav =
                                        controller.isFavourite(product);
                                    return GestureDetector(
                                      onTap: () {
                                        controller.toggleFavourite(product);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          screenWidth * 0.015,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Colors.grey[800]
                                              : Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            if (!isDark)
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 4,
                                              ),
                                          ],
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
                              product["title"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: titleFontSize.toDouble(),
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (product["rating"] != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating: (product["rating"] as double),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: ratingSize.toDouble(),
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "(${product['rating']})",
                                    style: TextStyle(
                                      fontSize: priceFontSize - 2,
                                      color: subTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 4),
                            Text(
                              product["price"],
                              style: GoogleFonts.poppins(
                                fontSize: priceFontSize.toDouble(),
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
          ),
        ),
      ),
    );
  }
}
