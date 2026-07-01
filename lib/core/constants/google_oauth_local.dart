/// Local Google Web OAuth client ID (same value as backend `GOOGLE_CLIENT_ID`).
///
/// 1. Google Cloud Console → APIs & Services → Credentials
/// 2. Open your **Web application** OAuth client
/// 3. Paste the Client ID below (ends with `.apps.googleusercontent.com`)
///
/// Do not commit real secrets here if your repo is public — the client ID is
/// public in the app, but keep [GOOGLE_CLIENT_SECRET] only on the server.
/// Firebase Web client (matches `aud` on Android ID tokens from google-services.json).
const String kLocalGoogleWebClientId =
    '947193806162-a2brd7oi08orov298knjtn2ntc7o975d.apps.googleusercontent.com';

/// Alternate manual Web client — backend may use this instead; app retries if needed.
const String kAlternateGoogleWebClientId =
    '947193806162-nua0frbdtn89jipohvfn43bbbc8r86er.apps.googleusercontent.com';

/// iOS OAuth client ID from Firebase Console → iOS app → GoogleService-Info.plist
/// (`CLIENT_ID` key). Also add `REVERSED_CLIENT_ID` to `ios/Runner/Info.plist`.
/// Belongs to the same GCP project (season-80348) as the backend/Android.
const String kLocalGoogleIosClientId =
    '947193806162-lfu94ita3hfpv201cgvkdt8c95n1kufb.apps.googleusercontent.com';
