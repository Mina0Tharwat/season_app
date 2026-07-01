import 'package:dio/dio.dart';
import 'package:season_app/core/constants/api_endpoints.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<Response> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    required String password,
    required String passwordConfirmation,
    String? notificationToken,
  }) async {
    final data = <String, dynamic>{
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "fcm_token": notificationToken ?? "",
    };
    if (phone != null && phone.trim().isNotEmpty) {
      data["phone"] = phone.trim();
    }

    final response = await dio.post(
      ApiEndpoints.register,
      data: data,
    );

    return response;
  }

  Future<Response> loginUser({
    required String email,
    required String password,
    String? notificationToken,
  }) async {
    final data = {
      "email": email,
      "password": password,
      "fcm_token": notificationToken ?? "",
    };

    final response = await dio.post(
      ApiEndpoints.login,
      data: data,
    );

    return response;
  }

  Future<Response> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final data = {
      "email": email,
      "otp": otp,
    };

    final response = await dio.post(
      ApiEndpoints.verifyOtp,
      data: data,
    );

    return response;
  }

  Future<Response> resendOtp({
    required String email,
  }) async {
    final data = {
      "email": email,
    };

    final response = await dio.post(
      ApiEndpoints.resendOtp,
      data: data,
    );

    return response;
  }

  Future<Response> forgotPassword({
    required String email,
  }) async {
    final data = {
      "email": email,
    };

    final response = await dio.post(
      ApiEndpoints.forgotPassword,
      data: data,
    );

    return response;
  }

  Future<Response> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    final data = {
      "email": email,
      "otp": otp,
    };

    final response = await dio.post(
      ApiEndpoints.verifyResetOtp,
      data: data,
    );

    return response;
  }

  Future<Response> resendResetOtp({
    required String email,
  }) async {
    final data = {
      "email": email,
    };

    final response = await dio.post(
      ApiEndpoints.resendResetOtp,
      data: data,
    );

    return response;
  }

  Future<Response> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final data = {
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };

    final response = await dio.post(
      ApiEndpoints.resetPassword,
      data: data,
    );

    return response;
  }

  /// Login with Google
  Future<Response> loginWithGoogle({
    required String idToken,
    required String accessToken,
    String? notificationToken,
  }) async {
    final data = {
      "id_token": idToken,
      "access_token": accessToken,
      "fcm_token": notificationToken ?? "",
    };

    final response = await dio.post(
      ApiEndpoints.loginWithGoogle,
      data: data,
    );

    return response;
  }

  /// Register with Google
  Future<Response> registerWithGoogle({
    required String idToken,
    required String accessToken,
    String? notificationToken,
  }) async {
    final data = {
      "id_token": idToken,
      "access_token": accessToken,
      "fcm_token": notificationToken ?? "",
    };

    final response = await dio.post(
      ApiEndpoints.registerWithGoogle,
      data: data,
    );

    return response;
  }

  /// Login with Apple
  Future<Response> loginWithApple({
    required String idToken,
    String? authorizationCode,
    String? notificationToken,
  }) async {
    final data = {
      "id_token": idToken,
      if (authorizationCode != null) "authorization_code": authorizationCode,
      "fcm_token": notificationToken ?? "",
    };

    final response = await dio.post(
      ApiEndpoints.loginWithApple,
      data: data,
    );

    return response;
  }

  /// Register with Apple
  Future<Response> registerWithApple({
    required String idToken,
    String? authorizationCode,
    String? notificationToken,
  }) async {
    final data = {
      "id_token": idToken,
      if (authorizationCode != null) "authorization_code": authorizationCode,
      "fcm_token": notificationToken ?? "",
    };

    final response = await dio.post(
      ApiEndpoints.registerWithApple,
      data: data,
    );

    return response;
  }

  Future<Response> logoutUser() async {
    return dio.post(ApiEndpoints.logout);
  }

  Future<Response> updateFcmToken(String fcmToken) async {
    return dio.post(
      ApiEndpoints.authProfile,
      data: {'fcm_token': fcmToken, '_method': 'PUT'},
    );
  }
}
