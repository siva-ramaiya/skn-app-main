import 'dart:math' as math;
import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/app/data/services/ApiOrders.dart';
import 'package:foodapp/app/modules/orderconfrompageview/views/orderconfrompageview_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../controllers/addcartpageviews_controller.dart';

class AddcartpageviewsView extends StatelessWidget {
  const AddcartpageviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddcartpageviewsController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isTablet = width > 600;
    final isWeb = width > 600;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                /// CART ITEMS LIST
                Expanded(
                  child: Obx(() {
                    if (controller.cartItems.isEmpty) {
                      return _buildEmptyCart(isDark, context);
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.01,
                        horizontal: constraints.maxWidth * 0.04,
                      ),
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.cartItems[index];
                        final price = _parsePrice(item['unitPrice']);
                        final quantity = int.tryParse(item['quantity']) ?? 1;
                        final total = price * quantity;
                        return _buildCartTile(
                          context,
                          item,
                          index,
                          controller,
                          price,
                          quantity,
                          total,
                          isDark,
                          constraints.maxWidth,
                          constraints.maxHeight,
                          isTablet,
                          isWeb,
                        );
                      },
                    );
                  }),
                ),

                /// TOTAL & CHECKOUT
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  child: Obx(() {
                    final sliderHeight =
                        (MediaQuery.of(context).size.height * 0.06).clamp(
                          43.0,
                          48.0,
                        );
                    return Container(
                      padding: EdgeInsets.all(
                        isWeb
                            ? 28
                            : isTablet
                            ? 24
                            : 20,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[900] : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(
                          constraints.maxWidth * 0.05,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(2, 4),
                          ),
                        ],
                        border: Border.all(
                          color: isDark
                              ? const Color.fromARGB(246, 243, 206, 151)
                              : Colors.grey.shade400.withOpacity(0.4),
                          width: 0.4,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPriceRow(
                            label: 'Subtotal:',
                            value:
                                '₹${controller.subTotal.value.toStringAsFixed(2)}',
                          ),
                          SizedBox(height: isTablet ? 12 : 8),
                          Divider(
                            thickness: 1,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          SizedBox(height: isTablet ? 12 : 8),
                          _buildPriceRow(
                            label: 'Total:',
                            value:
                                '₹${controller.totalWithDiscount.value.toStringAsFixed(2)}',
                            valueColor: Colors.blue,
                          ),
                          SizedBox(height: isTablet ? 28 : 20),

                          /// CHECKOUT SLIDER
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * 0.02,
                            ),
                            child: ActionSlider.standard(
                              backgroundColor: isDark
                                  ? Colors.orange.shade300
                                  : Colors.pinkAccent,
                              toggleColor: Colors.white,
                              icon: Icon(
                                Icons.shopping_bag,
                                color: isDark
                                    ? Colors.orange.shade300
                                    : Colors.pinkAccent,
                                size: constraints.maxWidth * 0.06,
                              ),
                              successIcon: CircleAvatar(
                                radius: constraints.maxWidth * 0.035,
                                backgroundColor: isDark
                                    ? Colors.white
                                    : Colors.black,
                                child: Icon(
                                  Icons.check,
                                  color: isDark ? Colors.black : Colors.white,
                                  size: constraints.maxWidth * 0.045,
                                ),
                              ),
                              child: Text(
                                'Checkout',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              height: sliderHeight,
                              action: (sliderController) async {
                                sliderController.loading();
                                await Future.delayed(
                                  const Duration(milliseconds: 800),
                                );
                                sliderController.success();
                                await Future.delayed(
                                  const Duration(milliseconds: 2000),
                                );
                                sliderController.reset();
                                Get.to(
                                  () => OrderConfirmViewpageView(),
                                  arguments: {
                                    'cartItems': controller.cartItems,
                                    'total': controller.totalWithDiscount.value,
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),

                SizedBox(height: isTablet ? 18 : 12),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Helper for empty cart
  Widget _buildEmptyCart(bool isDark, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isTablet = width > 600;
    final isWeb = width > 1000;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              "assets/images/addtotot.png",
              height: isWeb
                  ? height * 0.25
                  : isTablet
                  ? height * 0.22
                  : height * 0.2,
              width: isWeb
                  ? width * 0.3
                  : isTablet
                  ? width * 0.35
                  : width * 0.4,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your cart is empty!',
            style: GoogleFonts.poppins(
              fontSize: isWeb
                  ? 18
                  : isTablet
                  ? 16
                  : 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Looks like you haven’t added anything yet.\nStart exploring and fill your cart!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isWeb
                  ? 14
                  : isTablet
                  ? 13
                  : 12,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper for each cart tile
  Widget _buildCartTile(
    BuildContext context,
    Map<String, dynamic> item,
    int index,
    AddcartpageviewsController controller,
    int price,
    int quantity,
    int total,
    bool isDark,
    double width,
    double height,
    bool isTablet,
    bool isWeb,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: isTablet ? 18 : 14),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? const Color.fromARGB(255, 225, 182, 117)
              : Colors.grey.shade300,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.orange.withOpacity(0.1)
                : Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(width * 0.02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: item['image'].toString().startsWith('/uploads/')
                  ? Image.network(
                      'https://api.skandaswamyandsons.com${item['image']}',
                      width: isWeb
                          ? width * 0.15
                          : isTablet
                          ? width * 0.22
                          : width * 0.25,
                      height: isWeb
                          ? height * 0.14
                          : isTablet
                          ? height * 0.13
                          : height * 0.12,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // API image load fail aithe fallback
                        return Image.asset(
                          '',
                          width: isWeb
                              ? width * 0.15
                              : isTablet
                              ? width * 0.22
                              : width * 0.25,
                          height: isWeb
                              ? height * 0.14
                              : isTablet
                              ? height * 0.13
                              : height * 0.12,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      item['image'],
                      width: isWeb
                          ? width * 0.15
                          : isTablet
                          ? width * 0.22
                          : width * 0.25,
                      height: isWeb
                          ? height * 0.14
                          : isTablet
                          ? height * 0.13
                          : height * 0.12,
                      fit: BoxFit.cover,
                    ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isTablet ? 14 : 10,
                horizontal: isTablet ? 12 : 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: isWeb
                          ? 16
                          : isTablet
                          ? 14
                          : 13,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: isTablet ? 8 : 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _QuantityButton(
                            icon: Icons.remove,
                            onPressed: () => controller.decreaseQuantity(index),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              item['quantity'],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: isTablet ? 18 : 16,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          _QuantityButton(
                            icon: Icons.add,
                            onPressed: () => controller.increaseQuantity(index),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: isTablet ? 26 : 22,
                          color: isDark ? Colors.redAccent : Colors.red,
                        ),
                        onPressed: () => _showDeleteDialog(
                          context,
                          isDark,
                          controller,
                          index,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isTablet ? 6 : 3),
                  Text(
                    'Price: ${item['unitPrice']}',
                    style: GoogleFonts.poppins(
                      fontSize: isTablet ? 15 : 13,
                      color: isDark ? Colors.grey.shade400 : Colors.grey,
                    ),
                  ),
                  SizedBox(height: isTablet ? 14 : 12),
                  Text(
                    'Total: ₹$total',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: isTablet ? 14 : 12,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Delete confirm dialog
  void _showDeleteDialog(
    BuildContext context,
    bool isDark,
    AddcartpageviewsController controller,
    int index,
  ) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;
    final isWeb = width > 1000;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isDark
                  ? const Color.fromARGB(255, 225, 182, 117)
                  : Colors.pink,
              width: 1.2,
            ),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: isTablet ? 28 : 24,
                color: isDark ? Colors.orangeAccent : Colors.deepOrange,
              ),
              const SizedBox(width: 8),
              Text(
                "Remove Item",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: isWeb
                      ? width * 0.022
                      : isTablet
                      ? width * 0.028
                      : width * 0.033,
                  color: isDark ? Colors.white : const Color(0xFF1E1E1E),
                ),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to remove this item from your cart?",
            style: GoogleFonts.poppins(
              fontSize: isWeb
                  ? width * 0.020
                  : isTablet
                  ? width * 0.025
                  : width * 0.030,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? Colors.white70
                  : const Color.fromARGB(221, 59, 58, 58),
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: isTablet ? width * 0.025 : width * 0.030,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark
                    ? const Color.fromARGB(255, 245, 203, 77)
                    : Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              onPressed: () {
                controller.removeItem(index);
                Navigator.pop(context);
              },
              child: Text(
                "Remove",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: isTablet ? width * 0.025 : width * 0.030,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Price formatter
  static int _parsePrice(String price) {
    return int.tryParse(price.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
  }

  /// Price row widget
  Widget _buildPriceRow({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final width = MediaQuery.of(context).size.width;
        final isTablet = width > 600;
        final isWeb = width > 1000;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: isWeb
                    ? 16
                    : isTablet
                    ? 15
                    : 14,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: isWeb
                    ? 17
                    : isTablet
                    ? 16
                    : 15,
                color: valueColor ?? (isDark ? Colors.white : Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Quantity Button
class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    return Material(
      color: isDark ? Colors.grey[800] : Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: isTablet ? 28 : 23,
          height: isTablet ? 28 : 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark
                  ? const Color.fromARGB(60, 255, 255, 255)
                  : Colors.grey.shade300,
            ),
          ),
          child: Icon(
            icon,
            size: isTablet ? 20 : 18,
            color: isDark
                ? const Color.fromARGB(255, 247, 197, 121)
                : Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
