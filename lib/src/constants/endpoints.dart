const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class Endpoints {
  static const String signin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/valid_token';
  static const String resetPassword = '$baseUrl/reset_password';
  static const String getAllCategories = '$baseUrl/get-category-list';
  static const String getAllProducts = '$baseUrl/get-product-list';
  static const String getCartItems = '$baseUrl/get-cart-items';
}
