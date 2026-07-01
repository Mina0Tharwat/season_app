class Validators {
  static String? email(String? value, {bool isArabic = true}) {
    if (value == null || value.isEmpty) {
      return isArabic ? 'البريد الإلكتروني مطلوب' : 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(value)) {
      return isArabic ? 'أدخل بريد إلكتروني صحيح' : 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? value, {bool isArabic = true}) {
    if (value == null || value.isEmpty) {
      return isArabic ? 'كلمة المرور مطلوبة' : 'Password is required';
    }
    if (value.length < 6) {
      return isArabic
          ? 'كلمة المرور لازم تكون على الأقل 6 أحرف'
          : 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? phone(String? value, {bool isArabic = true, String? countryCode, bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      return required ? (isArabic ? 'رقم الهاتف مطلوب' : 'Phone number is required') : null;
    }
    return null;
  }

  /// Phone is optional at signup; validate format only when provided.
  static String? optionalPhone(String? value, {bool isArabic = true, String? countryCode}) {
    return phone(value, isArabic: isArabic, countryCode: countryCode, required: false);
  }

  static String? notEmpty(String? value,
      {String? messageAr, String? messageEn, bool isArabic = true}) {
    if (value == null || value.trim().isEmpty) {
      return isArabic
          ? (messageAr ?? 'هذا الحقل مطلوب')
          : (messageEn ?? 'This field is required');
    }
    return null;
  }
}
