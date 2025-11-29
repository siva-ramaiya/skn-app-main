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
  void onInit() {
    super.onInit();
    token = StorageHelper.getToken();

    if (token != null && token!.isNotEmpty) {
      apiFavorite = ApiFavorite(token: token!);
      _loadFavorites(); // ✅ load favs from server
    } else {
      print("⚠️ No token found in storage!");
    }

    // ✅ Get categoryId from arguments
    final args = Get.arguments ?? {};
    final categoryId = int.tryParse(args['categoryId'].toString()) ?? 1;
    categoryLabel.value = args['categoryLabel'] ?? 'All Category';

    fetchCategoryItems(categoryId);
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

  /// ✅ Fetch items for selected category
  void fetchCategoryItems(int id) async {
    try {
      isLoading.value = true;
      isError.value = false;

      final data = await ApiHome.fetchCategoryItems(id);
      if (data != null) {
        items.assignAll(data.cast<Map<String, dynamic>>());
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
      print("Error fetching category items: $e");
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
