import 'package:get/get.dart';
 import 'package:foodapp/app/data/services/api_favorite.dart';
import 'package:foodapp/app/utils/storage_helper.dart';

class FavouritepageviewController extends GetxController {
  final RxList<Map<String, dynamic>> favouriteItems = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;



  final ApiFavorite apiFavorite = ApiFavorite(
    token: StorageHelper.getToken() ?? '',
  );


  void onRouteChange(String route) {
    if (route == '/favouritepageview' || route == '/favorites') {
      loadFavorites();
    }
  }

  @override
  void onClose() {
    // No need to remove listener as GetX handles it automatically
    super.onClose();
  }
  Future<void> loadFavorites() async {
    try {
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
    try {
      final id = item['id'];
      final isFav = favouriteItems.any((p) => p['id'] == id);

      if (isFav) {
        final removed = await apiFavorite.removeFromFavorites(id);
        if (removed) {
          favouriteItems.removeWhere((p) => p['id'] == id);
        }
      } else {
        final added = await apiFavorite.addToFavorites(id);
        if (added) {
          favouriteItems.add(item);
        }
      }
    } catch (e) {
      print("❌ Error toggling favorite: $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
    refreshFavorites();
  }


//   Future<void> loadFavorites() async {
//     try {
//       print("🔄 Loading favorite items from API...");
//       isLoading.value = true;
//       final data = await apiFavorite.fetchFavorites();
//       favouriteItems.assignAll(data);
//     } catch (e) {
//       print("❌ Error loading favorites: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//
// // In FavouritepageviewController
//   Future<void> toggleFavourite(Map<String, dynamic> item) async {
//     try {
//       final id = item['id'];
//       final isFav = favouriteItems.any((p) => p['id'] == id);
//
//       if (isFav) {
//         final removed = await apiFavorite.removeFromFavorites(id);
//         if (removed) {
//           await refreshFavorites(); // Refresh the list after removal
//         }
//       } else {
//         final added = await apiFavorite.addToFavorites(id);
//         if (added) {
//           await refreshFavorites(); // Refresh the list after adding
//         }
//       }
//     } catch (e) {
//       print("❌ Error toggling favorite: $e");
//     }
//   }

// Add this method to refresh the favorites list
  Future<void> refreshFavorites() async {
    try {
      isLoading.value = true;
      final data = await apiFavorite.fetchFavorites();
      favouriteItems.assignAll(data);
    } catch (e) {
      print("❌ Error refreshing favorites: $e");
    } finally {
      isLoading.value = false;
    }
  }
  bool isFavourite(Map<String, dynamic> item) {
    return favouriteItems.any((e) => e['id'] == item['id']);
  }
}
