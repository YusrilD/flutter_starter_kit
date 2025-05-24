import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core Services
    Get.putAsync(() => StorageService().init());
    Get.put(ApiService());
  }
} 