import 'package:flutter/material.dart';

extension CustomTextTheme on BuildContext {
  TextStyle get customHeadline6 => Theme.of(this).textTheme.headline6!.copyWith(
        fontFamily: 'YourCustomFont',
      );
}

extension ContextExtension on BuildContext {
  // Theme extensions
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Size extensions
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  // Padding
  double get paddingTop => mediaQuery.padding.top;
  double get paddingBottom => mediaQuery.padding.bottom;
  double get paddingLeft => mediaQuery.padding.left;
  double get paddingRight => mediaQuery.padding.right;

  // Screen size helpers
  bool get isSmallScreen => width < 600;
  bool get isMediumScreen => width >= 600 && width < 1200;
  bool get isLargeScreen => width >= 1200;

  // Orientation
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  // Platform
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;

  // Responsive spacing
  double get spacing => width * 0.02;
  double get spacingSmall => spacing * 0.5;
  double get spacingLarge => spacing * 2;

  // Responsive font sizes
  double get fontSizeSmall => isSmallScreen ? 12 : 14;
  double get fontSizeMedium => isSmallScreen ? 14 : 16;
  double get fontSizeLarge => isSmallScreen ? 16 : 18;

  // Common text styles
  TextStyle get titleStyle => textTheme.headlineMedium!.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subtitleStyle => textTheme.titleMedium!.copyWith(
        color: colorScheme.secondary,
      );

  TextStyle get bodyStyle => textTheme.bodyMedium!;

  // Show snackbar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Show dialog
  Future<T?> showCustomDialog<T>({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<T>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
              child: Text(cancelText),
            ),
          if (confirmText != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text(confirmText),
            ),
        ],
      ),
    );
  }

  // Show bottom sheet
  Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    Color? backgroundColor,
    double? height,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isDismissible: isDismissible,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      constraints: BoxConstraints(
        maxHeight: height ?? size.height * 0.85,
      ),
      builder: (context) => child,
    );
  }
}




    // Headlines:
    //     headline1
    //     headline2
    //     headline3
    //     headline4
    //     headline5
    //     headline6

    // Subtitles:
    //     subtitle1
    //     subtitle2

    // Body Texts:
    //     bodyText1
    //     bodyText2

    // Other Styles:
    //     caption: Used for small text that complements other content.
    //     button: Used for text on buttons.
    //     overline: A very small style for additional information.