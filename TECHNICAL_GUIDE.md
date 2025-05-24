# Flutter Starter Kit - Technical Guide

## Table of Contents
1. [Architecture Overview](#architecture-overview)
2. [Core Services Implementation](#core-services-implementation)
3. [State Management Patterns](#state-management-patterns)
4. [Extension Details](#extension-details)
5. [Widget Library](#widget-library)
6. [Feature Implementation](#feature-implementation)
7. [Testing Guidelines](#testing-guidelines)

## Architecture Overview

### Clean Architecture Layers
```
lib/
├── domain/          # Business logic and entities
├── data/            # Data handling and repositories
└── presentation/    # UI and state management
```

### Dependency Flow
```
UI -> Controllers -> Use Cases -> Repositories -> Data Sources
```

## Core Services Implementation

### API Service
```dart
class ApiService extends GetxService {
  final Dio _dio;
  
  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
    
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token
        final token = Get.find<StorageService>().token;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        // Handle refresh token
        if (error.response?.statusCode == 401) {
          // Refresh token logic
        }
        return handler.next(error);
      }
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Similar implementations for post, put, delete...
}
```

### Storage Service
```dart
class StorageService extends GetxService {
  late SharedPreferences _prefs;
  
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // User Session
  String? get token => _prefs.getString('token');
  Future<bool> setToken(String value) => _prefs.setString('token', value);
  
  // Theme
  bool get isDarkMode => _prefs.getBool('darkMode') ?? false;
  Future<bool> setDarkMode(bool value) => _prefs.setBool('darkMode', value);
  
  // Language
  String get language => _prefs.getString('language') ?? 'en';
  Future<bool> setLanguage(String value) => _prefs.setString('language', value);
  
  // App Settings
  Map<String, dynamic> get settings {
    final data = _prefs.getString('settings');
    if (data != null) {
      return json.decode(data);
    }
    return {};
  }
}
```

## State Management Patterns

### Base Controller Pattern
```dart
abstract class BaseController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = Rxn<String>();
  final _isConnected = true.obs;

  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;
  bool get isConnected => _isConnected.value;

  @override
  void onInit() {
    super.onInit();
    _setupConnectivity();
  }

  void _setupConnectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      _isConnected.value = result != ConnectivityResult.none;
    });
  }

  Future<T> callDataService<T>(Future<T> Function() future) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = null;
      return await future();
    } catch (e) {
      _errorMessage.value = e.toString();
      rethrow;
    } finally {
      _isLoading.value = false;
    }
  }
}
```

### Feature Controller Example
```dart
class AuthController extends BaseController {
  final _user = Rxn<User>();
  final _isAuthenticated = false.obs;

  User? get user => _user.value;
  bool get isAuthenticated => _isAuthenticated.value;

  Future<void> login(String email, String password) async {
    await callDataService(() async {
      final response = await apiService.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      
      final token = response.data['token'];
      await storageService.setToken(token);
      
      _user.value = User.fromJson(response.data['user']);
      _isAuthenticated.value = true;
    });
  }

  Future<void> logout() async {
    await callDataService(() async {
      await apiService.post('/auth/logout');
      await storageService.removeToken();
      _user.value = null;
      _isAuthenticated.value = false;
      Get.offAllNamed(Routes.login);
    });
  }
}
```

## Extension Details

### Advanced String Extensions
```dart
extension StringExtension on String {
  String get capitalize => 
    length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get titleCase => replaceAll(RegExp(' +'), ' ')
    .split(' ')
    .map((str) => str.capitalize)
    .join(' ');

  String get slugify => toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
    .replaceAll(RegExp(r'^-+|-+$'), '');

  String truncate(int maxLength) =>
    length <= maxLength ? this : '${substring(0, maxLength)}...';

  bool get isValidUrl => RegexPatterns.url.hasMatch(this);
  
  String get removeHtmlTags => 
    replaceAll(RegExp(r'<[^>]*>'), '');

  String maskEmail() {
    if (!isEmail) return this;
    final parts = split('@');
    return '${parts[0][0]}***@${parts[1]}';
  }
}
```

### Advanced DateTime Extensions
```dart
extension DateTimeExtension on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return year == yesterday.year && 
           month == yesterday.month && 
           day == yesterday.day;
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}
```

## Widget Library

### Custom Dialog
```dart
class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomDialog({
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => CustomDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        if (cancelText != null)
          TextButton(
            onPressed: onCancel ?? () => Navigator.pop(context, false),
            child: Text(cancelText!),
          ),
        if (confirmText != null)
          ElevatedButton(
            onPressed: onConfirm ?? () => Navigator.pop(context, true),
            child: Text(confirmText!),
          ),
      ],
    );
  }
}
```

### Custom Form Field
```dart
class CustomFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;

  const CustomFormField({
    required this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.controller,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.subtitle1,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefix,
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: validator,
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
```

## Testing Guidelines

### Unit Testing
```dart
void main() {
  group('AuthController Tests', () {
    late AuthController controller;
    late MockApiService mockApiService;
    late MockStorageService mockStorageService;

    setUp(() {
      mockApiService = MockApiService();
      mockStorageService = MockStorageService();
      
      Get.put<ApiService>(mockApiService);
      Get.put<StorageService>(mockStorageService);
      
      controller = AuthController();
    });

    tearDown(() {
      Get.reset();
    });

    test('login success', () async {
      when(mockApiService.post('/auth/login', any))
          .thenAnswer((_) async => Response(
                data: {
                  'token': 'test_token',
                  'user': {'id': 1, 'email': 'test@test.com'}
                },
                statusCode: 200,
              ));

      await controller.login('test@test.com', 'password');

      expect(controller.isAuthenticated, true);
      expect(controller.user, isNotNull);
      verify(mockStorageService.setToken('test_token')).called(1);
    });
  });
}
```

### Widget Testing
```dart
void main() {
  group('CustomButton Widget Tests', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomButton(
            text: 'Test Button',
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows loading indicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomButton(
            text: 'Test Button',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });
  });
} 