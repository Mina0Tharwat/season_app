import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:season_app/core/constants/app_assets.dart';
import 'package:season_app/core/services/social_login_service.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;
  final bool isLoading;

  const SocialLoginButtons({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isGoogleAvailable = SocialLoginService.isGoogleSignInAvailable();
    final isAppleAvailable = SocialLoginService.isAppleSignInAvailable();

    if (!isGoogleAvailable && !isAppleAvailable) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                Localizations.localeOf(context).languageCode == 'ar' ? 'أو' : 'OR',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            if (isGoogleAvailable)
              Expanded(
                child: _SocialLoginButton(
                  iconPath: AppAssets.googleIcon,
                  label: 'Google',
                  color: Colors.white,
                  textColor: Colors.black87,
                  borderColor: Colors.grey.shade300,
                  onPressed: isLoading ? null : onGooglePressed,
                  isLoading: isLoading,
                ),
              ),
            if (isGoogleAvailable && isAppleAvailable) ...[
              const SizedBox(width: 12),
            ],
            if (isAppleAvailable) ...[
              Expanded(
                child: _SocialLoginButton(
                  iconPath: AppAssets.appleIcon,
                  label: 'Apple',
                  color: Colors.black,
                  textColor: Colors.white,
                  borderColor: Colors.black,
                  onPressed: isLoading ? null : onApplePressed,
                  isLoading: isLoading,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _SocialLoginButton({
    required this.iconPath,
    required this.label,
    required this.color,
    required this.textColor,
    required this.borderColor,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        side: BorderSide(color: borderColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: textColor,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: color == Colors.black 
                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
    );
  }
}

