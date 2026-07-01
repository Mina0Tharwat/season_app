import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:season_app/core/constants/app_assets.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/router/routes.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/core/services/dio_client.dart';
import 'package:season_app/core/services/onboarding_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_app/shared/providers/app_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }
  
  void _checkAuthStatus() {
    Timer(const Duration(milliseconds: 1000), () async {
      // Ensure DioHelper is initialized
      ref.read(dioHelperProvider);

      final isLoggedIn = AuthService.isLoggedIn();
      final token = AuthService.getToken();

      final onboardingFlag = OnboardingService.rawCompletedFlag;
      if (onboardingFlag == null &&
          isLoggedIn &&
          token != null &&
          token.isNotEmpty) {
        await OnboardingService.setOnboardingCompleted();
        if (!mounted) return;
        DioHelper.instance.setAccessToken(token);
        context.go(Routes.home);
        return;
      }

      if (!OnboardingService.hasCompletedOnboarding()) {
        if (!mounted) return;
        context.go(Routes.welcome);
        return;
      }

      if (isLoggedIn && token != null && token.isNotEmpty) {
        DioHelper.instance.setAccessToken(token);
        if (!mounted) return;
        context.go(Routes.home);
      } else {
        if (!mounted) return;
        context.go(Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
        child: Lottie.asset(
          AppAssets.splashAnimation,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.contain,
          repeat: false,
        ),
      ),
      ),
    );
  }
}
