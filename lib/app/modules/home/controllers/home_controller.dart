import 'package:foodapp/app/data/services/api_home.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var allItems = <Map<String, String>>[].obs;
  var categories = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;

  final String baseUrl = "https://api.skandaswamyandsons.com"; // your server IP

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    try {
      final data = await ApiHome.fetchItems();

      allItems.value = data.map<Map<String, String>>((item) {
        final imagePath = item['image_url']?.toString() ?? '';  
        final fullImageUrl = imagePath.startsWith('http')
            ? imagePath
            : '$baseUrl$imagePath';

        return {
          'id': item['id']?.toString() ?? '',
          'title': item['name']?.toString() ?? '',
          'price': '₹${item['price']?.toString() ?? '0'}',
          'oldPrice': '₹${((item['price'] ?? 0) + 20).toString()}',
          'image': fullImageUrl,
        };
      }).toList();
    } catch (e) {
      print('Fetch Products Error: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      final data = await ApiHome.fetchCategories();

      categories.value = data
          .where((cat) => cat['is_active'] == 1 && cat['is_deleted'] == 0)
          .map<Map<String, dynamic>>((cat) {
        final imagePath = cat['image_url']?.toString() ?? '';
        final fullImageUrl = imagePath.startsWith('http')
            ? imagePath
            : '$baseUrl$imagePath';

        return {
          'id': cat['id']?.toString() ?? '',
          'label': cat['name']?.toString() ?? '',
          'icon': fullImageUrl,
        };
      }).toList();
    } catch (e) {
      print('Fetch Categories Error: $e');
    }
  }

  List<Map<String, String>> get filteredItems {
    if (searchQuery.value.isEmpty) return allItems;
    return allItems
        .where((item) =>
            item['title']!.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
