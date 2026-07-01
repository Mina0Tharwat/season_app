# Apple Login — Backend Setup (seasonksa.com)

The Flutter app is ready. Apple login fails when **Laravel cannot verify the Apple JWT**.

## Quick fix (most common)

On the server `.env`, set:

```env
APPLE_CLIENT_ID=com.season.app.seasonApp
APPLE_TEAM_ID=GKQ3F4H77H
APPLE_KEY_ID=<from Apple Developer → Keys>
APPLE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----"
```

Then:

```bash
composer require firebase/php-jwt
php artisan config:clear
php artisan cache:clear
```

**Important:** `APPLE_CLIENT_ID` must be the **iOS Bundle ID**, not a Service ID.

---

## Files in this repo (copy to Laravel)

| File | Copy to |
|------|---------|
| `backend/laravel/AppleAuthService.php` | `app/Services/AppleAuthService.php` |
| `backend/laravel/AuthController_apple_methods.php` | methods into `AuthController.php` |
| `backend/laravel/apple-auth.env.example` | reference for `.env` |

---

## Apple Developer Portal (you must do this)

1. Go to https://developer.apple.com/account/
2. **Identifiers** → App ID `com.season.app.seasonApp`
3. Enable **Sign In with Apple**
4. **Keys** → Create key with **Sign In with Apple** → download `.p8` once
5. Copy **Key ID** → `APPLE_KEY_ID`
6. Copy `.p8` content → `APPLE_PRIVATE_KEY`

Team ID: **GKQ3F4H77H** (Mohannad Al Shawaf)

---

## Database migration (if missing)

```php
Schema::table('users', function (Blueprint $table) {
    $table->string('provider')->nullable();
    $table->string('provider_id')->nullable();
});
```

---

## Test with curl

After a real Apple login from the app, copy `identityToken` from debug logs and run:

```bash
curl -X POST https://seasonksa.com/api/auth/login/apple \
  -H "Content-Type: application/json" \
  -d '{"id_token":"PASTE_REAL_TOKEN","fcm_token":""}'
```

Expected: `200` with `data.token`.  
If `Invalid audience` → wrong `APPLE_CLIENT_ID` in `.env`.

---

## App side (already done)

- Sign in with Apple entitlement: `ios/Runner/Runner.entitlements`
- Apple + Google buttons on login/signup
- Sends `POST /api/auth/login/apple` then `/register/apple` on 404
- Debug logs show `aud=` vs expected `com.season.app.seasonApp`
