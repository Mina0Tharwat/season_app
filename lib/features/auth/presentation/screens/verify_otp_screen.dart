import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:season_app/core/constants/app_assets.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/router/routes.dart';
import 'package:season_app/core/services/app_state_service.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/core/services/notification_service.dart';
import 'package:season_app/features/auth/providers.dart';
import 'package:season_app/features/profile/providers.dart';
import 'package:season_app/shared/helpers/snackbar_helper.dart';
import 'package:season_app/shared/widgets/custom_button.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final String? returnTo;

  const VerifyOtpScreen({
    super.key,
    this.returnTo,
  });

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Defer timer start until after widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTimer();
      ref.read(otpControllerProvider.notifier).clearError();
      ref.read(otpControllerProvider.notifier).clearMessage();
    });
  }

  void startTimer() {
    timer?.cancel();
    ref.read(otpTimerProvider.notifier).state = 120; // 2 minutes
    ref.read(otpTimerRunningProvider.notifier).state = true;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      final current = ref.read(otpTimerProvider);
      if (current > 0) {
        ref.read(otpTimerProvider.notifier).state = current - 1;
      } else {
        ref.read(otpTimerRunningProvider.notifier).state = false;
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final pinController = ref.watch(pinControllerProvider);
    final email = ref.watch(emailProvider);
    final time = ref.watch(otpTimerProvider);
    final isRunning = ref.watch(otpTimerRunningProvider);
    final otpState = ref.watch(otpControllerProvider);
    
    // Listen to OTP state changes
    ref.listen(otpControllerProvider, (previous, next) async {
      if (next.error != null) {
        SnackbarHelper.error(context, next.error.toString());
      } else if (next.message != null && next.isVerified) {
        SnackbarHelper.success(context, next.message.toString());
        if (widget.returnTo == 'profile' || widget.returnTo == 'settings') {
          ref.read(profileControllerProvider.notifier).loadProfile();
          if (context.mounted) context.pop();
        } else {
          AppStateService.refreshUserDataAfterLogin(ref);
          try {
            await NotificationService().onUserLoggedIn(
              userId: AuthService.getUserId(),
            );
          } catch (e) {
            debugPrint('Error setting up push notifications: $e');
          }
          if (context.mounted) context.go(Routes.home);
        }
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PopScope(
        canPop: widget.returnTo != null,
        child: SafeArea(
        child: Center(
          child: SingleChildScrollView( // 👈 يمنع الـ overflow
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.seasonAuthImage, height: 80),
                const SizedBox(height: 10),
                Text(
                  tr.verifyMail,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Text(
                  "${tr.verifyMailBody} $email",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 4,
                    pinAnimationType: PinAnimationType.scale,
                    cursor: Container(
                      color: AppColors.primary,
                      width: 1.5,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    defaultPinTheme: PinTheme(
                      width: 65,
                      height: 65,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.05),
                        border: Border.all(
                            color: Color.fromRGBO(234, 239, 243, 1)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: pinController,
                    onChanged: (val) {
                      ref.read(pinControllerProvider).text = val;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isRunning
                          ? "${tr.remaining} ${formatTime(time)} ${tr.seconds}"
                          : tr.codeNotSent,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                    const SizedBox(width: 5),
                    if (!isRunning)
                      TextButton(
                        onPressed: () async {
                          await ref.read(otpControllerProvider.notifier).resendOtp(email: email);
                          startTimer();
                        },
                        child: Text(
                          tr.resendCode,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomButton(
                  isLoading: otpState.isLoading,
                  text: tr.verify,
                  color: AppColors.primary,
                  onPressed: (pinController.text.length != 4 || otpState.isLoading)
                      ? null
                      : () async {
                    await ref.read(otpControllerProvider.notifier).verifyOtp(
                      email: email,
                      otp: pinController.text,
                    );
                    // The listener will handle navigation
                  },
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
