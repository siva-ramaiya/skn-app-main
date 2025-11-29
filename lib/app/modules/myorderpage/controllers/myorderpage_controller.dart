import 'package:foodapp/app/utils/storage_helper.dart';
import 'package:get/get.dart';
import 'package:foodapp/app/data/services/ApiOrderDetails.dart';

class MyorderpageController extends GetxController {
  var orders = <dynamic>[].obs;
   var isLoading = true.obs;

  final api = ApiOrderDetails();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() async {
    String? token = StorageHelper.getToken(); // ✅ get saved token
    isLoading.value = true;
    if (token != null && token.isNotEmpty) {
      final data = await api.getActiveOrders();
      orders.assignAll(data);
      isLoading.value = false;
    } else {
      isLoading.value = false;
      orders.clear();
      print("User token not found");
    }
  }
}
