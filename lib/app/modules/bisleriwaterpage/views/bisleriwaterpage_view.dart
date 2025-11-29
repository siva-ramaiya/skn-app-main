import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foodapp/app/modules/addcartpageviews/views/addcartpageviews_view.dart';
import 'package:foodapp/app/modules/favouritepageview/controllers/favouritepageview_controller.dart';
import 'package:foodapp/app/modules/favouritepageview/views/favouritepageview_view.dart';
import 'package:foodapp/app/modules/notificationspage/views/notificationspage_view.dart';
import 'package:foodapp/app/modules/productdetailspage/views/productdetailspage_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class bisleriWaterPageView extends StatelessWidget {
  bisleriWaterPageView({super.key});

  final FavouritepageviewController controller = Get.find();

  final List<Map<String, dynamic>> products = [
    {
      'title': 'Bisleri 500ml',
      'image': 'assets/images/Bisleriwater4.jpg',
      'price': '₹80',
    },
    {
      'title': 'Bisleri 1 Litre',
      'image': 'assets/images/Bisleriwater1.png',
      'price': '₹20',
    },
    {
      'title': 'Bisleri 2 Litre',
      'image': 'assets/images/Bisleriwater4.jpg',
      'price': '₹35',
    },
    {
      'title': 'Bisleri 5 Litre',
      'image': 'assets/images/Bisleriwater5.jpg',
      'price': '₹70',
    },
    {
      'title': 'Bisleri 20 Litre Can',
      'image': 'assets/images/Bisleriwater6.jpg',
      'price': '₹80',
    },
    {
      'title': 'Bisleri Soda 750ml',
      'image': 'assets/images/Bisleriwater7.jpg',
      'price': '₹25',
    },
      {
      'title': 'Bisleri Soda 700ml',
      'image': 'assets/images/Bisleri8.png',
      'price': '₹35',
    },
      {
      'title': 'Bisleri Soda 800ml',
      'image': 'assets/images/Bisleriwater9.jpg',
      'price': '₹40',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    // 🔹 Responsive scaling
    final padding = screenWidth * 0.04;
    final imageSize = screenWidth * 0.28;
    final titleFontSize = screenWidth < 600 ? 12.0 : 16.0;
    final priceFontSize = screenWidth * 0.032;

    // 🔹 Responsive grid layout
    final crossAxisCount = screenWidth > 1000
        ? 5
        : screenWidth > 800
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
          "Bisleri Water",
          style: GoogleFonts.poppins(
            fontSize: titleFontSize + 4,
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
              Get.to(() => NotificationspageView());
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border_outlined, color: textColor),
            onPressed: () {
              Get.to(() => FavouritepageviewView());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10),
          child: AnimationLimiter(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
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
                              'oldPrice': '₹100',
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
                                        padding:
                                            EdgeInsets.all(screenWidth * 0.015),
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
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
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
