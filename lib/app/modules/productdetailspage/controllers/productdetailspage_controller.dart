import 'package:foodapp/app/data/services/api_product_details.dart';
import 'package:get/get.dart';

class ProductdetailspageController extends GetxController {
  final ApiProductDetails apiService = ApiProductDetails();

  var products = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;

  /// Fetch products for a category
  Future<void> fetchProducts(int categoryId) async {
    try {
      isLoading.value = true;
      isError.value = false;
      final result = await apiService.fetchProductsByCategory(categoryId);

      if (result.isNotEmpty) {
        products.value = result;
      } else {
        isError.value = true;
      }
    } catch (e) {
      isError.value = true;
      print("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
