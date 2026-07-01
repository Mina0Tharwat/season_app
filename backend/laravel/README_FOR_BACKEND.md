# Season — Apple Sign-In Backend Handoff

**For Laravel team on `seasonksa.com`**

## What to deploy

| File in this repo | Copy to Laravel project |
|-------------------|-------------------------|
| `AppleAuthService.php` | `app/Services/AppleAuthService.php` |
| `AuthController_apple_methods.php` | Paste methods into `app/Http/Controllers/AuthController.php` |
| `apple-auth.env.example` | Add lines to server `.env` (see below) |

## `.env` on server (required)

```env
APPLE_CLIENT_ID=com.season.app.seasonApp
APPLE_TEAM_ID=GKQ3F4H77H
APPLE_KEY_ID=MA22G4DGC5
APPLE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----"
```

> **Important:** `APPLE_CLIENT_ID` = iOS **Bundle ID**, not Service ID.  
> The mobile app JWT `aud` claim is `com.season.app.seasonApp`.

**Private key:** Request `apple-auth.env.local` from the mobile team separately (do **not** commit `.p8` to Git).

## Server commands

```bash
composer require firebase/php-jwt
php artisan config:clear
php artisan cache:clear
```

## Routes (verify they exist)

```php
Route::post('/auth/login/apple', [AuthController::class, 'loginWithApple']);
Route::post('/auth/register/apple', [AuthController::class, 'registerWithApple']);
```

## Database (if missing)

```sql
ALTER TABLE users ADD COLUMN provider VARCHAR(255) NULL;
ALTER TABLE users ADD COLUMN provider_id VARCHAR(255) NULL;
```

## API contract (Flutter app)

**Login:** `POST /api/auth/login/apple`

```json
{
  "id_token": "Apple identity JWT",
  "authorization_code": "optional",
  "fcm_token": "optional"
}
```

- **200** → `{ "success": true, "data": { "token": "...", "user": {...} } }`
- **404** → user not found → app calls register automatically
- **400** → token verification failed (check `.env` + `AppleAuthService`)

**Register:** `POST /api/auth/register/apple` — same body, **201** on success.

## Test

```bash
curl -X POST https://seasonksa.com/api/auth/login/apple \
  -H "Content-Type: application/json" \
  -d '{"id_token":"test","fcm_token":""}'
```

Invalid token → 400 (endpoint exists).  
After real Apple login from app → 200 with token.

## Mobile app (already implemented)

- Sign in with Apple on iOS login/signup screens
- Phone number optional at registration (App Store 5.1.1)
- Version: see `pubspec.yaml`

Full details: `APPLE_LOGIN_BACKEND_SETUP.md`
