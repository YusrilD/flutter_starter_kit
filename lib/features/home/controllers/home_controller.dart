import 'package:get/get.dart';
import '../../../core/controllers/base_controller.dart';
import '../../auth/controllers/auth_controller.dart';

class HomeController extends BaseController {
  final authController = Get.find<AuthController>();
  final count = 0.obs;

  void increment() {
    count.value++;
  }

  void logout() {
    authController.logout();
  }
} 