<?php

namespace App\Services;

use Exception;
use Firebase\JWT\JWK;
use Firebase\JWT\JWT;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;

/**
 * Verify Apple identity tokens from the iOS app.
 *
 * Install: composer require firebase/php-jwt
 *
 * .env (native iOS — use Bundle ID, NOT Service ID):
 *   APPLE_CLIENT_ID=com.season.app.seasonApp
 *   APPLE_TEAM_ID=GKQ3F4H77H
 *   APPLE_KEY_ID=...
 *   APPLE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----"
 */
class AppleAuthService
{
    public function verifyIdToken(string $idToken): array
    {
        $keys = Cache::remember('apple_auth_keys', 3600, function () {
            $response = Http::get('https://appleid.apple.com/auth/keys');
            if (!$response->successful()) {
                throw new Exception('Unable to fetch Apple public keys');
            }
            return $response->json();
        });

        try {
            $decoded = JWT::decode($idToken, JWK::parseKeySet($keys));
        } catch (Exception $e) {
            throw new Exception('Failed to verify Apple token: ' . $e->getMessage());
        }

        $payload = (array) $decoded;
        $expectedAud = config('services.apple.client_id');

        if (empty($expectedAud)) {
            throw new Exception('APPLE_CLIENT_ID is not configured on the server');
        }

        if (($payload['aud'] ?? null) !== $expectedAud) {
            throw new Exception(
                'Invalid audience. Token aud=' . ($payload['aud'] ?? 'null') .
                ' but server expects ' . $expectedAud
            );
        }

        if (($payload['iss'] ?? null) !== 'https://appleid.apple.com') {
            throw new Exception('Invalid Apple token issuer');
        }

        return [
            'id' => $payload['sub'],
            'email' => $payload['email'] ?? null,
            'email_verified' => filter_var($payload['email_verified'] ?? false, FILTER_VALIDATE_BOOLEAN),
        ];
    }
}
