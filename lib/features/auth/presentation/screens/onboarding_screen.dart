import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:season_app/core/constants/app_assets.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/router/routes.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/core/services/dio_client.dart';
import 'package:season_app/core/services/onboarding_service.dart';
import 'package:season_app/shared/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingPage> _getPages(AppLocalizations localizations) {
    return [
      OnboardingPage(
        image: AppAssets.onboarding1,
        title: localizations.onboardingTitle1,
        description: localizations.onboardingDescription1,
      ),
      OnboardingPage(
        image: AppAssets.onboarding2,
        title: localizations.onboardingTitle2,
        description: localizations.onboardingDescription2,
      ),
      OnboardingPage(
        image: AppAssets.onboarding3,
        title: localizations.onboardingTitle3,
        description: localizations.onboardingDescription3,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final localizations = AppLocalizations.of(context);
    final pages = _getPages(localizations);
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _skipToLogin() {
    _goToLogin();
  }

  Future<void> _goToLogin() async {
    await OnboardingService.setOnboardingCompleted();
    if (!mounted) return;
    final token = AuthService.getToken();
    final isLoggedIn =
        AuthService.isLoggedIn() && token != null && token.isNotEmpty;
    if (isLoggedIn) {
      DioHelper.instance.setAccessToken(token);
      context.go(Routes.home);
    } else {
      context.go(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final pages = _getPages(localizations);
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
        child: Column(
          children: [
            // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed:_currentPage < pages.length - 1 ? _skipToLogin : null,
                    child: Text(
                      _currentPage < pages.length - 1 ? localizations.onboardingSkip : '',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(pages[index]);
                },
              ),
            ),
            
            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => _buildIndicator(index == _currentPage),
              ),
            ),
            const SizedBox(height: 20),
            
            // Next/Start button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: CustomButton(
                text: _currentPage == pages.length - 1 
                    ? localizations.onboardingStart 
                    : localizations.onboardingNext,
                onPressed: _nextPage,
                color: AppColors.primary,
                textColor: AppColors.textLight,
                width: double.infinity,
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Phone mockup image
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    page.image,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.75,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Title
            Text(
              page.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                page.description,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.border,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}

