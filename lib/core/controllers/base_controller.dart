import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class BaseController extends GetxController {
  final apiService = Get.find<ApiService>();
  final storageService = Get.find<StorageService>();
  
  final isLoading = false.obs;
  final errorMessage = RxnString();
  
  void startLoading() {
    isLoading.value = true;
    errorMessage.value = null;
  }
  
  void stopLoading() {
    isLoading.value = false;
  }
  
  void handleError(dynamic error) {
    stopLoading();
    errorMessage.value = error.toString();
  }
  
  void showSnackbar(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? 'Error' : 'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Get.theme.colorScheme.error : Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
    );
  }
} 