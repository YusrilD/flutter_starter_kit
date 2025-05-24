# Flutter Starter Kit - Project Guide

This guide explains what exists in this project and how to use them.

## 1. Core Components

### 📁 Core Directory (`lib/core/`)
Contains all the base components used throughout the app:

#### Bindings (`core/bindings/`)
- `initial_binding.dart`: Initializes global services when app starts
  - Sets up API service
  - Sets up storage service
  - Injects other global dependencies

#### Controllers (`core/controllers/`)
- `base_controller.dart`: Base class for all controllers
  - Handles loading states
  - Manages error messages
  - Provides common controller functions

#### Services (`core/services/`)
- `api_service.dart`: Handles all API calls
  - Built with Dio for HTTP requests
  - Includes error handling
  - Manages API headers and authentication

- `storage_service.dart`: Manages local storage
  - Uses SharedPreferences
  - Handles data persistence
  - Manages user session

#### Widgets (`core/widgets/`)
Ready-to-use common widgets:
- `custom_button.dart`: Styled buttons with loading state
- `custom_text_field.dart`: Input fields with validation
- `loading_widget.dart`: Loading animations

### 📁 Extensions (`lib/extension.dart/`)
Utility extensions to make development easier:

1. **String Extensions**
   - Email validation
   - Password validation
   - Username validation
   - Text transformations

2. **Number Extensions**
   - Currency formatting
   - File size formatting
   - Temperature conversions

3. **Context Extensions**
   - Screen size helpers
   - Theme access
   - Navigation helpers
   - Dialog/Snackbar showing

4. **List Extensions**
   - List manipulation
   - Calculations (sum, average)
   - Random item selection

5. **Regex Extensions**
   - Email validation
   - Phone number validation
   - URL validation
   - Date/time validation
   - Credit card validation

## 2. Features

### 📁 Authentication Feature (`features/auth/`)
Complete authentication implementation:
- Login screen
- Registration screen
- Password recovery
- Session management

### 📁 Home Feature (`features/home/`)
Main app functionality:
- Dashboard layout
- Navigation menu
- User profile
- Settings

### 📁 Splash Feature (`features/splash/`)
App initialization:
- Loading screen
- Initial data fetching
- Authentication check

## 3. State Management

Using GetX for state management:

```dart
// Example of a controller
class HomeController extends BaseController {
  // Observable variables
  final count = 0.obs;
  final user = Rxn<User>();
  
  // Functions
  void increment() => count.value++;
  
  // API calls
  Future<void> fetchUser() async {
    try {
      startLoading();
      final response = await apiService.get('/user');
      user.value = User.fromJson(response.data);
    } catch (e) {
      handleError(e);
    } finally {
      stopLoading();
    }
  }
}
```

## 4. Available Utilities

### API Handling
```dart
// Making API calls
final response = await apiService.post(
  '/login',
  data: {'email': email, 'password': password}
);

// Handling responses
try {
  await apiService.get('/protected-endpoint');
} catch (e) {
  handleError(e);
}
```

### Local Storage
```dart
// Storing data
await storage.setString('user_token', token);

// Retrieving data
final token = storage.getString('user_token');

// Removing data
await storage.remove('user_token');
```

### Navigation
```dart
// Regular navigation
Get.to(() => HomeScreen());

// Named routes
Get.toNamed('/home');

// With arguments
Get.toNamed('/profile', arguments: {'userId': 123});
```

### UI Components
```dart
// Custom Button
CustomButton(
  text: 'Login',
  onPressed: handleLogin,
  isLoading: controller.isLoading,
);

// Custom TextField
CustomTextField(
  label: 'Email',
  validator: (value) => value.isEmail ? null : 'Invalid email',
  onChanged: (value) => email = value,
);

// Loading Widget
LoadingWidget(
  size: 50,
  color: Colors.blue,
);
```

## 5. How to Use Extensions

### String Extensions
```dart
// Validation
'user@email.com'.isEmail
'Password123!'.isStrongPassword
'@username'.isValidUsername

// Transformation
'hello world'.toTitleCase
'1234567890'.maskCreditCard
```

### Context Extensions
```dart
// Responsive design
if (context.isSmallScreen) {
  // Mobile layout
}

// Theme
Text(
  'Hello',
  style: context.textTheme.headline6,
);

// Screen size
final screenWidth = context.width;
final screenHeight = context.height;
```

## 6. Project Setup

1. **Dependencies**
   - All required packages are in `pubspec.yaml`
   - Run `flutter pub get` to install

2. **Environment Setup**
   - Minimum Flutter SDK: 2.12.0
   - Minimum Dart SDK: 2.12.0

3. **Configuration**
   - API endpoints in `lib/core/utils/app_constants.dart`
   - Theme configuration in `lib/core/theme/app_theme.dart`
   - Routes in `lib/core/routes/app_routes.dart`

## 7. Best Practices

1. **State Management**
   - Use GetX controllers for state
   - Keep business logic in controllers
   - Use reactive variables (.obs) for state

2. **Error Handling**
   - Use try-catch blocks
   - Handle errors in base controller
   - Show user-friendly error messages

3. **Code Organization**
   - Follow feature-first structure
   - Keep features independent
   - Use dependency injection

4. **UI/UX**
   - Use common widgets for consistency
   - Follow responsive design principles
   - Implement loading states 