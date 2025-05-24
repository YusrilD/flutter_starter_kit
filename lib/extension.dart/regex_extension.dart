/// A collection of commonly used RegExp patterns
class RegexPatterns {
  // Basic validations
  static final RegExp email = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp password = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$',
  );

  static final RegExp username = RegExp(
    r'^[a-zA-Z0-9._]{3,20}$',
  );

  // Phone numbers
  static final RegExp phoneInternational = RegExp(
    r'^\+(?:[0-9] ?){6,14}[0-9]$',
  );

  static final RegExp phoneIndonesia = RegExp(
    r'^(\+62|62)?[\s-]?0?8[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{2,5}$',
  );

  // URLs and links
  static final RegExp url = RegExp(
    r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
  );

  static final RegExp ipAddress = RegExp(
    r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
  );

  // Date formats
  static final RegExp date = RegExp(
    r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$',
  );

  static final RegExp time24Hour = RegExp(
    r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$',
  );

  static final RegExp dateTime = RegExp(
    r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])[T\s]([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$',
  );

  // Numbers and currency
  static final RegExp number = RegExp(r'^\d+$');
  
  static final RegExp decimal = RegExp(r'^\d*\.?\d+$');
  
  static final RegExp currency = RegExp(
    r'^\$?\d+(,\d{3})*(\.\d{2})?$',
  );

  // Social media handles
  static final RegExp twitterHandle = RegExp(r'^@?[a-zA-Z0-9_]{1,15}$');
  
  static final RegExp instagramHandle = RegExp(
    r'^@?[a-zA-Z0-9._]{1,30}$',
  );

  // Color codes
  static final RegExp hexColor = RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$');
  
  static final RegExp rgbColor = RegExp(
    r'^rgb\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*\)$',
  );

  // File extensions
  static final RegExp imageFile = RegExp(
    r'\.(jpg|jpeg|png|gif|bmp|webp)$',
    caseSensitive: false,
  );

  static final RegExp videoFile = RegExp(
    r'\.(mp4|avi|mov|wmv|flv|mkv)$',
    caseSensitive: false,
  );

  static final RegExp audioFile = RegExp(
    r'\.(mp3|wav|wma|aac|ogg)$',
    caseSensitive: false,
  );

  // HTML and markdown
  static final RegExp htmlTag = RegExp(
    r'<[^>]*>',
  );

  static final RegExp markdownLink = RegExp(
    r'\[([^\]]+)\]\(([^)]+)\)',
  );

  // Credit card numbers
  static final RegExp creditCard = RegExp(
    r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13}|6(?:011|5[0-9][0-9])[0-9]{12})$',
  );

  // Postal codes
  static final RegExp postalCodeIndonesia = RegExp(r'^\d{5}$');
  
  static final RegExp postalCodeUS = RegExp(r'^\d{5}(-\d{4})?$');
}

extension RegexExtension on String {
  bool get isEmail => RegexPatterns.email.hasMatch(this);
  
  bool get isStrongPassword => RegexPatterns.password.hasMatch(this);
  
  bool get isValidUsername => RegexPatterns.username.hasMatch(this);
  
  bool get isPhoneNumber => RegexPatterns.phoneInternational.hasMatch(this);
  
  bool get isIndonesianPhone => RegexPatterns.phoneIndonesia.hasMatch(this);
  
  bool get isURL => RegexPatterns.url.hasMatch(this);
  
  bool get isIPAddress => RegexPatterns.ipAddress.hasMatch(this);
  
  bool get isDate => RegexPatterns.date.hasMatch(this);
  
  bool get isTime24Hour => RegexPatterns.time24Hour.hasMatch(this);
  
  bool get isDateTime => RegexPatterns.dateTime.hasMatch(this);
  
  bool get isNumber => RegexPatterns.number.hasMatch(this);
  
  bool get isDecimal => RegexPatterns.decimal.hasMatch(this);
  
  bool get isCurrency => RegexPatterns.currency.hasMatch(this);
  
  bool get isTwitterHandle => RegexPatterns.twitterHandle.hasMatch(this);
  
  bool get isInstagramHandle => RegexPatterns.instagramHandle.hasMatch(this);
  
  bool get isHexColor => RegexPatterns.hexColor.hasMatch(this);
  
  bool get isRGBColor => RegexPatterns.rgbColor.hasMatch(this);
  
  bool get isImageFile => RegexPatterns.imageFile.hasMatch(this);
  
  bool get isVideoFile => RegexPatterns.videoFile.hasMatch(this);
  
  bool get isAudioFile => RegexPatterns.audioFile.hasMatch(this);
  
  bool get isCreditCard => RegexPatterns.creditCard.hasMatch(this);
  
  bool get isIndonesianPostalCode => 
      RegexPatterns.postalCodeIndonesia.hasMatch(this);
  
  bool get isUSPostalCode => RegexPatterns.postalCodeUS.hasMatch(this);

  String get stripHtmlTags => 
      replaceAll(RegexPatterns.htmlTag, '');

  List<String> extractMarkdownLinks() {
    return RegexPatterns.markdownLink
        .allMatches(this)
        .map((match) => match.group(1) ?? '')
        .toList();
  }

  String get sanitizeUsername {
    return toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9._]'), '')
        .replaceAll(RegExp(r'\.{2,}'), '.')
        .replaceAll(RegExp(r'^[._]|[._]$'), '');
  }

  String maskCreditCard() {
    if (!isCreditCard) return this;
    return replaceAllMapped(
      RegExp(r'.(?=.{4})'),
      (match) => '*',
    );
  }

  String get formatPhoneNumber {
    if (!isPhoneNumber) return this;
    return replaceAllMapped(
      RegExp(r'(\+?\d{2})(\d{3})(\d{4})(\d+)'),
      (match) => '${match[1]}-${match[2]}-${match[3]}-${match[4]}',
    );
  }

  String get extractNumbers => 
      replaceAll(RegExp(r'[^0-9]'), '');

  String get extractLetters => 
      replaceAll(RegExp(r'[^a-zA-Z]'), '');

  String get extractAlphanumeric => 
      replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
} 