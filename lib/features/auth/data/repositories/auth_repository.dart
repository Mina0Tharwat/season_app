import 'package:dio/dio.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/core/services/dio_client.dart';
import 'package:season_app/core/services/background_location_service.dart';
import 'package:season_app/core/services/notification_service.dart';
import 'package:season_app/features/auth/data/datasources/auth_datasource.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository(this.remoteDataSource);

  Future<String> register({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    required String password,
    required String passwordConfirmation,
    String? notificationToken,
  }) async {
    try {
      final response = await remoteDataSource.registerUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
        notificationToken: notificationToken,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final tokenSaved = await _persistSessionFromAuthResponse(
          response.data,
          fallbackEmail: email,
        );

        if (tokenSaved) {
          await AuthService.setEmailVerified(
            _isEmailVerifiedInResponse(response.data),
          );
        } else {
          // OTP required to activate the account — save email for verify screen.
          await AuthService.saveUserEmail(email);
          await AuthService.setEmailVerified(false);
        }

        return _asMap(response.data)?["message"]?.toString() ??
            "OTP sent successfully.";
      } else {
        throw Exception(
          _asMap(response.data)?["message"]?.toString() ?? "Registration failed",
        );
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;
      if (status == 400 || status == 409 || status == 422) {
        final message = data is Map
            ? data['message']?.toString()
            : null;
        throw Exception(message ?? 'حدث خطأ غير متوقع');
      }
      throw Exception('حدث خطأ أثناء التسجيل');
    }
  }

  Future<String> login({
    required String email,
    required String password,
    String? notificationToken,
  }) async {
    try {
      final response = await remoteDataSource.loginUser(
        email: email,
        password: password,
        notificationToken: notificationToken,
      );

      // Debug: Print the response structure
      print('🔍 Login Response: ${response.data}');
      
      if (response.statusCode == 200) {
        // Debug: Print the response structure
        print('🔍 Login Response: ${response.data}');
        
        await _persistSessionFromAuthResponse(
          response.data,
          fallbackEmail: email,
        );
        await AuthService.setEmailVerified(
          _isEmailVerifiedInResponse(response.data),
        );
        
        return response.data["message"] ?? "Login successful.";
      } else {
        throw Exception(response.data["message"] ?? "Login failed");
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;

      // Some backends return a token with 400/403 when email is not verified yet.
      if (status == 400 || status == 403) {
        if (data is Map) {
          final saved = await _persistSessionFromAuthResponse(
            data,
            fallbackEmail: email,
          );
          if (saved) {
            await AuthService.setEmailVerified(_isEmailVerifiedInResponse(data));
            await AuthService.setPendingVerificationEmail(null);
            final message = _asMap(data)?['message']?.toString();
            return message ?? 'Login successful.';
          }
        }
      }

      if (status == 401) {
        final message = e.response?.data['message'] ?? 'Invalid credentials';
        throw Exception(message);
      } else if (status == 400 || status == 403) {
        final message = e.response?.data['message'] ?? 'حدث خطأ غير متوقع';
        throw Exception(message);
      } else {
        throw Exception('حدث خطأ أثناء تسجيل الدخول');
      }
    }
  }

  Future<String> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await remoteDataSource.verifyOtp(
        email: email,
        otp: otp,
      );

      // Debug: Print the response structure
      print('🔍 OTP Verification Response: ${response.data}');
      
      if (response.statusCode == 200) {
        // Debug: Print the response structure
        print('🔍 OTP Verification Response: ${response.data}');
        
        final hadToken = await _persistSessionFromAuthResponse(
          response.data,
          fallbackEmail: email,
          startLocationTracking: !AuthService.isLoggedIn(),
        );
        await AuthService.setEmailVerified(true);
        await AuthService.setPendingVerificationEmail(null);

        if (!hadToken && AuthService.isLoggedIn()) {
          print('✅ Email verified for existing session');
        } else if (!hadToken) {
          print('⚠️ No token found in OTP verification response');
        }
        
        return response.data["message"] ?? "OTP verified successfully.";
      } else {
        throw Exception(response.data["message"] ?? "OTP verification failed");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? 'Invalid OTP';
        throw Exception(message);
      } else {
        throw Exception('حدث خطأ أثناء التحقق من الرمز');
      }
    }
  }

  Future<String> resendOtp({
    required String email,
  }) async {
    try {
      final response = await remoteDataSource.resendOtp(
        email: email,
      );

      if (response.statusCode == 200) {
        return response.data["message"] ?? "OTP resent successfully.";
      } else {
        throw Exception(response.data["message"] ?? "Failed to resend OTP");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? 'حدث خطأ غير متوقع';
        throw Exception(message);
      } else {
        throw Exception('حدث خطأ أثناء إعادة إرسال الرمز');
      }
    }
  }

  Future<String> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await remoteDataSource.forgotPassword(
        email: email,
      );

      if (response.statusCode == 200) {
        return response.data["message"] ?? "Reset OTP sent successfully.";
      } else {
        throw Exception(response.data["message"] ?? "Failed to send reset OTP");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? 'حدث خطأ غير متوقع';
        throw Exception(message);
      } else {
        throw Exception('حدث خطأ أثناء إرسال رمز إعادة تعيين كلمة المرور');
      }
    }
  }

  Future<String> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await remoteDataSource.verifyResetOtp(
        email: email,
        otp: otp,
      );

      if (response.statusCode == 200) {
        return response.data["message"] ?? "Reset OTP verified successfully.";
      } else {
        throw Exception(response.data["message"] ?? "Reset OTP verification failed");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? 'Invalid reset OTP';
        throw Exception(message);
      } else {
        throw Exception('حدث خطأ أثناء التحقق من رمز إعادة تعيين كلمة المرور');
      }
    }
  }

  Future<String> resendResetOtp({
    required String email,
  }) async {
    try {
      final response = await remoteDataSource.resendResetOtp(
        email: email,
      );

      if (response.statusCode == 200) {
        return response.data["message"] ?? "Reset OTP resent successfully.";
      } else {
        throw Exception(response.data["message"] ?? "Failed to resend reset OTP");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? 'حدث خطأ غير متوقع';
        throw Exception(message);
      } else {
        throw Exception('حدث خطأ أثناء إعادة إرسال رمز إعادة تعيين كلمة المرور');
      }
    }
  }

  Future<String> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await remoteDataSource.resetPassword(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      if (response.statusCode == 200) {
        return response.data["message"] ?? "Password reset successfully.";
      } else {
        throw Exception(response.data["message"] ?? "Password reset failed");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? 'حدث خطأ غير متوقع';
        throw Exception(message);
      } else {
        throw Exception('حدث خطأ أثناء إعادة تعيين كلمة المرور');
      }
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await remoteDataSource.logoutUser();
    } catch (_) {
      // Continue local cleanup even if API logout fails
    }
    await NotificationService().clearPushRegistration();
    await AuthService.logout();
    DioHelper.instance.clearTokens();
  }

  /// Login with Google
  Future<String> loginWithGoogle({
    required String idToken,
    required String accessToken,
    String? notificationToken,
  }) async {
    try {
      final response = await remoteDataSource.loginWithGoogle(
        idToken: idToken,
        accessToken: accessToken,
        notificationToken: notificationToken,
      );

      if (response.statusCode == 200) {
        // Extract token and user data
        dynamic token;
        dynamic userId;
        String? email;

        if (response.data is Map) {
          token = response.data['data']?['token'] ??
              response.data['token'] ??
              response.data['data']?['access_token'] ??
              response.data['access_token'];

          userId = response.data['data']?['user']?['id']?.toString() ??
              response.data['user']?['id']?.toString() ??
              response.data['data']?['userInfo']?['id']?.toString() ??
              response.data['userInfo']?['id']?.toString();

          email = response.data['data']?['user']?['email'] ??
              response.data['user']?['email'] ??
              response.data['data']?['userInfo']?['email'] ??
              response.data['userInfo']?['email'];
        }

        if (token != null && token.toString().isNotEmpty) {
          await AuthService.saveAuthData(
            token: token.toString(),
            userId: userId,
            email: email,
          );

          DioHelper.instance.setAccessToken(token.toString());

          try {
            await startBackgroundLocationTracking();
          } catch (e) {
            print('⚠️ Error starting background location tracking: $e');
          }
        }

        return response.data["message"] ?? "Login successful.";
      } else {
        throw Exception(response.data["message"] ?? "Google login failed");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // User not found - this is expected for new users
        final message = e.response?.data['message'] ?? 'User not found. Please register first.';
        throw Exception('404: $message'); // Prefix with 404 for easier detection
      } else if (e.response?.statusCode == 401) {
        final message = e.response?.data['message'] ?? 'Invalid Google credentials';
        throw Exception(message);
      } else if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? 'Google login failed';
        throw Exception(message);
      } else {
        throw Exception('حدث خطأ أثناء تسجيل الدخول باستخدام Google');
      }
    }
  }

  /// Register with Google
  Future<String> registerWithGoogle({
    required String idToken,
    required String accessToken,
    String? notificationToken,
  }) async {
    try {
      final response = await remoteDataSource.registerWithGoogle(
        idToken: idToken,
        accessToken: accessToken,
        notificationToken: notificationToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check if user needs OTP verification or is directly logged in
        dynamic token;
        dynamic userId;
        String? email;

        if (response.data is Map) {
          token = response.data['data']?['token'] ??
              response.data['token'] ??
              response.data['data']?['access_token'] ??
              response.data['access_token'];

          userId = response.data['data']?['user']?['id']?.toString() ??
              response.data['user']?['id']?.toString() ??
              response.data['data']?['userInfo']?['id']?.toString() ??
              response.data['userInfo']?['id']?.toString();

          email = response.data['data']?['user']?['email'] ??
              response.data['user']?['email'] ??
              response.data['data']?['userInfo']?['email'] ??
              response.data['userInfo']?['email'];
        }

        // If token exists, user is logged in directly
        if (token != null && token.toString().isNotEmpty) {
          await AuthService.saveAuthData(
            token: token.toString(),
            userId: userId,
            email: email,
          );

          DioHelper.instance.setAccessToken(token.toString());

          try {
            await startBackgroundLocationTracking();
          } catch (e) {
            print('⚠️ Error starting background location tracking: $e');
          }

          return response.data["message"] ?? "Registration successful.";
        }

        if (email != null && email.isNotEmpty) {
          await AuthService.saveUserEmail(email);
          await AuthService.setEmailVerified(false);
        }
        return response.data["message"] ?? "OTP sent successfully.";
      } else {
        throw Exception(response.data["message"] ?? "Google registration failed");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? 'Google registration failed';
        throw Exception(message);
      } else {
        throw Exception('حدث خطأ أثناء التسجيل باستخدام Google');
      }
    }
  }

  /// Login with Apple
  Future<String> loginWithApple({
    required String idToken,
    String? authorizationCode,
    String? notificationToken,
  }) async {
    try {
      final response = await remoteDataSource.loginWithApple(
        idToken: idToken,
        authorizationCode: authorizationCode,
        notificationToken: notificationToken,
      );

      if (response.statusCode == 200) {
        // Extract token and user data
        dynamic token;
        dynamic userId;
        String? email;

        if (response.data is Map) {
          token = response.data['data']?['token'] ??
              response.data['token'] ??
              response.data['data']?['access_token'] ??
              response.data['access_token'];

          userId = response.data['data']?['user']?['id']?.toString() ??
              response.data['user']?['id']?.toString() ??
              response.data['data']?['userInfo']?['id']?.toString() ??
              response.data['userInfo']?['id']?.toString();

          email = response.data['data']?['user']?['email'] ??
              response.data['user']?['email'] ??
              response.data['data']?['userInfo']?['email'] ??
              response.data['userInfo']?['email'];
        }

        if (token != null && token.toString().isNotEmpty) {
          await AuthService.saveAuthData(
            token: token.toString(),
            userId: userId,
            email: email,
          );

          DioHelper.instance.setAccessToken(token.toString());

          try {
            await startBackgroundLocationTracking();
          } catch (e) {
            print('⚠️ Error starting background location tracking: $e');
          }
        }

        return response.data["message"] ?? "Login successful.";
      } else {
        throw Exception(response.data["message"] ?? "Apple login failed");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        // User not found - this is expected for new users
        final message = e.response?.data['message'] ?? 'User not found. Please register first.';
        throw Exception('404: $message'); // Prefix with 404 for easier detection
      } else if (e.response?.statusCode == 401) {
        final message = e.response?.data['message'] ?? 'Invalid Apple credentials';
        throw Exception(message);
      } else if (e.response?.statusCode == 400) {
        final data = e.response?.data;
        final message = data is Map
            ? (data['error'] ?? data['message'] ?? 'Apple login failed')
            : 'Apple login failed';
        throw Exception(message.toString());
      } else {
        throw Exception('حدث خطأ أثناء تسجيل الدخول باستخدام Apple');
      }
    }
  }

  /// Register with Apple
  Future<String> registerWithApple({
    required String idToken,
    String? authorizationCode,
    String? notificationToken,
  }) async {
    try {
      final response = await remoteDataSource.registerWithApple(
        idToken: idToken,
        authorizationCode: authorizationCode,
        notificationToken: notificationToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check if user needs OTP verification or is directly logged in
        dynamic token;
        dynamic userId;
        String? email;

        if (response.data is Map) {
          token = response.data['data']?['token'] ??
              response.data['token'] ??
              response.data['data']?['access_token'] ??
              response.data['access_token'];

          userId = response.data['data']?['user']?['id']?.toString() ??
              response.data['user']?['id']?.toString() ??
              response.data['data']?['userInfo']?['id']?.toString() ??
              response.data['userInfo']?['id']?.toString();

          email = response.data['data']?['user']?['email'] ??
              response.data['user']?['email'] ??
              response.data['data']?['userInfo']?['email'] ??
              response.data['userInfo']?['email'];
        }

        // If token exists, user is logged in directly
        if (token != null && token.toString().isNotEmpty) {
          await AuthService.saveAuthData(
            token: token.toString(),
            userId: userId,
            email: email,
          );

          DioHelper.instance.setAccessToken(token.toString());

          try {
            await startBackgroundLocationTracking();
          } catch (e) {
            print('⚠️ Error starting background location tracking: $e');
          }

          return response.data["message"] ?? "Registration successful.";
        } else {
          // User needs OTP verification
          return response.data["message"] ?? "OTP sent successfully.";
        }
      } else {
        throw Exception(response.data["message"] ?? "Apple registration failed");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final data = e.response?.data;
        final message = data is Map
            ? (data['error'] ?? data['message'] ?? 'Apple registration failed')
            : 'Apple registration failed';
        throw Exception(message.toString());
      } else {
        throw Exception('حدث خطأ أثناء التسجيل باستخدام Apple');
      }
    }
  }

  Future<bool> _persistSessionFromAuthResponse(
    dynamic data, {
    String? fallbackEmail,
    bool startLocationTracking = true,
  }) async {
    final root = _asMap(data);
    if (root == null) return false;

    final inner = _asMap(root['data']);

    dynamic token = inner?['token'] ??
        root['token'] ??
        inner?['access_token'] ??
        root['access_token'];

    final userMap = _asMap(inner?['user']) ??
        _asMap(root['user']) ??
        _asMap(inner?['userInfo']) ??
        _asMap(root['userInfo']);

    final userId = userMap?['id']?.toString();
    final email = userMap?['email']?.toString() ?? fallbackEmail;

    if (token == null || token.toString().isEmpty) {
      return false;
    }

    await AuthService.saveAuthData(
      token: token.toString(),
      userId: userId,
      email: email,
    );
    DioHelper.instance.setAccessToken(token.toString());

    if (startLocationTracking) {
      try {
        await startBackgroundLocationTracking();
      } catch (e) {
        print('⚠️ Error starting background location tracking: $e');
      }
    }

    return true;
  }

  bool _isEmailVerifiedInResponse(dynamic data) {
    final root = _asMap(data);
    if (root == null) return false;

    final user = _extractUserMap(root);
    if (user != null) {
      if (_looksVerified(user['email_verified_at'])) return true;
      if (user['is_email_verified'] == true || user['email_verified'] == true) {
        return true;
      }
    }

    if (_looksVerified(root['email_verified_at'])) return true;

    return false;
  }

  bool _looksVerified(dynamic value) {
    return value != null &&
        value.toString().isNotEmpty &&
        value.toString().toLowerCase() != 'null';
  }

  Map<String, dynamic>? _extractUserMap(Map data) {
    final nested = _asMap(data['data']);
    final user = _asMap(nested?['user']) ??
        _asMap(nested?['userInfo']) ??
        _asMap(data['user']) ??
        _asMap(data['userInfo']);
    return user;
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }
}
