import 'package:flutter/material.dart';
import 'package:foodapp/app/data/services/ApiOrderDetails.dart';
import 'package:foodapp/app/modules/orderconfrompageview/controllers/orderconfrompageview_controller.dart';
import 'package:foodapp/app/utils/storage_helper.dart';
import 'package:foodapp/widgets/confirmSuccess.dart';
import 'package:foodapp/widgets/showPaymentSuccessScreen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DeliveryController extends GetxController {
  var currentStage = 0.obs;
  var statusTime = ["10:00 AM", "", "", "", ""].obs;

  void updateStage(int stage, String time) {
    currentStage.value = stage;
    statusTime[stage] = time;
  }
}

class CheckoutController extends GetxController {
  var isConfirmed = false.obs;
}

class OrderConfirmViewpageView extends StatefulWidget {
  const OrderConfirmViewpageView({super.key});

  @override
  State<OrderConfirmViewpageView> createState() =>
      _OrderConfirmViewpageViewState();
}

class _OrderConfirmViewpageViewState extends State<OrderConfirmViewpageView> {
  final deliveryController = Get.put(DeliveryController());
  final checkoutController = Get.put(CheckoutController());
  final userData = <String, dynamic>{}.obs;
  final api = ApiOrderDetails();
  int currentOrderId = 0;

  final addressController = TextEditingController();
  final selectedTime = 'Select Delivery Time'.obs;
  late Razorpay _razorpay;
  List<dynamic> cartItems = [];

  double total = 0.0;

