import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodapp/app/modules/addcartpageviews/views/addcartpageviews_view.dart';
import 'package:foodapp/app/modules/categorypage/views/categorypage_view.dart';
import 'package:foodapp/app/modules/drawerpage/views/drawerpage_view.dart';
import 'package:foodapp/app/modules/notificationspage/views/notificationspage_view.dart';
import 'package:foodapp/app/modules/categorydetailspage/views/categorydetailspage_view.dart';
import 'package:foodapp/app/modules/productdetailspage/views/productdetailspage_view.dart';
import 'package:foodapp/app/routes/app_pages.dart';
import 'package:foodapp/themes/ThemeController%20.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../addcartpageviews/controllers/addcartpageviews_controller.dart';
import '../controllers/home_controller.dart';
import '../../favouritepageview/controllers/favouritepageview_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final favController = Get.put(FavouritepageviewController());
  final themeController = Get.find<ThemeController>();
  final AddcartpageviewsController _cartController = Get.put(AddcartpageviewsController());

  final List<String> bannerImages = [
    'assets/images/banner1.png',
    'assets/images/ban8.avif',
    'assets/images/banner2.png',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      drawer: DrawerView(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).iconTheme.color,
              size: width * 0.07,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: width * 0.045,
              backgroundImage: AssetImage('assets/images/profile1.jpg'),
            ),
            SizedBox(width: width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SKN',
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.03 * textScale,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  'Food Shop',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.027 * textScale,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Theme.of(context).iconTheme.color,
                    size: width * 0.07,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.ADDCARTPAGEVIEWS);
                  },
                ),
                Obx(() {
                  final itemCount = _cartController.cartItems.length;
                  if (itemCount > 0) {
                    return Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: width * 0.04,
                          minHeight: width * 0.04,
                        ),
                        child: Center(
                          child: Text(
                            itemCount > 9 ? '9+' : '$itemCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              size: width * 0.07,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => Get.to(() => NotificationspageView()),
          ),
          IconButton(
            icon: Obx(
              () => Icon(
                themeController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
                size: width * 0.07,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            onPressed: () => themeController.toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _carouselSlider(context),
              SizedBox(height: height * 0.025),
              _searchBar(context),
              SizedBox(height: height * 0.025),
              _categoryTabs(context),
              SizedBox(height: height * 0.025),
              _sectionHeader(context, 'Popular Items'),
              SizedBox(height: height * 0.015),
              Obx(
                () => _nonScrollableProductGrid(
                  controller.filteredItems,
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _carouselSlider(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: size.height * 0.22,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: bannerImages.map((img) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(size.width * 0.03),
          child: Image.asset(img, fit: BoxFit.cover, width: double.infinity),
        );
      }).toList(),
    );
  }

  Widget _searchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return TextField(
      onChanged: (value) => controller.updateSearch(value),
      style: GoogleFonts.poppins(fontSize: width * 0.035 * textScale),
      decoration: InputDecoration(
        hintText: 'Search your food...',
        hintStyle: GoogleFonts.poppins(
          fontSize: width * 0.032 * textScale,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).hintColor,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey.shade600,
          size: width * 0.06,
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.035),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _categoryTabs(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Obx(() {
      if (controller.categories.isEmpty) {
        return Center(child: CircularProgressIndicator(color: Colors.pink));
      }

      return SizedBox(
        height: height * 0.10,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => SizedBox(width: width * 0.03),
          itemBuilder: (context, index) {
            final item = controller.categories[index];
            return SizedBox(
              width: width * 0.16,
              child: InkWell(
                borderRadius: BorderRadius.circular(width * 0.10),
                onTap: () => _navigateToCategory(item['id'], item['label']),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        radius: width * 0.07,
                        backgroundColor: Theme.of(context).cardColor,
                        backgroundImage: NetworkImage(item['icon'] ?? ''),
                      ),
                    ),
                    SizedBox(height: height * 0.006),
                    Expanded(
                      flex: 1,
                      child: Text(
                        item['label'] ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.024 * textScale,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }

  void _navigateToCategory(String categoryId, String categoryLabel) {
    Get.to(
      () => CategoryDetailspageView(),
      arguments: {
        'categoryId': int.tryParse(categoryId) ?? 0,
        'categoryLabel': categoryLabel,
      },
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    final width = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: width * 0.035,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white70 : Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(CategorypageView()),
          child: Text(
            "See All",
            style: GoogleFonts.poppins(
              fontSize: width * 0.035,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.lightBlueAccent : Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _nonScrollableProductGrid(
    List<Map<String, String>> items,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimationLimiter(
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: screenWidth * 0.035,
        crossAxisSpacing: screenWidth * 0.035,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(child: _productCard(item, screenWidth, screenWidth)),
            ),
          );
        },
      ),
    );
  }

  Widget _productCard(
  Map<String, dynamic> item,
  double screenWidth,
  double screenHeight,
) {
  final favController = Get.find<FavouritepageviewController>();
  final isFav = favController.isFavourite(item);

  final bool isDark = Theme.of(Get.context!).brightness == Brightness.dark;

  return GestureDetector(
    onTap: () => Get.to(
        () => ProductDetailsViewpageView(),
        arguments: {
          'id': int.parse(item['id'].toString()),
          'images': [item['image']],
          'title': item['title'],
          'price': item['price'],
          'oldPrice': item['oldPrice'],
        },
      ),
    child: Container(
      width: screenWidth * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        color: Theme.of(Get.context!).cardColor,   // SAME AS YOUR UI
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ⭐ SAME UI — only overlay FIXED
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(screenWidth * 0.02),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,   // FIX: forces clean background under image
              ),
              child: Image.network(
                item['image'] ?? '',
                height: 100,                    // SAME
                width: double.infinity,         // SAME
                fit: BoxFit.cover,              // SAME
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder.png',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),

          // ⭐ TEXT AREA – SAME UI
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? '',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                Text(
                  "₹ ${item['price']}",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                // ⭐ Favorite button — SAME UI
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      favController.toggleFavourite(item);
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.grey,
                      size: screenWidth * 0.07,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
