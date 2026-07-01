import 'package:flutter_riverpod/legacy.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/features/auth/data/repositories/auth_repository.dart';

class LoginState {
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isLoggedIn;

  LoginState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isLoggedIn = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    String? message,
    bool? isLoggedIn,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      message: message,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class LoginController extends StateNotifier<LoginState> {
  final AuthRepository repository;

  LoginController(this.repository) : super(LoginState());

  Future<void> login({
    required String email,
    required String password,
    String? notificationToken,
  }) async {
    state = state.copyWith(isLoading: true, error: null, message: null);

    try {
      final message = await repository.login(
        email: email,
        password: password,
        notificationToken: notificationToken,
      );

      state = state.copyWith(
        isLoading: false, 
        message: message, 
        isLoggedIn: true
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearMessage() {
    state = state.copyWith(message: null);
  }

  void startSocialLogin() {
    state = state.copyWith(isLoading: true, error: null, message: null);
  }

  void completeSocialLogin(String message) {
    state = state.copyWith(
      isLoading: false,
      error: null,
      message: message,
      isLoggedIn: AuthService.isLoggedIn(),
    );
  }

  void failSocialLogin(String error) {
    state = state.copyWith(isLoading: false, error: error, isLoggedIn: false);
  }

  /// Reset loading/error without surfacing a message (e.g. user cancelled).
  void cancelSocialLogin() {
    state = state.copyWith(isLoading: false, error: null, message: null);
  }

  /// Login with Google
  Future<void> loginWithGoogle({
    required String idToken,
    required String accessToken,
    String? notificationToken,
  }) async {
    state = state.copyWith(isLoading: true, error: null, message: null);

    try {
      final message = await repository.loginWithGoogle(
        idToken: idToken,
        accessToken: accessToken,
        notificationToken: notificationToken,
      );

      state = state.copyWith(
        isLoading: false,
        message: message,
        isLoggedIn: true,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Register with Google
  Future<void> registerWithGoogle({
    required String idToken,
    required String accessToken,
    String? notificationToken,
  }) async {
    state = state.copyWith(isLoading: true, error: null, message: null);

    try {
      final message = await repository.registerWithGoogle(
        idToken: idToken,
        accessToken: accessToken,
        notificationToken: notificationToken,
      );

      state = state.copyWith(
        isLoading: false,
        message: message,
        isLoggedIn: true, // Set to true if directly logged in, false if OTP needed
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Login with Apple
  Future<void> loginWithApple({
    required String idToken,
    String? authorizationCode,
    String? notificationToken,
  }) async {
    state = state.copyWith(isLoading: true, error: null, message: null);

    try {
      final message = await repository.loginWithApple(
        idToken: idToken,
        authorizationCode: authorizationCode,
        notificationToken: notificationToken,
      );

      state = state.copyWith(
        isLoading: false,
        message: message,
        isLoggedIn: true,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Register with Apple
  Future<void> registerWithApple({
    required String idToken,
    String? authorizationCode,
    String? notificationToken,
  }) async {
    state = state.copyWith(isLoading: true, error: null, message: null);

    try {
      final message = await repository.registerWithApple(
        idToken: idToken,
        authorizationCode: authorizationCode,
        notificationToken: notificationToken,
      );

      state = state.copyWith(
        isLoading: false,
        message: message,
        isLoggedIn: true, // Set to true if directly logged in, false if OTP needed
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
