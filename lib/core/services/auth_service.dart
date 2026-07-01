import 'package:season_app/core/services/local_storage_service.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _emailVerifiedKey = 'email_verified';
  static const String _pendingVerificationEmailKey = 'pending_verification_email';

  // Save auth token
  static Future<void> saveToken(String token) async {
    await LocalStorageService.saveString(_tokenKey, token);
  }

  // Get auth token
  static String? getToken() {
    return LocalStorageService.getString(_tokenKey);
  }

  // Save user ID
  static Future<void> saveUserId(String userId) async {
    await LocalStorageService.saveString(_userIdKey, userId);
  }

  // Get user ID
  static String? getUserId() {
    return LocalStorageService.getString(_userIdKey);
  }

  // Save user email
  static Future<void> saveUserEmail(String email) async {
    await LocalStorageService.saveString(_userEmailKey, email);
  }

  // Get user email
  static String? getUserEmail() {
    return LocalStorageService.getString(_userEmailKey);
  }

  // Mark user as logged in
  static Future<void> setLoggedIn(bool isLoggedIn) async {
    await LocalStorageService.saveBool(_isLoggedInKey, isLoggedIn);
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return LocalStorageService.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> setEmailVerified(bool verified) async {
    await LocalStorageService.saveBool(_emailVerifiedKey, verified);
  }

  static bool isEmailVerified() {
    return LocalStorageService.getBool(_emailVerifiedKey) ?? false;
  }

  /// Email of an account that was created but still needs verification.
  /// Lets the user open the app and verify later (optional) from settings.
  static Future<void> setPendingVerificationEmail(String? email) async {
    if (email == null || email.isEmpty) {
      await LocalStorageService.remove(_pendingVerificationEmailKey);
    } else {
      await LocalStorageService.saveString(_pendingVerificationEmailKey, email);
    }
  }

  static String? getPendingVerificationEmail() {
    return LocalStorageService.getString(_pendingVerificationEmailKey);
  }

  static bool hasPendingVerification() {
    final email = getPendingVerificationEmail();
    return email != null && email.isNotEmpty;
  }

  // Save complete auth data
  static Future<void> saveAuthData({
    required String token,
    String? userId,
    String? email,
  }) async {
    await saveToken(token);
    if (userId != null) await saveUserId(userId);
    if (email != null) await saveUserEmail(email);
    await setLoggedIn(true);
  }

  // Logout and clear all auth data
  static Future<void> logout() async {
    await LocalStorageService.remove(_tokenKey);
    await LocalStorageService.remove(_userIdKey);
    await LocalStorageService.remove(_userEmailKey);
    await LocalStorageService.remove(_isLoggedInKey);
    await LocalStorageService.remove(_emailVerifiedKey);
    await LocalStorageService.remove(_pendingVerificationEmailKey);
  }

  // Clear all data (complete logout)
  static Future<void> clearAll() async {
    await LocalStorageService.clear();
  }
}