  @override
  void initState() {
    super.initState();
    userData.value = StorageHelper.getUserData() ?? {};
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    Future.delayed(Duration.zero, () {
      final args = Get.arguments as Map<String, dynamic>? ?? {};
      print('cartItems: ${args['cartItems']}');
      setState(() {
        cartItems = args['cartItems'] ?? [];
        total = (args['total'] ?? 0.0).toDouble();
      });
    });
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final orderController = Get.put(OrderconfrompageviewController());
    orderController.deliveryAddress.value = addressController.text;
    orderController.deliveryTime.value = selectedTime.value;
    await api.recordPaymentToBackend(
      transactionId: response.paymentId!,
      razorpayOrderId: response.orderId!,
      status: "success",
      orderId: currentOrderId,
      amount: total ?? 0, // ✅ add this
    );

    await api.updateOrderStatus(
      orderId: currentOrderId,
      status: "",
      paymentStatus: "Paid",
    );
    showPaymentSuccessScreen("cartItems", cartItems);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    await api.recordPaymentToBackend(
      transactionId: "failed_${DateTime.now().millisecondsSinceEpoch}",
      razorpayOrderId: response.error?['metadata']?['order_id'] ?? "unknown",
      status: "failed",
      orderId: currentOrderId,
      amount: total ?? 0, // ✅ add this
    );

    await api.updateOrderStatus(
      orderId: currentOrderId,
      status: "cancelled",
      paymentStatus: "Unpaid",
    );

    Get.snackbar(
      "Payment Failed",
      "Error: ${response.message}",
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      borderRadius: 20,
      icon: Lottie.asset(
        "assets/images/Error animation.json", // your lottie file
        width: MediaQuery.of(context).size.width * 0.10,
        height: MediaQuery.of(context).size.width * 0.10,
        fit: BoxFit.cover,
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      colorText: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      "Wallet Used",
      "Wallet: ${response.walletName}",
      backgroundColor: Colors.orange.shade100,
      colorText: Colors.black,
    );
  }

  void _openRazorpay() async {
    try {
      final orderController = Get.put(OrderconfrompageviewController());

      // Step 1: Call backend to create order + Razorpay order ID
      final backendOrder = await orderController.createOrderAndGetPayment(
        address: addressController.text,
        cartItems: cartItems,
      );

      if (backendOrder == null || backendOrder['razorpay_order'] == null) {
        Get.snackbar("Error", "Failed to create order on server");
        return;
      }


      currentOrderId = backendOrder['order_id'];
      final razorpayOrder = backendOrder['razorpay_order'];
      final razorpayOrderId = razorpayOrder['id'];
      final razorpayKey =
          'rzp_test_RekeU5TN4fzYoT'; // OR from backend if returned
      final totalAmount = backendOrder['total_amount'] ?? 0;

      // Step 2: Prepare Razorpay options from backend data
      var options = {
        'key': razorpayKey,
        'amount': totalAmount * 100, // paise
        'currency': 'INR',
        'name': 'SKN Shop',
        'description': 'Order Payment',
        'order_id': razorpayOrderId,
        'prefill': {
          'contact': userData['phone'] ?? '',
          'email': userData['email'] ?? '',
        },
        'external': {
          'wallets': ['paytm'],
        },
      };

      // Step 3: Open Razorpay payment window
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error opening Razorpay: $e");
      Get.snackbar("Payment Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Media Query values
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    // ✅ Dynamic sizing
    final fontSmall = screenWidth * 0.03;
    final fontMedium = screenWidth * 0.032;
    final fontLarge = screenWidth * 0.04;
    final padding = screenWidth * 0.04;
    final spacing = screenHeight * 0.015;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseTextColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        ),
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ??
            (isDark ? const Color(0xFF202020) : Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Confirm Order',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: fontMedium,
            color: baseTextColor,
          ),
        ),
        iconTheme: IconThemeData(color: baseTextColor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Cart list
            ListView.builder(
              itemCount: cartItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final image = item['image'] ?? '';
                final title = item['title'] ?? '';
                final priceValue = (item['price'] is String)
                    ? double.tryParse(item['price']) ?? 0.0
                    : (item['price'] is num
                          ? (item['price'] as num).toDouble()
                          : 0.0);
                final quantity = int.tryParse(item['quantity'].toString()) ?? 1;

                return Card(
                  color: isDark ? const Color(0xFF212121) : Colors.white,
                  margin: EdgeInsets.only(bottom: spacing),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isDark ? Colors.grey.shade700 : Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(screenWidth * 0.12),
                      topLeft: Radius.circular(screenWidth * 0.03),
                    ),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (image.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              image.startsWith('http')
                                  ? image
                                  : 'https://api.skandaswamyandsons.com$image',
                              height: screenHeight * 0.12,
                              width: screenWidth * 0.25,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/placeholder.png', // fallback if image fails
                                  height: screenHeight * 0.12,
                                  width: screenWidth * 0.25,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),

                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontMedium,
                                  color: baseTextColor,
                                ),
                              ),
                              SizedBox(height: spacing),
                              Text(
                                "Quantity: $quantity",
                                style: GoogleFonts.poppins(
                                  fontSize: fontSmall,
                                  fontWeight: FontWeight.bold,
                                  color: baseTextColor,
                                ),
                              ),
                              SizedBox(height: spacing),
                              Text(
                                'Price: ${item['unitPrice']}',
                                style: GoogleFonts.poppins(
                                  fontSize: fontMedium,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? const Color(0xFF6FB8F4)
                                      : Colors.grey,
                                ),
                              ),
                              SizedBox(height: spacing * 0.8),
                              Text(
                                "Total: ₹${total.toStringAsFixed(2)}",
                                style: GoogleFonts.poppins(
                                  fontSize: fontLarge,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? const Color(0xFFF5CE59)
                                      : Colors.pink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: spacing),
            _buildLabel("Delivery Address", isDark, fontSmall),
            SizedBox(height: spacing * 0.7),
            TextField(
              controller: addressController,
              maxLines: 5,
              style: GoogleFonts.poppins(color: baseTextColor),
              decoration: InputDecoration(
                hintText: 'Enter your address here',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: fontSmall,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Get.isDarkMode
                        ? const Color.fromARGB(255, 247, 210, 98)
                        : Colors.pink,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Get.isDarkMode ? Colors.amberAccent : Colors.pink,
                    width: 2,
                  ),
                ),
              ),
            ),

            SizedBox(height: spacing * 1.3),

            // _buildLabel("Delivery Time", isDark, fontSmall),
            // SizedBox(height: spacing * 0.7),

            // Obx(() {
            //   return DropdownButtonFormField<String>(
            //     value: selectedTime.value == 'Select Delivery Time'
            //         ? null
            //         : selectedTime.value,
            //     hint: Text(
            //       selectedTime.value,
            //       style: TextStyle(
            //         color: isDark ? Colors.grey[300] : Colors.grey[700],
            //         fontSize: fontSmall,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(
            //         horizontal: padding,
            //         vertical: padding * 0.7,
            //       ),
            //       filled: true,
            //       fillColor: isDark ? Colors.grey.shade900 : Colors.white,
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(25),
            //         borderSide: BorderSide(
            //           color: isDark
            //               ? Colors.grey.shade700
            //               : Colors.grey.shade300,
            //           width: 1,
            //         ),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(25),
            //         borderSide: BorderSide(
            //           color: isDark
            //               ? const Color.fromARGB(255, 247, 210, 98)
            //               : Colors.pink,
            //           width: 2,
            //         ),
            //       ),
            //     ),
            //     dropdownColor: isDark ? Colors.pink : const Color(0xFFFACE4F),
            //     borderRadius: BorderRadius.circular(20),
            //     style: GoogleFonts.poppins(
            //       color: baseTextColor,
            //       fontSize: fontMedium,
            //     ),
            //     items: generateTimeSlots()
            //         .map(
            //           (e) => DropdownMenuItem(
            //             value: e,
            //             child: Text(
            //               e,
            //               style: GoogleFonts.poppins(
            //                 fontSize: fontMedium,
            //                 color: baseTextColor,
            //               ),
            //             ),
            //           ),
            //         )
            //         .toList(),
            //     onChanged: (val) {
            //       if (val != null) selectedTime.value = val;
            //     },
            //   );
            // }),
            SizedBox(height: spacing * 2),

            // ✅ Buttons
            Obx(
              () => Row(
                children: [
                  if (!checkoutController.isConfirmed.value)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (addressController.text.isEmpty) {
                            Get.showSnackbar(
                              GetSnackBar(
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.transparent,
                                margin: EdgeInsets.symmetric(
                                  horizontal: padding,
                                  vertical: spacing,
                                ),
                                borderRadius: 8,
                                duration: const Duration(seconds: 3),
                                snackStyle: SnackStyle.FLOATING,
                                messageText: Card(
                                  color: Get.isDarkMode
                                      ? Colors.grey[850]
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(padding),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.1,
                                          height: screenWidth * 0.1,
                                          child: Lottie.asset(
                                            'assets/images/warining.json',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(width: padding),
                                        Expanded(
                                          child: Text(
                                            "Please fill all fields before proceeding.",
                                            style: TextStyle(
                                              color: baseTextColor,
                                              fontSize: fontSmall,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                            return;
                          }

                          confirmSuccess("");
                          checkoutController.isConfirmed.value = true;
                        },
                        icon: Icon(Icons.check_circle, size: fontMedium),
                        label: Text(
                          "Confirm",
                          style: GoogleFonts.poppins(
                            fontSize: fontMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: spacing * 1.2,
                          ),
                        ),
                      ),
                    ),

                  if (checkoutController.isConfirmed.value)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (addressController.text.isEmpty) {
                            Get.snackbar(
                              "Incomplete Info",
                              "Please fill all fields before payment.",
                              backgroundColor: Colors.orange.shade200,
                              colorText: Colors.black,
                            );
                            return;
                          }
                          _openRazorpay();
                        },
                        icon: Icon(Icons.payment, size: fontMedium),
                        label: Text(
                          "Pay Now",
                          style: GoogleFonts.poppins(
                            fontSize: fontMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            242,
                            197,
                            62,
                          ),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: spacing * 1.2,
                          ),
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

  Widget _buildLabel(String text, bool isDark, double fontSize) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: isDark ? Colors.grey.shade300 : Colors.blueGrey,
      ),
    );
  }

  List<String> generateTimeSlots() {
    List<String> slots = [];
    for (int hour = 8; hour < 24; hour++) {
      final start = TimeOfDay(hour: hour, minute: 0);
      final end = TimeOfDay(hour: hour + 1, minute: 0);
      slots.add("${formatTime(start)} - ${formatTime(end)}");
    }
    return slots;
  }

  String formatTime(TimeOfDay time) {
    final h = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final m = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$h:$m $period";
  }
}
