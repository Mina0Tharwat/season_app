<?php

/**
 * Copy these methods into your Laravel AuthController.
 * Requires: AppleAuthService, AppleLoginRequest, User model with provider + provider_id.
 */

use App\Http\Requests\AppleLoginRequest;
use App\Models\User;
use App\Services\AppleAuthService;
use Exception;
use Illuminate\Support\Str;

public function loginWithApple(AppleLoginRequest $request, AppleAuthService $appleAuth)
{
    try {
        $appleUser = $appleAuth->verifyIdToken($request->id_token);

        $user = User::where('provider', 'apple')
            ->where('provider_id', $appleUser['id'])
            ->first();

        if (!$user && !empty($appleUser['email'])) {
            $user = User::where('email', $appleUser['email'])->first();
            if ($user) {
                $user->update([
                    'provider' => 'apple',
                    'provider_id' => $appleUser['id'],
                ]);
            }
        }

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found. Please register first.',
                'message_ar' => 'المستخدم غير موجود. يرجى التسجيل أولاً',
                'error' => 'User not registered',
            ], 404);
        }

        if ($request->fcm_token) {
            $user->update(['fcm_token' => $request->fcm_token]);
        }

        $token = auth()->login($user);

        return response()->json([
            'success' => true,
            'message' => 'Login successful',
            'message_ar' => 'تم تسجيل الدخول بنجاح',
            'data' => [
                'token' => $token,
                'user' => $user,
            ],
        ], 200);
    } catch (Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'Apple login failed',
            'message_ar' => 'فشل تسجيل الدخول عبر Apple',
            'error' => $e->getMessage(),
        ], 400);
    }
}

public function registerWithApple(AppleLoginRequest $request, AppleAuthService $appleAuth)
{
    try {
        $appleUser = $appleAuth->verifyIdToken($request->id_token);

        $existing = User::where('provider', 'apple')
            ->where('provider_id', $appleUser['id'])
            ->first();

        if ($existing) {
            $token = auth()->login($existing);
            return response()->json([
                'success' => true,
                'message' => 'Login successful',
                'data' => ['token' => $token, 'user' => $existing],
            ], 200);
        }

        if (!empty($appleUser['email'])) {
            $byEmail = User::where('email', $appleUser['email'])->first();
            if ($byEmail) {
                return response()->json([
                    'success' => false,
                    'message' => 'User already exists. Please login instead.',
                    'message_ar' => 'المستخدم موجود بالفعل. يرجى تسجيل الدخول',
                    'error' => 'User already registered',
                ], 400);
            }
        }

        $email = $appleUser['email'] ?? ('apple_' . $appleUser['id'] . '@privaterelay.season');

        $user = User::create([
            'email' => $email,
            'first_name' => 'Apple',
            'last_name' => 'User',
            'password' => bcrypt(Str::random(32)),
            'provider' => 'apple',
            'provider_id' => $appleUser['id'],
            'fcm_token' => $request->fcm_token,
            'email_verified_at' => now(),
        ]);

        $token = auth()->login($user);

        return response()->json([
            'success' => true,
            'message' => 'Registration successful',
            'message_ar' => 'تم التسجيل بنجاح',
            'data' => [
                'token' => $token,
                'user' => $user,
            ],
        ], 201);
    } catch (Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'Apple registration failed',
            'message_ar' => 'فشل التسجيل عبر Apple',
            'error' => $e->getMessage(),
        ], 400);
    }
}

// routes/api.php:
// Route::post('/auth/login/apple', [AuthController::class, 'loginWithApple']);
// Route::post('/auth/register/apple', [AuthController::class, 'registerWithApple']);

// config/services.php:
// 'apple' => [
//     'client_id' => env('APPLE_CLIENT_ID'), // com.season.app.seasonApp for iOS
//     'team_id' => env('APPLE_TEAM_ID'),
//     'key_id' => env('APPLE_KEY_ID'),
//     'private_key' => env('APPLE_PRIVATE_KEY'),
// ],
