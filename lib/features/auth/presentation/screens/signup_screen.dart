import 'package:country_code_picker/country_code_picker.dart';
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
import 'package:season_app/features/auth/presentation/widgets/agreement_policy.dart';
import 'package:season_app/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:season_app/features/auth/providers.dart';
import 'package:season_app/shared/helpers/snackbar_helper.dart';
import 'package:season_app/shared/providers/locale_provider.dart';
import 'package:season_app/shared/widgets/custom_button.dart';
import 'package:season_app/shared/widgets/custom_text_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  CountryCode selectedCode = CountryCode.fromDialCode('+966'); // Default to KSA

  @override
  void initState() {
    super.initState();
    
    // Clear any previous errors when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(signupControllerProvider.notifier).clearError();
      ref.read(signupControllerProvider.notifier).clearMessage();
      ref.read(loginControllerProvider.notifier).clearError();
      ref.read(loginControllerProvider.notifier).clearMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final firstNameController = ref.watch(firstNameControllerProvider);
    final lastNameController = ref.watch(lastNameControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final phoneController = ref.watch(phoneControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final confirmPasswordController = ref.watch(confirmPasswordControllerProvider);
    final signupState = ref.watch(signupControllerProvider);
    final loginState = ref.watch(loginControllerProvider);
    final signupNotifier = ref.read(signupControllerProvider.notifier);

    // Listen to signup state changes
    ref.listen(signupControllerProvider, (previous, next) {
      if (next.isLoading) return;

      if (next.error != null && next.error != previous?.error) {
        SnackbarHelper.error(
          context,
          next.error.toString().replaceAll('Exception: ', ''),
        );
        signupNotifier.clearError();
        return;
      }

      if (next.message == null || next.message == previous?.message) return;

      if (AuthService.isLoggedIn()) {
        SnackbarHelper.success(context, next.message.toString());
        AppStateService.refreshUserDataAfterLogin(ref);
        try {
          NotificationService().onUserLoggedIn(
            userId: AuthService.getUserId(),
          );
        } catch (e) {
          debugPrint('Error setting up push notifications: $e');
        }
        signupNotifier.clearMessage();
        if (context.mounted) context.go(Routes.home);
        return;
      }

      if (next.needsOtpVerification) {
        signupNotifier.clearMessage();
        ref.read(loginControllerProvider.notifier).clearError();
        if (context.mounted) {
          context.pushReplacement(Routes.verifyOtp);
        }
      }
    });

    // Social login (Google) uses loginController
    ref.listen(loginControllerProvider, (previous, next) async {
      if (next.isLoading) return;

      if (next.error != null && next.error != previous?.error) {
        SnackbarHelper.error(
          context,
          next.error.toString().replaceAll('Exception: ', ''),
        );
        ref.read(loginControllerProvider.notifier).clearError();
        return;
      }

      if (next.message == null || next.message == previous?.message) return;

      if (next.isLoggedIn) {
        SnackbarHelper.success(context, next.message.toString());
        AppStateService.refreshUserDataAfterLogin(ref);
        try {
          await NotificationService().onUserLoggedIn(
            userId: AuthService.getUserId(),
          );
        } catch (e) {
          debugPrint('Error setting up push notifications: $e');
        }
        ref.read(loginControllerProvider.notifier).clearMessage();
        if (context.mounted) context.go(Routes.home);
        return;
      }

      if (!AuthService.isLoggedIn()) {
        ref.read(loginControllerProvider.notifier).clearMessage();
        if (context.mounted) {
          context.pushReplacement(Routes.verifyOtp);
        }
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(AppAssets.seasonAuthImage, height: 80),
                  const SizedBox(height: 10),
                  Text(
                    tr.signUp,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        // Name
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: tr.firstName,
                                textDirection: TextDirection.ltr,
                                controller: firstNameController,
                                onChanged: (val) => ref.read(firstNameProvider.notifier).state = val,
                                validator: (value) => Validators.notEmpty(value, isArabic: isArabic),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextField(
                                hintText: tr.lastName,
                                textDirection: TextDirection.ltr,
                                controller:lastNameController,
                                onChanged: (val) => ref.read(lastNameProvider.notifier).state = val,
                                validator: (value) => Validators.notEmpty(value, isArabic: isArabic),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        // Email
                        CustomTextField(
                          hintText: tr.email,
                          keyboardType: TextInputType.emailAddress,
                          textDirection: TextDirection.ltr,
                          onChanged: (val) => ref.read(emailProvider.notifier).state = val,
                          validator: (value) => Validators.email(value, isArabic: isArabic),
                          controller: emailController,
                        ),
                        const SizedBox(height: 10),
                        // Phone
                        Directionality( 
                          textDirection: TextDirection.ltr,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                hintText: '${tr.phone} (${tr.optional})',
                                textDirection: TextDirection.ltr,
                                keyboardType: TextInputType.phone,
                                showCountryPicker: true,
                                initialCountry: selectedCode,
                                onCountryChanged: (code) {
                                  setState(() {
                                    selectedCode = code;
                                  });
                                },
                                onChanged: (val) {
                                  // Remove leading zero if country code is +966 (Saudi Arabia)
                                  String cleanedNumber = val;
                                  if (selectedCode.dialCode == '+966' && cleanedNumber.startsWith('0')) {
                                    cleanedNumber = cleanedNumber.substring(1);
                                    // Update the controller text to reflect the change
                                    phoneController.value = TextEditingValue(
                                      text: cleanedNumber,
                                      selection: TextSelection.collapsed(offset: cleanedNumber.length),
                                    );
                                  }
                                  if (cleanedNumber.isEmpty) {
                                    ref.read(phoneProvider.notifier).state = '';
                                    return;
                                  }
                                  final fullNumber = '${selectedCode.dialCode}$cleanedNumber';
                                  ref.read(phoneProvider.notifier).state = fullNumber;
                                },
                                validator: (value) => Validators.optionalPhone(
                                  value,
                                  isArabic: isArabic,
                                  countryCode: selectedCode.dialCode,
                                ),
                                controller: phoneController,
                              ),
            
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Password
                        CustomTextField(
                          hintText: tr.password,
                          obscureText: ref.watch(passwordVisibilityProvider),
                          textDirection: TextDirection.ltr,
                          suffixIcon: IconButton(
                            icon: Icon(ref.watch(passwordVisibilityProvider)
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                            onPressed: () {
                              ref.read(passwordVisibilityProvider.notifier).state =
                              !ref.read(passwordVisibilityProvider.notifier).state;
                            },
                          ),
                          onChanged: (val) => ref.read(passwordProvider.notifier).state = val,
                          validator: (value) => Validators.password(value, isArabic: isArabic),
                          controller: passwordController
                        ),
                        const SizedBox(height: 10),
                        // Confirm Password
                        CustomTextField(
                          hintText: tr.confirmPassword,
                          obscureText: ref.watch(confirmPasswordVisibilityProvider),
                          textDirection: TextDirection.ltr,
                          suffixIcon: IconButton(
                            icon: Icon(ref.watch(confirmPasswordVisibilityProvider)
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                            onPressed: () {
                              ref.read(confirmPasswordVisibilityProvider.notifier).state =
                              !ref.read(confirmPasswordVisibilityProvider.notifier).state;
                            },
                          ),
                          onChanged: (val) => ref.read(confirmPasswordProvider.notifier).state = val,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr.confirmPasswordRequired;
                            }
                            if (value != ref.watch(passwordProvider)) {
                              return tr.passwordsDoNotMatch;
                            }
                            return null;
                          },
                          controller: confirmPasswordController
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          isLoading:signupState.isLoading ,
                          text: tr.signUp,
                          color: AppColors.primary,
                          onPressed: signupState.isLoading
                              ? null
                              : () async {
                            if (formKey.currentState!.validate()) {
                              // Get FCM token
                              final fcmToken = await NotificationService().getTokenForAuth();
                              
                              final phoneValue = phoneController.text.trim().isEmpty
                                  ? null
                                  : ref.read(phoneProvider);
                              await signupNotifier.register(
                                firstName: ref.watch(firstNameProvider),
                                lastName: ref.watch(lastNameProvider),
                                email: ref.watch(emailProvider),
                                phone: phoneValue?.trim().isEmpty == true ? null : phoneValue,
                                password: ref.watch(passwordProvider),
                                passwordConfirmation: ref.watch(confirmPasswordProvider),
                                notificationToken: fcmToken,
                              );
                              // The listener will handle the response
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
                              ref.read(loginControllerProvider.notifier).failSocialLogin(
                                e.toString().replaceAll('Exception: ', ''),
                              );
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
                          isLoading: signupState.isLoading || loginState.isLoading,
                        ),
                        const SizedBox(height: 20),
                        AgreementPolicy(isArabic: isArabic),
                        const SizedBox(height: 20),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr.alreadyHaveAccount,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                context.go(Routes.login);
                              },
                              child: Text(
                                tr.login,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

