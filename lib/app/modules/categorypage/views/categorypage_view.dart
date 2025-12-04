import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/categorydetailspage/views/categorydetailspage_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import '../controllers/categorypage_controller.dart';
import 'package:foodapp/app/modules/home/controllers/home_controller.dart';

class CategorypageView extends StatefulWidget {
  const CategorypageView({super.key});

  @override
  State<CategorypageView> createState() => _CategorypageViewState();
}

class _CategorypageViewState extends State<CategorypageView> {
  bool isSearching = false;
  String query = "";

  final HomeController homeController = Get.find<HomeController>();

  // Final mapped list (NOT OBS, avoid rebuild issues)
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    print("HomeController Categories: ${homeController.categories}");
    // Load categories from API response
    categories = homeController.categories.map((cat) {
      return {
        "id": cat['id'] ?? "",
        "name": cat['label'] ?? "",
        "items": "All Items",
        // FIX URL → Your base URL + image_url
        "image": cat['icon'],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double cardRadius = screenWidth * 0.08;
    double avatarRadius = screenWidth * 0.1;
    double titleSize = screenWidth * 0.036;
    double subtitleSize = screenWidth * 0.029;
    double spacing = screenHeight * 0.008;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Filter categories
    final filteredCategories = categories.where((cat) {
      return cat["name"]!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    print("Filtered Categories: $filteredCategories");

    return Scaffold(
      backgroundColor: isDark ? theme.scaffoldBackgroundColor : Colors.white,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: isDark
            ? const Color.fromARGB(255, 250, 210, 89)
            : Colors.pink,
        elevation: 0,
        title: isSearching
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  autofocus: true,
                  onChanged: (val) {
                    setState(() => query = val);
                  },
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: GoogleFonts.poppins(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
              )
            : Text(
                "Categories",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                query = "";
              });
            },
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
      ),

      // Body
      body: Container(
        decoration: BoxDecoration(
          color: isDark ? theme.scaffoldBackgroundColor : Colors.grey.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cardRadius),
            topRight: Radius.circular(cardRadius),
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(screenWidth * 0.04),
          itemCount: filteredCategories.length,
          itemBuilder: (context, index) {
            final category = filteredCategories[index];

            Widget getTargetScreen() {
              print("Navigating to Category Details for: ${category['name']}");
              Get.put(CategorypageController());
              return CategoryDetailspageView();
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

            return TweenAnimationBuilder(
              tween: Tween<Offset>(
                begin: const Offset(0, -0.5),
                end: Offset.zero,
              ),
              duration: Duration(milliseconds: 1200 + (index * 100)),
              curve: Curves.easeOutBack,
              builder: (context, Offset offset, child) {
                return Transform.translate(
                  offset: offset * 120,
                  child: Opacity(
                    opacity: 1 - offset.dy.abs() * 0.8,
                    child: child,
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                child: OpenContainer(
                  transitionType: ContainerTransitionType.fadeThrough,
                  closedElevation: 5,
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(cardRadius),
                  ),

                  closedBuilder: (context, action) {
                    return GestureDetector(
                      onTap: () {
                        _navigateToCategory(
                          category['id'].toString(),
                          category['name'],
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.025,
                              horizontal: screenWidth * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: isDark ? theme.cardColor : Colors.white,
                              borderRadius: BorderRadius.circular(cardRadius),
                              boxShadow: isDark
                                  ? []
                                  : [
                                      const BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                              border: Border.all(
                                color: isDark
                                    ? const Color.fromARGB(255, 245, 140, 175)
                                    : const Color.fromARGB(255, 249, 213, 107),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: avatarRadius * 2.2),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category["name"],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: titleSize,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: spacing),
                                      Text(
                                        category["items"],
                                        style: GoogleFonts.poppins(
                                          fontSize: subtitleSize,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.grey.shade400
                                              : Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFFF9D25D)
                                        : Colors.pink,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: screenWidth * 0.045,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            left: -2,
                            top: -2,
                            child: CircleAvatar(
                              radius: avatarRadius,
                              backgroundColor: isDark
                                  ? const Color(0xFF2C2C2C)
                                  : Colors.white,
                              child: Image.network(
                                category["image"],
                                fit: BoxFit.cover,
                                width: avatarRadius * 2.15,
                                height: avatarRadius * 1.9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },

openBuilder: (context, action) {
  Future.microtask(() {
    Get.off(
      () => CategoryDetailspageView(),
      arguments: {
        'categoryId': category['id'],
        'categoryLabel': category['name'],
      },
    );
  });

  return const Scaffold(
    backgroundColor: Colors.transparent,
  );
},

                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
