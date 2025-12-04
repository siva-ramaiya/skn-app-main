import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/app/modules/home/controllers/home_controller.dart';
import 'package:foodapp/app/modules/productdetailspage/controllers/productdetailspage_controller.dart';
import 'package:foodapp/widgets/showaddtocartpopup.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:foodapp/app/data/services/api_cart.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:http/http.dart' as http;

class ProductDetailsViewpageView extends StatefulWidget {
  const ProductDetailsViewpageView({super.key});

  @override
  State<ProductDetailsViewpageView> createState() => _FoodDetailsViewState();
}

class _FoodDetailsViewState extends State<ProductDetailsViewpageView> {
  final ProductdetailspageController controller = Get.put(
    ProductdetailspageController(),
  );
  final storage = GetStorage();

  int currentPage = 0;
  int quantity = 1;

  late List<String> images;
  late String title;
  late String price;
  late String oldPrice;
  late int itemId;

  // ✅ Base URL for relative image paths
  static const String baseUrl = "https://api.skandaswamyandsons.com";

  @override
  void initState() {
    super.initState();
    final args = Get.arguments ?? {};
    print( "Product Details Args: $args");

    // 🖼 Handle image array or single image
    final imageArg = args['images'] ?? [args['image']];
    images = List<String>.from(imageArg);

    title = args['title'] ?? 'Food Item';
    price = args['price']?.toString() ?? '₹0';
    oldPrice = args['oldPrice']?.toString() ?? '₹0';
    itemId = args['item_id'] ?? args['id'] ?? 0;

    if (args['categoryId'] != null) {
      controller.fetchProducts(args['categoryId']);
    }
  }

  int parsePrice(String priceStr) =>
      int.tryParse(priceStr.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

  // ✅ Helper to build full image URL
  String resolveImagePath(String path) {
    if (path.startsWith('http')) {
      return path;
    } else if (path.startsWith('/uploads')) {
      return '$baseUrl$path';
    } else {
      return 'assets/$path';
    }
  }

  // ✅ Share product (works for asset, relative, and network images)
  Future<void> _shareProduct() async {
    try {
      final resolvedPath = resolveImagePath(images[currentPage]);
      Uint8List bytes;

      if (resolvedPath.startsWith('http')) {
        final response = await http.get(Uri.parse(resolvedPath));
        if (response.statusCode == 200) {
          bytes = response.bodyBytes;
        } else {
          throw Exception("Failed to load network image");
        }
      } else {
        final byteData = await rootBundle.load(resolvedPath);
        bytes = byteData.buffer.asUint8List();
      }

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/shared_food.jpg').create();
      await file.writeAsBytes(bytes);

      final shareText =
          '''
🍽️ Dish: $title
💸 Price: $price
❌ Old Price: $oldPrice
🛒 Order now on FoodApp!
''';

      await Share.shareXFiles([XFile(file.path)], text: shareText);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to share food item: $e",
        icon: const Icon(Icons.error_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  final Set<String> _popupShownProducts = {};
  bool get isDark => Get.isDarkMode;

  void onAddToCartPopup() {
    print('Adding to cart: $title');
    if (!_popupShownProducts.contains(title)) {
      _popupShownProducts.add(title);
      showAddToCartPopup(
        title: title,
        image: resolveImagePath(images[currentPage]),
        quantity: quantity,
        totalPrice: "₹${parsePrice(price) * quantity}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final textScale = MediaQuery.of(context).textScaleFactor;

    int unitPrice = parsePrice(price);
    int totalPrice = unitPrice * quantity;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                Get.offAll(() => BottomnavigationbarView()); // Replace with your home screen widget
              }
            },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white, size: width * 0.06),
            onPressed: _shareProduct,
          ),
          SizedBox(width: width * 0.02),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.pink),
          );
        } else if (controller.isError.value) {
          return const Center(child: Text("Failed to load products"));
        }

        return Stack(
          children: [
            if (images.isNotEmpty)
              Positioned.fill(
                child: Image.network(
                  resolveImagePath(images[currentPage]),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: kToolbarHeight + height * 0.05,
                bottom: height * 0.03,
              ),
              child: Container(
                margin: EdgeInsets.only(top: height * 0.3),
                padding: EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor.withOpacity(0.97),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(width * 0.07),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: width * 0.05,
                      offset: Offset(0, -height * 0.01),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index, _) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          child: Image.network(
                            resolveImagePath(images[index]),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'assets/images/placeholder.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: height * 0.25,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, _) {
                          setState(() => currentPage = index);
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.034 * textScale,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.01),

                    Row(
                      children: [
                        Text(
                          "₹$totalPrice",
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.045 * textScale,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          oldPrice,
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.04 * textScale,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),

                    Text(
                      "Select Quantity",
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.04 * textScale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                          },
                          icon: Icon(
                            Icons.remove_circle_outline,
                            size: width * 0.07,
                          ),
                        ),
                        Text(
                          quantity.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.045 * textScale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: width * 0.07,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),

                    Text(
                      "Ingredients",
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.035 * textScale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "Fresh veggies, spices, organic base, and chef's secret sauce. Prepared with love and hygiene guaranteed.",
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.030 * textScale,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: height * 0.04),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: SizedBox(
                        width: double.infinity,
                        height: height * 0.065,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark
                                ? Colors.orange.shade300
                                : Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            final api = ApiCart();
                            final response = await api.addToCart(
                              itemId: itemId,
                              quantity: quantity,
                            );

                            if (response['status'] == 'success') {
                              onAddToCartPopup();
                              Get.snackbar(
                                "Success",
                                response['message'] ??
                                    "Item added to cart successfully",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white,
                                colorText: Colors.black,
                                icon: Lottie.asset(
                                  'assets/images/Success.json',
                                  width: 40,
                                  height: 40,
                                  repeat: false,
                                ),
                                margin: const EdgeInsets.all(10),
                                borderRadius: 12,
                                duration: const Duration(seconds: 2),
                              );

                              await Future.delayed(
                                const Duration(milliseconds: 800),
                              );

                              // ✅ Ensure HomeController is available before navigating
                              // if (!Get.isRegistered<HomeController>()) {
                              //   Get.put(HomeController());
                              // }

                              Get.to(() => BottomnavigationbarView());
                            } else {
                              Get.snackbar(
                                "Error",
                                response['message'] ?? "Failed to add item to cart",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white,
                                colorText: Colors.black,
                                icon: Lottie.asset(
                                  'assets/images/Error animation.json',
                                  width: 40,
                                  height: 40,
                                  repeat: false,
                                ),
                                margin: const EdgeInsets.all(10),
                                borderRadius: 12,
                                duration: const Duration(seconds: 2),
                              );
                            }
                          },
                          child: Text(
                            "Add To Cart",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: textScale * width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
