import 'package:get/get.dart';
import '../../../core/controllers/base_controller.dart';
import '../../../core/utils/app_constants.dart';
import '../models/user_model.dart';

class AuthController extends BaseController {
  final user = Rxn<UserModel>();
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final token = storageService.getString(AppConstants.tokenKey);
    if (token != null) {
      final userData = storageService.getString(AppConstants.userKey);
      if (userData != null) {
        try {
          user.value = UserModel.fromJson(
            Map<String, dynamic>.from(
              Uri.splitQueryString(userData),
            ),
          );
          isLoggedIn.value = true;
        } catch (e) {
          handleError(e);
        }
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      startLoading();
      final response = await apiService.post(
        AppConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final token = response.data['token'] as String;
      final userData = response.data['user'] as Map<String, dynamic>;

      await storageService.setString(AppConstants.tokenKey, token);
      await storageService.setString(
        AppConstants.userKey,
        Uri(queryParameters: userData).query,
      );

      user.value = UserModel.fromJson(userData);
      isLoggedIn.value = true;

      Get.offAllNamed('/home');
    } catch (e) {
      handleError(e);
    } finally {
      stopLoading();
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      startLoading();
      final response = await apiService.post(
        AppConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      final token = response.data['token'] as String;
      final userData = response.data['user'] as Map<String, dynamic>;

      await storageService.setString(AppConstants.tokenKey, token);
      await storageService.setString(
        AppConstants.userKey,
        Uri(queryParameters: userData).query,
      );

      user.value = UserModel.fromJson(userData);
      isLoggedIn.value = true;

      Get.offAllNamed('/home');
    } catch (e) {
      handleError(e);
    } finally {
      stopLoading();
    }
  }

  Future<void> logout() async {
    try {
      await storageService.remove(AppConstants.tokenKey);
      await storageService.remove(AppConstants.userKey);
      user.value = null;
      isLoggedIn.value = false;
      Get.offAllNamed('/login');
    } catch (e) {
      handleError(e);
    }
  }
} 