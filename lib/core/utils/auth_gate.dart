import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/router/routes.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/shared/widgets/custom_button.dart';

/// Guards authenticated-only flows while allowing guest browsing.
class AuthGate {
  AuthGate._();

  static bool get isGuest => !AuthService.isLoggedIn();

  /// Redirect guest users away from auth-only routes (deep links).
  static String? guestRedirect(String path) {
    if (!isGuest) return null;

    const exactPaths = {
      Routes.profileEdit,
      Routes.createBag,
      Routes.vendorServices,
      Routes.vendorServiceNew,
      Routes.applyAsTrader,
      Routes.myGeographicalServices,
      Routes.newGeographicalGuide,
      '/groups/create',
      '/groups/join',
      '/groups/qr-scanner',
    };
    if (exactPaths.contains(path)) return Routes.home;

    if (path.startsWith('/bags/') &&
        (path.endsWith('/edit') ||
            path.contains('/add-items') ||
            path.contains('/analysis'))) {
      return Routes.home;
    }
    if (path.startsWith('/groups/') &&
        (path.endsWith('/edit') || path.contains('/sos'))) {
      return Routes.home;
    }
    if (path.startsWith('${Routes.vendorServiceEdit.split(':').first}') &&
        path.contains('/edit')) {
      return Routes.home;
    }
    if (path.startsWith(Routes.myGeographicalServiceDetails.split(':').first) ||
        path.startsWith(Routes.editGeographicalGuide.split(':').first)) {
      return Routes.home;
    }

    return null;
  }

  /// Returns `true` when the user is logged in or chooses to sign in.
  static Future<bool> requireLogin(BuildContext context) async {
    if (AuthService.isLoggedIn()) return true;

    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    final shouldSignIn = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isAr ? 'تسجيل الدخول مطلوب' : 'Sign in required'),
        content: Text(
          isAr
              ? 'سجّل دخولك أو أنشئ حساباً للمتابعة.'
              : 'Please sign in or create an account to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(loc.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              loc.login,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (shouldSignIn == true && context.mounted) {
      await context.push(Routes.login);
      return AuthService.isLoggedIn();
    }

    return false;
  }
}

class GuestLoginPrompt extends StatelessWidget {
  final String message;

  const GuestLoginPrompt({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: loc.login,
                onPressed: () => context.push(Routes.login),
                color: AppColors.primary,
                textColor: AppColors.textLight,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
