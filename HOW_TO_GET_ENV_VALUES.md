# How to Get Environment Variables for Social Login

This guide explains how to obtain all the required environment variables for Google and Apple Sign-In.

## Google Credentials

### 1. GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET

**Step-by-step:**

1. **Go to Google Cloud Console**
   - Visit: https://console.cloud.google.com/
   - Sign in with your Google account

2. **Create or Select a Project**
   - Click on the project dropdown at the top
   - Click "New Project" or select an existing project
   - Give it a name (e.g., "Season App")

3. **Enable Google Sign-In API**
   - Go to "APIs & Services" > "Library"
   - Search for "Google Sign-In API" or "Google+ API"
   - Click on it and press "Enable"

4. **Create OAuth 2.0 Credentials**
   - Go to "APIs & Services" > "Credentials"
   - Click "Create Credentials" > "OAuth client ID"
   - If prompted, configure the OAuth consent screen first:
     - Choose "External" (unless you have a Google Workspace)
     - Fill in required fields (App name, User support email, Developer contact)
     - Add scopes: `email`, `profile`, `openid`
     - Add test users if needed
     - Save and continue

5. **Create Web Application Credentials (for Backend)**
   - Application type: Select "Web application"
   - Name: "Season App Backend" (or any name)
   - Authorized redirect URIs: Add your backend URL (e.g., `https://your-api.com/auth/google/callback`)
   - Click "Create"
   - **Copy the Client ID** → This is your `GOOGLE_CLIENT_ID`
   - **Copy the Client Secret** → This is your `GOOGLE_CLIENT_SECRET`

6. **Create Android OAuth Client (if needed)**
   - Create another OAuth client ID
   - Application type: "Android"
   - Package name: `com.season.app.season_app`
   - SHA-1 certificate fingerprint: Get it using:
     ```bash
     keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
     ```
   - Add the SHA-1 to Google Cloud Console

7. **Create iOS OAuth Client (if needed)**
   - Create another OAuth client ID
   - Application type: "iOS"
   - Bundle ID: `com.season.app.season_app`

**Note:** For backend token verification, you typically only need the **Web Application** credentials (Client ID and Secret).

---

## Apple Credentials

### 2. APPLE_CLIENT_ID, APPLE_TEAM_ID, APPLE_KEY_ID, APPLE_PRIVATE_KEY

**Prerequisites:**
- An active Apple Developer account ($99/year)
- Access to Apple Developer Portal: https://developer.apple.com/

**Step-by-step:**

1. **Get Your Team ID (APPLE_TEAM_ID)**
   - Go to: https://developer.apple.com/account/
   - Sign in with your Apple Developer account
   - Click on "Membership" in the sidebar
   - Your **Team ID** is displayed at the top (e.g., `ABC123DEF4`)
   - Copy this → This is your `APPLE_TEAM_ID`

2. **Create an App ID**
   - Go to "Certificates, Identifiers & Profiles"
   - Click "Identifiers" > "+" button
   - Select "App IDs" > Continue
   - Select "App" > Continue
   - Description: "Season App"
   - Bundle ID: Select "Explicit" and enter `com.season.app.seasonApp`
   - Enable "Sign In with Apple" capability
   - Click "Continue" > "Register"

3. **Laravel `.env` — use Bundle ID (NOT Service ID for iOS app)**

   For native iOS Sign in with Apple, the JWT `aud` claim equals the **Bundle ID**:

   ```env
   APPLE_CLIENT_ID=com.season.app.seasonApp
   ```

   *(Service IDs are only for web Sign in with Apple — optional for this project.)*

4. **Create a Key (APPLE_KEY_ID and APPLE_PRIVATE_KEY)**
   - Go to "Keys" section
   - Click "+" button
   - Key Name: "Season App Sign In Key"
   - Enable "Sign In with Apple"
   - Click "Configure"
   - Select your Primary App ID
   - Click "Save" > "Continue" > "Register"
   - **Important:** Download the key file immediately (`.p8` file) - you can only download it once!
   - **Copy the Key ID** shown on the page → This is your `APPLE_KEY_ID`
   - Open the downloaded `.p8` file in a text editor
   - Copy the entire content (including `-----BEGIN PRIVATE KEY-----` and `-----END PRIVATE KEY-----`)
   - This is your `APPLE_PRIVATE_KEY`

**Note:** The private key should be stored as a single-line string in `.env` file. You can either:
- Keep it as multi-line (Laravel supports this)
- Or convert it to a single line by replacing newlines with `\n`

---

## Adding to .env File

Once you have all the values, add them to your `.env` file:

```env
# Google Credentials
GOOGLE_CLIENT_ID=your_google_client_id_here.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=your_google_client_secret_here

# Apple Credentials (iOS native — Bundle ID)
APPLE_CLIENT_ID=com.season.app.seasonApp
APPLE_TEAM_ID=GKQ3F4H77H
APPLE_KEY_ID=XYZ789ABC1
APPLE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nMIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQg...\n-----END PRIVATE KEY-----"
```

**Important Notes:**
- Never commit your `.env` file to version control
- Keep your credentials secure
- For production, use environment variables on your hosting platform
- The Apple private key can be stored as multi-line or single-line (with `\n`)

---

## Testing Your Credentials

### Google:
- Test by making a request to Google's tokeninfo endpoint with a valid ID token
- Or test through your backend endpoint once implemented

### Apple:
- Test by verifying an Apple ID token using Apple's public keys
- Or test through your backend endpoint once implemented

---

## Troubleshooting

### Google:
- **"Invalid client"**: Check that Client ID and Secret are correct
- **"Redirect URI mismatch"**: Ensure redirect URI in Google Console matches your app configuration
- **"API not enabled"**: Make sure Google Sign-In API is enabled in Google Cloud Console

### Apple:
- **"Invalid client_id"**: Verify the Service ID is correct and Sign In with Apple is enabled
- **"Invalid key"**: Ensure the private key is correctly formatted and matches the Key ID
- **"Team ID mismatch"**: Verify Team ID matches your Apple Developer account

---

## Additional Resources

- [Google OAuth 2.0 Setup](https://developers.google.com/identity/protocols/oauth2)
- [Apple Sign In Setup Guide](https://developer.apple.com/sign-in-with-apple/get-started/)
- [Apple Key Management](https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens)

