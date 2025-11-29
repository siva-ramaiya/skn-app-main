import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../productdetailspage/views/productdetailspage_view.dart';
import '../controllers/favouritepageview_controller.dart';

class FavoriteCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final FavouritepageviewController controller;
  final bool isDark;

  const FavoriteCard({
    required this.item,
    required this.controller,
    required this.isDark,
    Key? key,
  }) : super(key: key);

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  final RxBool isProcessing = false.obs;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final String name = item['name']?.toString() ?? "No Title";
    final String rawImage = item['image_url']?.toString() ?? "";
    final String imageUrl = rawImage.startsWith("http")
        ? rawImage
        : "https://api.skandaswamyandsons.com$rawImage";
    final double price = double.tryParse(item['price']?.toString() ?? "") ?? 0.0;
    final double rating = double.tryParse(item['rating']?.toString() ?? "") ?? 4.0;

    return Obx(() => Dismissible(
      key: ValueKey<int>(item['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isProcessing.value
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (_) => widget.controller.toggleFavourite(item),
      confirmDismiss: (_) async {
        isProcessing.value = true;
        await widget.controller.toggleFavourite(item);
        isProcessing.value = false;
        return false;
      },
      child: Card(
        elevation: 4,
        color: widget.isDark ? Colors.grey.shade900 : Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 110,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  "assets/images/placeholder.png",
                  width: 110,
                  height: 100,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: widget.isDark  ? Colors.white70 : Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingBarIndicator(
                    rating: rating,
                    itemCount: 5,
                    itemSize: 18,
                    itemBuilder: (_, __) =>
                    const Icon(Icons.star, color: Colors.amber),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "₹ $price",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widget.isDark  ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                      () => ProductDetailsViewpageView(),
                  arguments: {
                    "id": item['id'],
                    "title": name,
                    "image": imageUrl,
                    "price": price,
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}