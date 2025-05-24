# Flutter Starter Kit Documentation

## Table of Contents
1. [Project Overview](#project-overview)
2. [Project Structure](#project-structure)
3. [Core Features](#core-features)
4. [Extensions](#extensions)
5. [Services](#services)
6. [State Management](#state-management)
7. [UI Components](#ui-components)
8. [Authentication](#authentication)
9. [Usage Examples](#usage-examples)

## Project Overview

The Flutter Starter Kit is a comprehensive template for building Flutter applications with a clean architecture. It includes commonly used dependencies, utilities, and a well-organized project structure.

### Key Features
- Clean Architecture with GetX State Management
- Pre-configured Theme Support (Light/Dark)
- Common Widgets and UI Components
- API Service with Dio
- Local Storage Service
- Extensive Utility Extensions
- Authentication Flow

### Dependencies
```yaml
dependencies:
  get: ^4.3.8            # State Management
  http: ^0.13.4          # HTTP Client
  dio: ^4.0.4           # Advanced HTTP Client
  google_fonts: ^2.1.0   # Custom Fonts
  shimmer: ^2.0.0        # Loading Effects
  intl: ^0.17.0         # Internationalization
  shared_preferences: ^2.0.8  # Local Storage
  logger: ^1.1.0         # Logging
  path_provider: ^2.0.8  # File System Access
  url_launcher: ^6.0.17  # URL Handling
  connectivity_plus: ^2.2.0  # Network Connectivity
  cached_network_image: ^3.1.0  # Image Caching
```

## Project Structure

```
lib/
├── core/
│   ├── bindings/        # Global dependency injection
│   ├── controllers/     # Base controllers
│   ├── models/          # Base models
│   ├── routes/          # App routes
│   ├── services/        # Core services
│   ├── theme/           # App theme
│   ├── utils/           # Utilities
│   └── widgets/         # Common widgets
├── extension.dart/      # Extension utilities
├── features/           # Feature modules
│   ├── auth/           # Authentication
│   ├── home/           # Home feature
│   └── splash/         # Splash screen
└── main.dart           # Entry point
```

## Core Features

### 1. Base Controller
The `BaseController` provides common functionality for all controllers:
```dart
class BaseController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = RxnString();

  // Error handling
  void handleError(dynamic error) {
    stopLoading();
    errorMessage.value = error.toString();
  }

  // Loading state management
  void startLoading() => isLoading.value = true;
  void stopLoading() => isLoading.value = false;
}
```

### 2. API Service
Handles HTTP requests with error handling and interceptors:
```dart
final apiService = Get.find<ApiService>();
final response = await apiService.get('/endpoint');
```

### 3. Storage Service
Manages local storage using SharedPreferences:
```dart
final storage = Get.find<StorageService>();
await storage.setString('key', 'value');
```

## Extensions

### 1. String Extensions
```dart
// Validation
'test@email.com'.isEmail
'Abc123!@#'.isStrongPassword
'john_doe'.isValidUsername

// Transformation
'hello world'.toTitleCase      // 'Hello World'
'1234567890'.maskCreditCard    // '******7890'
'Hello123!'.extractNumbers     // '123'
```

### 2. Number Extensions
```dart
// Formatting
1234.formatWithCommas         // '1,234'
25.celsiusToFahrenheit       // 77.0
1024.formatFileSize          // '1.0 KB'

// Conversions
45.degreesToRadians
180.radiansToDegrees
```

### 3. Context Extensions
```dart
// Theme and Size
context.theme
context.width
context.height

// Responsive Design
context.isSmallScreen
context.isMediumScreen
context.isLargeScreen

// UI Helpers
context.showSnackBar('Message')
context.showCustomDialog(
  title: 'Title',
  message: 'Message'
)
```

### 4. List Extensions
```dart
// Manipulation
[1, 2, 3].randomItem
[1, 2, 2, 3].removeDuplicates
[1, 2, 3, 4].chunk(2)        // [[1, 2], [3, 4]]

// Calculations
[1, 2, 3].sum()              // 6
[1, 2, 3].average()          // 2.0
```

### 5. Regex Extensions
```dart
// Validation
string.isEmail
string.isPhoneNumber
string.isURL
string.isDateTime

// Extraction
string.stripHtmlTags
string.extractMarkdownLinks()
string.extractNumbers
```

## UI Components

### 1. CustomButton
```dart
CustomButton(
  text: 'Click Me',
  onPressed: () {},
  isLoading: false,
  isOutlined: false,
)
```

### 2. CustomTextField
```dart
CustomTextField(
  label: 'Email',
  hint: 'Enter your email',
  validator: (value) => value.isEmail ? null : 'Invalid email',
)
```

### 3. LoadingWidget
```dart
LoadingWidget(
  height: 100,
  width: double.infinity,
)
```

## Authentication

The authentication flow includes:
1. Splash Screen
2. Login Screen
3. Registration Screen
4. Home Screen with logout functionality

### Usage Example
```dart
// Login
await controller.login(email, password);

// Register
await controller.register(name, email, password);

// Logout
await controller.logout();
```

## State Management

GetX is used for state management:
```dart
// Reactive State
final count = 0.obs;

// Update State
count.value++;

// Listen to Changes
Obx(() => Text('${controller.count}'))
```

## Usage Examples

### 1. API Calls
```dart
try {
  final response = await apiService.post(
    '/login',
    data: {'email': email, 'password': password},
  );
  // Handle response
} catch (e) {
  handleError(e);
}
```

### 2. Navigation
```dart
Get.toNamed('/home');
Get.offAllNamed('/login');
```

### 3. Theme Usage
```dart
Text(
  'Hello',
  style: context.titleStyle,
)
```

### 4. Responsive Design
```dart
Widget build(BuildContext context) {
  return context.isSmallScreen
    ? MobileLayout()
    : DesktopLayout();
}
```

## Contributing

Feel free to contribute to this project by:
1. Reporting bugs
2. Suggesting new features
3. Creating pull requests
4. Improving documentation

## License

This project is licensed under the MIT License - see the LICENSE file for details. 