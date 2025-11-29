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

class BurgerscreenpageView extends StatelessWidget {
  BurgerscreenpageView({super.key});

  final FavouritepageviewController controller = Get.find();

  final List<Map<String, dynamic>> products = [
    {"title": "Apple", "price": "₹120/kg", "image": "assets/images/apple.png"},
    {
      "title": "Banana",
      "price": "₹40/dozen",
      "image": "assets/images/banana.png",
    },
    {"title": "Mango", "price": "₹150/kg", "image": "assets/images/mango.png"},
    {
      "title": "Orange",
      "price": "₹80/kg",
      "image": "assets/images/orangee.png",
    },
    {
      "title": "Pomegranate",
      "price": "₹90/kg",
      "image": "assets/images/Pomegranate.png",
    },
    {
      "title": "Grapes (Green & Black)",
      "price": "₹100/kg",
      "image": "assets/images/grapesblack.png",
    },
    {"title": "Papaya", "price": "₹30/kg", "image": "assets/images/papaya.png"},
    {
      "title": "Watermelon",
      "price": "₹25/kg",
      "image": "assets/images/Watermelon.png",
    },
    {
      "title": "Muskmelon (Cantaloupe)",
      "price": "₹40/kg",
      "image": "assets/images/Muskmelon.png",
    },
    {
      "title": "Pineapple",
      "price": "₹60/each",
      "image": "assets/images/Pineapple.png",
    },
    {"title": "Guava", "price": "₹50/kg", "image": "assets/images/Guava.png"},
    {
      "title": "Sapota (Chikoo)",
      "price": "₹80/kg",
      "image": "assets/images/sapota.png",
    },
    {
      "title": "Custard apple (Seethapazham)",
      "price": "₹90/kg",
      "image": "assets/images/Custard apple.png",
    },
    {
      "title": "Jackfruit",
      "price": "₹30/kg",
      "image": "assets/images/Jackfruit.png",
    },
    {
      "title": "Dragon fruit",
      "price": "₹250/kg",
      "image": "assets/images/Dragon fruit.png",
    },
    {"title": "Kiwi", "price": "₹300/kg", "image": "assets/images/Kiwi.png"},
    {
      "title": "Strawberry",
      "price": "₹350/kg",
      "image": "assets/images/Strawberry.png",
    },
    {
      "title": "Blueberry (Imported)",
      "price": "₹800/kg",
      "image": "assets/images/Blueberry.png",
    },
    {
      "title": "Lychee",
      "price": "₹180/kg",
      "image": "assets/images/Lychee.png",
    },
    {"title": "Pear", "price": "₹120/kg", "image": "assets/images/pear.png"},
    {"title": "Plum", "price": "₹150/kg", "image": "assets/images/Plum.png"},
    {"title": "Peach", "price": "₹200/kg", "image": "assets/images/Peach.png"},
    {
      "title": "Apricot",
      "price": "₹300/kg",
      "image": "assets/images/Apricot.png",
    },
    {
      "title": "Fig (Anjeer)",
      "price": "₹250/kg",
      "image": "assets/images/Fig.png",
    },
    {
      "title": "Avocado",
      "price": "₹250/kg",
      "image": "assets/images/Avocado.png",
    },
    {
      "title": "Sweetlime",
      "price": "₹60/kg",
      "image": "assets/images/Sweetlime.png",
    },
    {"title": "Lemon", "price": "₹80/kg", "image": "assets/images/Lemon.png"},
    {
      "title": "Gooseberry",
      "price": "₹150/kg",
      "image": "assets/images/Gooseberry.png",
    },
    {"title": "Ber", "price": "₹70/kg", "image": "assets/images/Ber.png"},
    {
      "title": "Woodapple",
      "price": "₹40/kg",
      "image": "assets/images/Woodapple.png",
    },
    {
      "title": "Starfruit",
      "price": "₹120/kg",
      "image": "assets/images/Starfruit.png",
    },
    {"title": "Jamun", "price": "₹100/kg", "image": "assets/images/Jamun.png"},
    {
      "title": "Tamarind",
      "price": "₹120/kg",
      "image": "assets/images/Tamarind.png",
    },
    {
      "title": "Coconut",
      "price": "₹50/each",
      "image": "assets/images/Coconut.png",
    },
    {"title": "Dates", "price": "₹200/kg", "image": "assets/images/Dates.png"},
    {
      "title": "Rambutan",
      "price": "₹350/kg",
      "image": "assets/images/Rambutan.png",
    },
    {
      "title": "Mangosteen",
      "price": "₹400/kg",
      "image": "assets/images/Mangosteen.png",
    },
    {
      "title": "Roseapple",
      "price": "₹60/kg",
      "image": "assets/images/Roseapple.png",
    },
    {
      "title": "Indian blackberry",
      "price": "₹70/kg",
      "image": "assets/images/Indian blackberry.png",
    },
    {
      "title": "Cherry",
      "price": "₹600/kg",
      "image": "assets/images/Cherry.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey[400] : Colors.grey[700];

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    // ✅ MediaQuery based scaling
    final padding = screenWidth * 0.04;
    final imageSize = screenWidth < 600
        ? screenWidth * 0.35
        : screenWidth * 0.20;
    final titleFontSize = screenWidth < 600 ? 12 : 13;
    final priceFontSize = screenWidth < 600 ? 12 : 14;
    final ratingSize = screenWidth < 600 ? 14 : 16;

    // ✅ Responsive grid count
    final crossAxisCount = screenWidth >600
        ? 5
        : screenWidth > 900
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
          "Fruits Menu",
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
                  Get.to(() => const AddcartpageviewsView());
                },
              ),
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: screenWidth * 0.018,
                  backgroundColor: Colors.red,
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontSize: screenWidth * 0.020,
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
              Get.to(() =>  NotificationspageView());
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
                                    itemSize: ratingSize.toDouble(),
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "(${product['rating']})",
                                    style: TextStyle(
                                      fontSize: priceFontSize.toDouble(),
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
