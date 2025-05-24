# Flutter Starter Kit

A production-ready Flutter starter template with clean architecture, GetX state management, and extensive utilities.

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter_starter_kit.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Features

- 🏗️ Clean Architecture with GetX
- 🎨 Pre-configured Theme Support
- 🧩 Common UI Components
- 🔒 Authentication Flow
- 🔧 Extensive Utilities
- 📱 Responsive Design
- 🌐 API Integration
- 💾 Local Storage

## Documentation

For detailed documentation, please see [DOCUMENTATION.md](DOCUMENTATION.md)

## Requirements

- Flutter SDK: >=2.12.0
- Dart: >=2.12.0

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you find this project helpful, please give it a ⭐️ on GitHub!

## Project Structure

```
lib/
├── core/
│   ├── bindings/
│   │   └── initial_binding.dart
│   ├── controllers/
│   │   └── base_controller.dart
│   ├── models/
│   │   └── base_model.dart
│   ├── routes/
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   └── storage_service.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   └── app_constants.dart
│   └── widgets/
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       └── loading_widget.dart
├── features/
│   ├── auth/
│   │   ├── bindings/
│   │   ├── controllers/
│   │   ├── models/
│   │   └── views/
│   ├── home/
│   │   ├── bindings/
│   │   ├── controllers/
│   │   ├── models/
│   │   └── views/
│   └── splash/
│       └── views/
└── main.dart
```

## Dependencies

- get: ^4.3.8 (State Management)
- http: ^0.13.4 (HTTP Client)
- dio: ^4.0.4 (HTTP Client with more features)
- google_fonts: ^2.1.0 (Custom Fonts)
- shimmer: ^2.0.0 (Loading Effects)
- shared_preferences: ^2.0.8 (Local Storage)
- intl: ^0.17.0 (Internationalization)
- logger: ^1.1.0 (Logging)
- path_provider: ^2.0.8 (File System Access)
- url_launcher: ^6.0.17 (URL Handling)
- connectivity_plus: ^2.2.0 (Network Connectivity)
- cached_network_image: ^3.1.0 (Image Caching)

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Update the `AppConstants` class with your configuration
4. Start building your features!

## Usage

### API Calls
```dart
final apiService = Get.find<ApiService>();
final response = await apiService.get('/endpoint');
```

### Local Storage
```dart
final storage = Get.find<StorageService>();
await storage.setString('key', 'value');
final value = storage.getString('key');
```

### Navigation
```dart
Get.toNamed(Routes.home);
```

### State Management
```dart
class HomeController extends BaseController {
  final count = 0.obs;
  
  void increment() {
    count.value++;
  }
}
```

## Contributing

Feel free to submit issues and enhancement requests!
