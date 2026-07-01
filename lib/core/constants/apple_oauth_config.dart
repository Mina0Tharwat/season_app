/// Apple Sign-In values for iOS native app (must match Apple Developer + Laravel `.env`).
class AppleOAuthConfig {
  AppleOAuthConfig._();

  /// iOS Bundle ID — JWT `aud` claim from Apple identity tokens uses this value.
  /// Backend `APPLE_CLIENT_ID` must equal this (NOT the Service ID).
  static const String iosBundleId = 'com.season.app.seasonApp';

  /// Apple Developer Team ID (Mohannad Al Shawaf).
  static const String teamId = 'GKQ3F4H77H';

  static const String apiLoginPath = '/auth/login/apple';
  static const String apiRegisterPath = '/auth/register/apple';
}
