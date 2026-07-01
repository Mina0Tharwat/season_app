import 'package:flutter_riverpod/legacy.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/features/auth/data/repositories/auth_repository.dart';

class SignupState {
  final bool isLoading;
  final String? error;
  final String? message;
  /// True after email signup (OTP required) or social signup without a token yet.
  final bool needsOtpVerification;

  SignupState({
    this.isLoading = false,
    this.error,
    this.message,
    this.needsOtpVerification = false,
  });

  SignupState copyWith({
    bool? isLoading,
    String? error,
    String? message,
    bool? needsOtpVerification,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      message: message,
      needsOtpVerification: needsOtpVerification ?? this.needsOtpVerification,
    );
  }
}

class SignupController extends StateNotifier<SignupState> {
  final AuthRepository repository;

  SignupController(this.repository) : super(SignupState());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    required String password,
    required String passwordConfirmation,
    String? notificationToken,
  }) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      message: null,
      needsOtpVerification: false,
    );

    try {
      final message = await repository.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
        notificationToken: notificationToken,
      );

      state = state.copyWith(
        isLoading: false,
        message: message,
        needsOtpVerification: !AuthService.isLoggedIn(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearMessage() {
    state = state.copyWith(message: null, needsOtpVerification: false);
  }

  /// Register with Google
  Future<void> registerWithGoogle({
    required String idToken,
    required String accessToken,
    String? notificationToken,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      message: null,
      needsOtpVerification: false,
    );

    try {
      final message = await repository.registerWithGoogle(
        idToken: idToken,
        accessToken: accessToken,
        notificationToken: notificationToken,
      );

      state = state.copyWith(
        isLoading: false,
        message: message,
        needsOtpVerification: !AuthService.isLoggedIn(),
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
    state = state.copyWith(
      isLoading: true,
      error: null,
      message: null,
      needsOtpVerification: false,
    );

    try {
      final message = await repository.registerWithApple(
        idToken: idToken,
        authorizationCode: authorizationCode,
        notificationToken: notificationToken,
      );

      state = state.copyWith(
        isLoading: false,
        message: message,
        needsOtpVerification: !AuthService.isLoggedIn(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
