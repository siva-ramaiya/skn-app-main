import 'package:foodapp/app/data/services/ApiOrderDetails.dart';
import 'package:get/get.dart';


class OrderhistorypageController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;
  RxList<dynamic> orders = <dynamic>[].obs;
  final OrderService = ApiOrderDetails();

  @override
  void onInit() {
    super.onInit();
    fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    try {
      isLoading(true);
      isError(false);

      final data = await OrderService.getUserOrders();
      orders.assignAll(data);
    } catch (e) {
      print("Error fetching orders: $e");
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}
