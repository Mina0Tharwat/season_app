import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:season_app/core/constants/app_assets.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/router/routes.dart';
import 'package:season_app/core/services/app_state_service.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/core/services/notification_service.dart';
import 'package:season_app/core/services/apple_login_flow.dart';
import 'package:season_app/core/services/google_login_flow.dart';
import 'package:season_app/core/services/social_login_service.dart';
import 'package:season_app/core/utils/validators.dart';
import 'package:season_app/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:season_app/features/auth/providers.dart';
import 'package:season_app/shared/helpers/snackbar_helper.dart';
import 'package:season_app/shared/providers/locale_provider.dart';
import 'package:season_app/shared/widgets/custom_button.dart';
import 'package:season_app/shared/widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    
    // Clear any previous errors when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginControllerProvider.notifier).clearError();
      ref.read(loginControllerProvider.notifier).clearMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    log(ref.watch(localeProvider).languageCode);
    final formKey = GlobalKey<FormState>();
    final emailController = ref.watch(loginEmailControllerProvider);
    final passwordController = ref.watch(loginPasswordControllerProvider);
    final loginState = ref.watch(loginControllerProvider);
    
    // Listen to login state changes
    ref.listen(loginControllerProvider, (previous, next) async {
      if (next.isLoading) return;

      if (next.error != null && next.error != previous?.error) {
        SnackbarHelper.error(context, next.error.toString().replaceAll('Exception: ', ''));
        ref.read(loginControllerProvider.notifier).clearError();
        return;
      }

      if (next.message == null || next.message == previous?.message) return;

      if (next.isLoggedIn) {
        SnackbarHelper.success(context, next.message.toString());
        
        // Refresh all user-specific data that may have loaded as a guest.
        AppStateService.refreshUserDataAfterLogin(ref);
        
        try {
          await NotificationService().onUserLoggedIn(
            userId: AuthService.getUserId(),
          );
        } catch (e) {
          debugPrint('Error setting up push notifications: $e');
        }
        
        ref.read(loginControllerProvider.notifier).clearMessage();
        if (context.mounted) {
          context.go(Routes.home);
        }
        return;
      }

      SnackbarHelper.info(context, next.message.toString());
      ref.read(loginControllerProvider.notifier).clearMessage();
      if (context.mounted) {
        context.push(Routes.verifyOtp);
      }
    });

    void handleBack() {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(Routes.home);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: handleBack,
              ),
            ),
            Expanded(
              child: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                  Image.asset(AppAssets.seasonAuthImage, height: 80),
                  const SizedBox(height: 10),
                  Text(
                    tr.login,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    tr.welcomeLogin,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email
                      
                        CustomTextField(
                          hintText: tr.email,
                          keyboardType: TextInputType.emailAddress,
                          textDirection: TextDirection.ltr,
                          controller: emailController,
                          onChanged: (val) => ref.read(loginEmailProvider.notifier).state = val,
                          validator: (value) => Validators.email(value, isArabic: isArabic),
                        ),
                        const SizedBox(height: 10),
                        // Password
                      
                        CustomTextField(
                          hintText: tr.password,
                          obscureText: ref.watch(passwordVisibilityProvider),
                          textDirection: TextDirection.ltr,
                          controller: passwordController,
                          onChanged: (val) => ref.read(loginPasswordProvider.notifier).state = val,
                          validator: (value) => Validators.password(value, isArabic: isArabic),
                          suffixIcon: IconButton(
                            icon: Icon(
                              ref.watch(passwordVisibilityProvider)
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              ref.read(passwordVisibilityProvider.notifier).state =
                              !ref.read(passwordVisibilityProvider.notifier).state;
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            context.push(Routes.forgotPassword);
                          },
                          child: Text(
                            tr.forgetPassword,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          isLoading: loginState.isLoading,
                          text: tr.login,
                          color: AppColors.primary,
                          onPressed: loginState.isLoading ? null : () async {
                            if (formKey.currentState!.validate()) {
                              // Get FCM token
                              final fcmToken = await NotificationService().getTokenForAuth();
                              
                              await ref.read(loginControllerProvider.notifier).login(
                                email: ref.watch(loginEmailProvider),
                                password: ref.watch(loginPasswordProvider),
                                notificationToken: fcmToken,
                              );
                              // The listener will handle navigation
                            }
                          },
                        ),
                        SocialLoginButtons(
                          onGooglePressed: () async {
                            ref.read(loginControllerProvider.notifier).startSocialLogin();
                            try {
                              final fcmToken = await NotificationService().getTokenForAuth();
                              String? signedInEmail;
                              final message = await GoogleLoginFlow.run(apiCall: (googleData) async {
                                signedInEmail = googleData['email'];
                                final idToken = googleData['idToken'];
                                if (idToken == null || idToken.isEmpty) {
                                  throw Exception('Failed to get Google credentials');
                                }
                                final repo = ref.read(authRepositoryProvider);
                                try {
                                  return await repo.loginWithGoogle(
                                    idToken: idToken,
                                    accessToken: googleData['accessToken'] ?? '',
                                    notificationToken: fcmToken,
                                  );
                                } catch (e) {
                                  final errorMessage = e.toString();
                                  if (errorMessage.contains('404:') ||
                                      errorMessage.toLowerCase().contains('not found') ||
                                      errorMessage.toLowerCase().contains('not registered')) {
                                    return repo.registerWithGoogle(
                                      idToken: idToken,
                                      accessToken: googleData['accessToken'] ?? '',
                                      notificationToken: fcmToken,
                                    );
                                  }
                                  rethrow;
                                }
                              });
                              if (signedInEmail != null && signedInEmail!.isNotEmpty) {
                                ref.read(emailProvider.notifier).state = signedInEmail!;
                              }
                              ref.read(loginControllerProvider.notifier).completeSocialLogin(message);
                            } catch (e) {
                              if (SocialLoginService.isCanceled(e)) {
                                ref.read(loginControllerProvider.notifier).cancelSocialLogin();
                                return;
                              }
                              var errorMessage = e.toString().replaceAll('Exception: ', '');
                              if (errorMessage.contains('404:') ||
                                  errorMessage.toLowerCase().contains('not found') ||
                                  errorMessage.toLowerCase().contains('not registered')) {
                                errorMessage = isArabic
                                    ? 'المستخدم غير موجود. يرجى التسجيل أولاً'
                                    : 'User not found. Please register first';
                              }
                              ref.read(loginControllerProvider.notifier).failSocialLogin(errorMessage);
                            }
                          },
                          onApplePressed: () async {
                            ref.read(loginControllerProvider.notifier).startSocialLogin();
                            try {
                              final fcmToken = await NotificationService().getTokenForAuth();
                              final message = await AppleLoginFlow.run(apiCall: (appleData) async {
                                final idToken = appleData['idToken'];
                                if (idToken == null || idToken.isEmpty) {
                                  throw Exception('Failed to get Apple credentials');
                                }
                                final repo = ref.read(authRepositoryProvider);
                                try {
                                  return await repo.loginWithApple(
                                    idToken: idToken,
                                    authorizationCode: appleData['authorizationCode'],
                                    notificationToken: fcmToken,
                                  );
                                } catch (e) {
                                  final errorMessage = e.toString();
                                  if (errorMessage.contains('404:') ||
                                      errorMessage.toLowerCase().contains('not found') ||
                                      errorMessage.toLowerCase().contains('not registered')) {
                                    return repo.registerWithApple(
                                      idToken: idToken,
                                      authorizationCode: appleData['authorizationCode'],
                                      notificationToken: fcmToken,
                                    );
                                  }
                                  rethrow;
                                }
                              });
                              ref.read(loginControllerProvider.notifier).completeSocialLogin(message);
                            } catch (e) {
                              if (SocialLoginService.isCanceled(e)) {
                                ref.read(loginControllerProvider.notifier).cancelSocialLogin();
                                return;
                              }
                              ref.read(loginControllerProvider.notifier).failSocialLogin(
                                e.toString().replaceAll('Exception: ', ''),
                              );
                            }
                          },
                          isLoading: loginState.isLoading,
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr.dontHaveAccount,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                context.go(Routes.signUp);
                              },
                              child: Text(
                                tr.signUp,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
      ],
    ),
  ),
);
  }
}


