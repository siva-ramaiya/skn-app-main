import 'package:flutter/material.dart';
import 'package:foodapp/app/data/services/api_favorite.dart';
import 'package:foodapp/app/data/services/api_home.dart';
import 'package:foodapp/app/utils/storage_helper.dart';
import 'package:get/get.dart';

class CategoryDetailspageController extends GetxController {
  var items = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var favourites = <int>[].obs; // ✅ store favourite item IDs
  var categoryLabel = ''.obs;

  late ApiFavorite apiFavorite;
  String? token;
  @override
  void onClose() {
    // Reset state when controller is closed
    isLoading.value = false;
    isError.value = false;
    super.onClose();
  }

// In categorydetailspage_controller.dart
  @override
  void onInit() {
    super.onInit();
    print('CategoryDetailspageController - onInit called');

    token = StorageHelper.getToken();

    if (token != null && token!.isNotEmpty) {
      apiFavorite = ApiFavorite(token: token!);
      _loadFavorites();
    } else {
      print("⚠️ No token found in storage!");
    }

    // Get arguments
    final args = Get.arguments;
    print('Received arguments in onInit: $args');

    // Handle category ID and label
    if (args != null && args is Map<String, dynamic>) {
      final categoryId = args['categoryId'] is int
          ? args['categoryId']
          : int.tryParse(args['categoryId']?.toString() ?? '1') ?? 1;
      final categoryLabel = args['categoryLabel']?.toString() ?? 'All Categories';

      print('Setting category - ID: $categoryId, Label: $categoryLabel');
      this.categoryLabel.value = categoryLabel;

      // Only fetch if we have a valid category ID
      if (categoryId > 0) {
        fetchCategoryItems(categoryId);
        return;
      }
    }

    // Default or error case
    isLoading.value = false;
    isError.value = true;
    print('❌ Invalid or missing category ID in arguments');
  }
  /// ✅ Load all favorites from API
  Future<void> _loadFavorites() async {
    try {
      final favData = await apiFavorite.fetchFavorites();
      favourites.assignAll(favData.map((item) => item['id'] as int));
      print("✅ Loaded ${favourites.length} favorite items");
    } catch (e) {
      print("❌ Error loading favorites: $e");
    }
  }

  Future<void> fetchCategoryItems(int id) async {
    try {
      isLoading.value = true;
      isError.value = false;
      items.clear(); // Clear previous items

      print('🔄 Fetching items for category ID: $id');
      final data = await ApiHome.fetchCategoryItems(id);

      if (data != null && data.isNotEmpty) {
        // Log the first item to verify data structure
        if (data.isNotEmpty) {
          print('📝 First item data:');
          (data.first as Map<String, dynamic>).forEach((key, value) {
            print('   - $key: $value (${value?.runtimeType})');
          });
        }

        // Map the data to ensure consistent structure
        final mappedItems = data.map<Map<String, dynamic>>((item) {
          return {
            'id': item['id'] ?? 0,
            'name': item['name']?.toString() ?? 'Unnamed Product',
            'description': item['description']?.toString() ?? '',
            'price': (item['price'] is num)
                ? (item['price'] as num).toDouble()
                : 0.0,
            'old_price': (item['old_price'] is num)
                ? (item['old_price'] as num).toDouble()
                : 0.0,
            'image_url': item['image_url']?.toString() ?? '',
          };
        }).toList();

        items.assignAll(mappedItems);
        print('✅ Loaded ${items.length} items for category ID: $id');
      } else {
        print('ℹ️ No items found for category ID: $id');
        isError.value = false; // Not necessarily an error, just no data
        items.clear();
      }
    } catch (e) {
      print('❌ Error in fetchCategoryItems: $e');
      isError.value = true;
      items.clear();
      Get.snackbar(
        'Error',
        'Failed to load category items. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Check if item is favorite
  bool isFavourite(int itemId) {
    return favourites.contains(itemId);
  }

  /// ✅ Add/Remove favorite
  void toggleFavourite(String productName, int itemId) async {
    if (token == null || token!.isEmpty) {
      print("⚠️ No token available for favorite action.");
      return;
    }

    if (isFavourite(itemId)) {
      favourites.remove(itemId);
      await apiFavorite.removeFromFavorites(itemId);
      print("🧹 Removed from favorites: $productName");
    } else {
      favourites.add(itemId);
      await apiFavorite.addToFavorites(itemId);
      print("❤️ Added to favorites: $productName");
    }
  }
}
