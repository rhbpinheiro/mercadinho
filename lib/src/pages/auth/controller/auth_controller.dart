import 'package:get/get.dart';
import 'package:mercadinho/src/constants/storage_keys.dart';
import 'package:mercadinho/src/models/user_model.dart';
import 'package:mercadinho/src/pages/auth/repository/auth_repository.dart';
import 'package:mercadinho/src/pages/auth/result/auth_result.dart';
import 'package:mercadinho/src/pages_routes/app_pages.dart';
import 'package:mercadinho/src/utils/utils_service.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final AuthRepository _authRepository = AuthRepository();

  final UtilsService utilsService = UtilsService();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    //recuperar token salvo
    String? token = await utilsService.getLocalData(
      StorageKeys.token,
    );

    if (token == null || token.isEmpty || token == 'null') {
      Get.offAllNamed(PagesRoutes.sigInRoute);
      return;
    }

    AuthResult result = await _authRepository.validateToken(token);

    result.when(
        success: (user) => saveTokenProceedToHome(),
        error: (message) {
          singOut();
        });
  }

  Future<void> singOut() async {
    //Zerar o user
    user = UserModel();
    //Remover o token localmente
    await utilsService.removeLocalData(StorageKeys.token);
    //Ir para o login
    Get.offAllNamed(PagesRoutes.sigInRoute);
  }

  void saveTokenProceedToHome() {
    if (user.token != null) {
      utilsService.saveLocalData(StorageKeys.token, user.token!);
      Get.offAllNamed(PagesRoutes.baseRoute);
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    AuthResult result = await _authRepository.singIn(email, password);
    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        saveTokenProceedToHome();
        utilsService.showToast(
            isError: false, message: 'Login realizado com sucesso');
      },
      error: (message) {
        utilsService.showToast(isError: true, message: message);
      },
    );
  }

  Future<void> singUp() async {
    isLoading.value = true;
    AuthResult result = await _authRepository.singUp(user);
    result.when(
      success: (user) {
        this.user = user;
        saveTokenProceedToHome();
        utilsService.showToast(
          isError: false,
          message: 'Conta criada com sucesso',
        );
      },
      error: (message) {
        utilsService.showToast(
          isError: true,
          message: message,
        );
      },
    );
  }

  Future<void> forgotPassword(String email) async {
    await _authRepository.resetPassword(email);
  }
}
