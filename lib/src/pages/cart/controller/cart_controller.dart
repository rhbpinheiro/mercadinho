import 'package:get/get.dart';
import 'package:mercadinho/src/models/cart_item_model.dart';
import 'package:mercadinho/src/pages/auth/controller/auth_controller.dart';
import 'package:mercadinho/src/pages/cart/cart_result/cart_result.dart';
import 'package:mercadinho/src/pages/cart/repository/cart_repository.dart';
import 'package:mercadinho/src/utils/utils_service.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authcontroller = Get.find<AuthController>();
  final utilsServices = UtilsService();
  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authcontroller.user.token!,
      userId: authcontroller.user.id!,
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();
      },
      error: (message) {
        utilsServices.showToast(isError: true, message: message);
      },
    );
  }
}
