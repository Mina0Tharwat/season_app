import 'package:season_app/core/constants/google_oauth_local.dart';

/// Web OAuth 2.0 client ID — must match the backend `GOOGLE_CLIENT_ID` used to
/// verify ID tokens (the "Web application" client in Google Cloud Console).
///
/// Set via (first match wins):
/// 1. `--dart-define=GOOGLE_SERVER_CLIENT_ID=...`
/// 2. [kLocalGoogleWebClientId] in `google_oauth_local.dart`
/// 3. `flutter run --dart-define-from-file=dart_defines.json` (copy from `.example`)
class GoogleOAuthConfig {
  GoogleOAuthConfig._();

  /// Laravel `.env` / manual Web client (user-provided).
  static const String serverClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue: kLocalGoogleWebClientId,
  );

  /// Firebase-generated Web client (from `google-services.json` type 3).
  static const String firebaseWebClientId =
      '947193806162-a2brd7oi08orov298knjtn2ntc7o975d.apps.googleusercontent.com';

  /// Alternate Web client (manual GCP credential).
  static const String alternateWebClientId = kAlternateGoogleWebClientId;

  /// iOS native OAuth client (`CLIENT_ID` in GoogleService-Info.plist).
  static const String iosClientId = String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
    defaultValue: kLocalGoogleIosClientId,
  );

  /// Reversed URL scheme for iOS Google Sign-In redirect (from REVERSED_CLIENT_ID).
  static String? get iosReversedClientId {
    if (iosClientId.isEmpty) return null;
    final prefix = iosClientId.replaceAll('.apps.googleusercontent.com', '');
    return 'com.googleusercontent.apps.$prefix';
  }

  static bool get isIosGoogleConfigured => iosClientId.isNotEmpty;

  /// Clients to try when backend rejects the token (Firebase first — matches Android `aud`).
  static List<String> get webClientIdsToTry {
    final primary = serverClientId.isEmpty ? firebaseWebClientId : serverClientId;
    if (primary == alternateWebClientId) return [primary];
    if (primary == firebaseWebClientId) {
      return [firebaseWebClientId, alternateWebClientId];
    }
    return [primary, firebaseWebClientId, alternateWebClientId];
  }

  static bool get isConfigured => serverClientId.isNotEmpty || firebaseWebClientId.isNotEmpty;
}
