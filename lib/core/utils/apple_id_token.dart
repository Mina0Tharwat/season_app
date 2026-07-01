import 'dart:convert';

/// Parses Apple identity token JWT payload (no signature verification).
class AppleIdToken {
  AppleIdToken._(this.audience, this.email, this.subject, this.issuer);

  final String? audience;
  final String? email;
  final String? subject;
  final String? issuer;

  static AppleIdToken? parse(String? idToken) {
    if (idToken == null || idToken.isEmpty) return null;
    try {
      final parts = idToken.split('.');
      if (parts.length < 2) return null;
      final normalized = base64Url.normalize(parts[1]);
      final json =
          jsonDecode(utf8.decode(base64Url.decode(normalized))) as Map<String, dynamic>;
      return AppleIdToken._(
        json['aud']?.toString(),
        json['email']?.toString(),
        json['sub']?.toString(),
        json['iss']?.toString(),
      );
    } catch (_) {
      return null;
    }
  }
}
