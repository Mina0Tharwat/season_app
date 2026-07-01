import 'package:flutter/foundation.dart';
import 'package:season_app/core/constants/apple_oauth_config.dart';
import 'package:season_app/core/services/social_login_service.dart';
import 'package:season_app/core/utils/apple_id_token.dart';

/// Obtains Apple credentials and calls [apiCall]; surfaces backend config hints on failure.
class AppleLoginFlow {
  AppleLoginFlow._();

  static Future<T> run<T>({
    required Future<T> Function(Map<String, String?> appleData) apiCall,
  }) async {
    Object? lastError;
    String? lastAud;
    String? lastSub;

    try {
      final appleData = await SocialLoginService.signInWithApple();
      lastAud = AppleIdToken.parse(appleData['idToken'])?.audience;
      lastSub = AppleIdToken.parse(appleData['idToken'])?.subject;
      if (kDebugMode) {
        debugPrint(
          'Apple login: aud=$lastAud sub=$lastSub '
          'expected_aud=${AppleOAuthConfig.iosBundleId}',
        );
      }
      return await apiCall(appleData);
    } catch (e) {
      lastError = e;
    }

    throw Exception(_formatFailureMessage(lastError, lastAud));
  }

  static String _formatFailureMessage(Object? error, String? aud) {
    final raw = error?.toString().replaceAll('Exception: ', '') ?? 'Apple login failed';
    final lower = raw.toLowerCase();

    if (lower.contains('404:') || lower.contains('not found') || lower.contains('not registered')) {
      return raw;
    }

    if (_isAudienceMismatch(raw, aud)) {
      return 'تسجيل Apple فشل لأن السيرفر لا يطابق التوكن.\n\n'
          'على seasonksa.com ضع في .env:\n'
          'APPLE_CLIENT_ID=${aud ?? AppleOAuthConfig.iosBundleId}\n'
          'APPLE_TEAM_ID=${AppleOAuthConfig.teamId}\n'
          '(+ APPLE_KEY_ID و APPLE_PRIVATE_KEY من Apple Developer)\n'
          'ثم: php artisan config:clear';
    }

    if (lower.contains('failed to verify apple token') ||
        lower.contains('invalid token') ||
        lower.contains('invalid audience')) {
      return 'Apple login فشل على السيرفر.\n\n'
          'تأكد من Laravel:\n'
          '1. APPLE_CLIENT_ID=${AppleOAuthConfig.iosBundleId}\n'
          '2. التحقق من JWT بمفاتيح https://appleid.apple.com/auth/keys\n'
          '3. php artisan config:clear\n\n'
          'تفاصيل: $raw';
    }

    return raw;
  }

  static bool _isAudienceMismatch(String message, String? aud) {
    if (aud == null || aud.isEmpty) return false;
    final lower = message.toLowerCase();
    return lower.contains('audience') ||
        lower.contains('invalid client') ||
        lower.contains('client_id');
  }
}
