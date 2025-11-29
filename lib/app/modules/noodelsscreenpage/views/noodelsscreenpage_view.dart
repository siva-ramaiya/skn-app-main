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

class NoodelsscreenpageView extends StatelessWidget {
  NoodelsscreenpageView({super.key});

  final FavouritepageviewController controller = Get.find();

  final List<Map<String, dynamic>> products = [
    // ---------- ice cream ----------
    {
      "title": "Vanilla Cup",
      "price": "₹50/each",
      "image": "assets/images/Vanilla Cup.png",
    },
    {
      "title": "Strawberry Cup",
      "price": "₹60/each",
      "image": "assets/images/Strawberry Cup.png",
    },
    {
      "title": "Chocolate Cup",
      "price": "₹70/each",
      "image": "assets/images/Chocolate Cup.png",
    },
    {
      "title": "Butterscotch Cup",
      "price": "₹65/each",
      "image": "assets/images/Butterscotch Cup.png",
    },
    {
      "title": "Mango Cup",
      "price": "₹60/each",
      "image": "assets/images/Mango Cups.png",
    },
    {
      "title": "Pista Cup",
      "price": "₹75/each",
      "image": "assets/images/Pista Cup.png",
    },
    {
      "title": "Black Currant Cup",
      "price": "₹80/each",
      "image": "assets/images/Black Currant Cup.png",
    },
    {
      "title": "Kesar Pista Cup",
      "price": "₹90/each",
      "image": "assets/images/Kesar Pista Cup.png",
    },
    {
      "title": "American Nuts Cup",
      "price": "₹100/each",
      "image": "assets/images/American Nuts Cup.png",
    },
    {
      "title": "Kulfi Cup",
      "price": "₹85/each",
      "image": "assets/images/Kulfi Cupasss.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey[400] : Colors.grey[700];

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    final padding = screenWidth * 0.04;
    final imageSize = screenWidth * 0.35;
    final titleFontSize = screenWidth < 600 ? 12 : 13;
    final priceFontSize = screenWidth * 0.032;
    final ratingSize = screenWidth * 0.035;
    final crossAxisCount = screenWidth > 800
        ? 4
        : screenWidth > 600
        ? 3
        : 2;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          " icecream Menu",
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
                                            255,
                                            239,
                                            238,
                                            238,
                                          ),
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
                                    final isFav = controller.isFavourite(
                                      product,
                                    );
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
                                                color: Colors.black.withOpacity(
                                                  0.1,
                                                ),
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
                                    itemSize: ratingSize,
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
                                fontSize: priceFontSize,
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
