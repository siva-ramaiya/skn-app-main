import 'package:flutter/material.dart';
import 'package:foodapp/app/modules/bottomnavgationbar/views/bottomnavgationbar_view.dart';
import 'package:foodapp/themes/order_status_timeline.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/myorderpage_controller.dart';

class MyorderpageView extends GetView<MyorderpageController> {
  const MyorderpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.03;
    final isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: isDark
            ? const Color.fromARGB(255, 249, 209, 88)
            : Colors.pink,
        title: Text(
          "My Orders",
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => BottomnavigationbarView());
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: isDark ? Colors.amber : Colors.pink,
                ),
              );
            }

            if (controller.orders.isEmpty) {
              return Center(
                child: Text(
                  "No orders yet!",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              );
            }

            return AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: padding / 2,
                ),
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  final order = controller.orders[index];

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 900),
                    child: SlideAnimation(
                      horizontalOffset: 50,
                      child: FadeInAnimation(
                        child: Dismissible(
                          key: Key(order["id"].toString()!),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color.fromARGB(255, 243, 205, 90)
                                  : Colors.pink,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            controller.orders.removeAt(index);

                            // 🔥 Animated Snackbar from Top
                            Flushbar(
                              margin: const EdgeInsets.all(12),
                              borderRadius: BorderRadius.circular(12),
                              backgroundColor: isDark
                                  ? Colors.pink
                                  : const Color.fromARGB(255, 245, 203, 79),
                              duration: const Duration(seconds: 2),
                              flushbarPosition: FlushbarPosition.TOP,
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 28,
                              ),
                              messageText: Text(
                                "${order["item"]} removed from orders",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              titleText: Text(
                                "Order Deleted",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              animationDuration: const Duration(
                                milliseconds: 500,
                              ), // Smooth
                              forwardAnimationCurve: Curves.easeOutBack,
                            ).show(context);
                          },
                          child: _buildOrderTile(order, size, padding, isDark),
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

  Widget _buildOrderTile(
    dynamic order,
    Size size,
    double padding,
    bool isDark,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: padding / 2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? Colors.grey[900] : Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ORDER TITLE
          Text(
            "Order #${order['order_number']}",
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // ITEMS LIST
          Column(
            children: (order['items'] as List).map((item) {
              print(item);
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://api.skandaswamyandsons.com${item['itemData']['image_url']}",
                  ),
                ),
                title: Text(item['itemData']['name']),
                subtitle: Text("Qty: ${item['quantity']}"),
                trailing: Text("₹ ${item['total']}"),
              );
            }).toList(),
          ),

          const SizedBox(height: 10),

          // STATUS TIMELINE
          OrderStatusTimeline(status: order["status"]),

          const SizedBox(height: 10),

          // PRICE
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "Total: ₹${order['total_amount']}",
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Out for delivery":
        return Colors.blue;
      case "Cooking":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
