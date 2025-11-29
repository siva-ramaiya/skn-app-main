import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:foodapp/app/data/services/api_favorite.dart';
import 'package:foodapp/app/utils/storage_helper.dart';

class FavouritepageviewController extends GetxController {
  final RxList<Map<String, dynamic>> favouriteItems =
      <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  final ApiFavorite apiFavorite = ApiFavorite(
    token: StorageHelper.getToken() ?? '',
  );

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      print("🔄 Loading favorite items from API...");
      isLoading.value = true;
      final data = await apiFavorite.fetchFavorites();
      favouriteItems.assignAll(data);
    } catch (e) {
      print("❌ Error loading favorites: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavourite(Map<String, dynamic> item) async {
    final id = item['id'];

    final isFav = favouriteItems.any((p) => p['id'] == id);

    if (isFav) {
      final removed = await apiFavorite.removeFromFavorites(id);
      if (removed) {
        favouriteItems.removeWhere((p) => p['id'] == id);
      }
    } else {
      final added = await apiFavorite.addToFavorites(id);
      if (added) favouriteItems.add(item);
    }
  }

  bool isFavourite(Map<String, dynamic> item) {
    return favouriteItems.any((e) => e['id'] == item['id']);
  }
}
