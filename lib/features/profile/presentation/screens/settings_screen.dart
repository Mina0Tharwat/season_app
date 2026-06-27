import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/router/routes.dart';
import 'package:season_app/core/services/app_state_service.dart';
import 'package:season_app/features/profile/presentation/widgets/delete_account_button.dart';
import 'package:season_app/shared/providers/locale_provider.dart';
import 'package:season_app/shared/widgets/custom_toast.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Gradient
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            backgroundColor: AppColors.primary,
       
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loc.settings,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
     
          ),
          
          // Settings Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // General Section
                  _buildSectionTitle(loc.general),
                  const SizedBox(height: 12),
                  
                  // Language Setting
                  _buildSettingCard(
                    icon: Icons.language,
                    title: loc.language,
                    subtitle: currentLocale.languageCode == 'ar' ? loc.arabic : loc.english,
                    trailing: _buildLanguageFlag(currentLocale.languageCode),
                    onTap: () => _showLanguageDialog(context, ref),
                  ),
          
       
                  
                  const SizedBox(height: 24),
  
                  // About Section
                  _buildSectionTitle(loc.about),
                  const SizedBox(height: 12),
                  
             
                  
                  _buildSettingCard(
                    icon: Icons.privacy_tip_outlined,
                    title: loc.privacyPolicy,
                    subtitle: loc.readPrivacyPolicy,
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                    onTap: () {
                      context.push('${Routes.webview}?url=${Uri.encodeComponent('https://seasonksa.com/privacy')}&title=${Uri.encodeComponent(loc.privacyPolicy)}');
                    },
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildSettingCard(
                    icon: Icons.description_outlined,
                    title: loc.termsAndConditions,
                    subtitle: loc.termsOfService,
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                    onTap: () {
                      context.push('${Routes.webview}?url=${Uri.encodeComponent('https://seasonksa.com/terms')}&title=${Uri.encodeComponent(loc.termsAndConditions)}');
                    },
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildSettingCard(
                    icon: Icons.code,
                    title: loc.version,
                    subtitle: '1.0.1',
                    trailing: const SizedBox.shrink(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Support Section
                  _buildSectionTitle(loc.support),
                  const SizedBox(height: 12),
                  
                  _buildSettingCard(
                    icon: Icons.support_agent,
                    title: loc.contactUs,
                    subtitle: loc.contactUsSubtitle,
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                    onTap: () => _showContactSupportOptions(context, loc),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Account Section
                  _buildSectionTitle(loc.account),
                  const SizedBox(height: 12),
                  
                  // Logout Button
                  _buildLogoutButton(context, ref, loc),
                  
                  const SizedBox(height: 12),
                  
                  const DeleteAccountButton(),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageFlag(String languageCode) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        languageCode == 'ar' ? '🇸🇦' : '🇺🇸',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context);
    final currentLocale = ref.read(localeProvider);
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title
            Text(
              loc.selectLanguage,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            
            // English Option
            _buildLanguageOption(
              context: context,
              ref: ref,
              flag: '🇺🇸',
              languageName: loc.english,
              languageCode: 'en',
              isSelected: currentLocale.languageCode == 'en',
            ),
            
            const SizedBox(height: 12),
            
            // Arabic Option
            _buildLanguageOption(
              context: context,
              ref: ref,
              flag: '🇸🇦',
              languageName: loc.arabic,
              languageCode: 'ar',
              isSelected: currentLocale.languageCode == 'ar',
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required WidgetRef ref,
    required String flag,
    required String languageName,
    required String languageCode,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await ref.read(localeProvider.notifier).setLocale(languageCode);
          if (context.mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context).languageChanged),
                backgroundColor: AppColors.success,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
          ),
          child: Row(
            children: [
              // Flag
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  flag,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              const SizedBox(width: 16),
              
              // Language Name
              Expanded(
                child: Text(
                  languageName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
              ),
              
              // Checkmark
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 28,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref, AppLocalizations loc) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final shouldLogout = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Row(
                  children: [
                    const Icon(Icons.logout, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(loc.logout),
                  ],
                ),
                content: Text(loc.logoutConfirmation),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(loc.cancel),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      loc.logout,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );

            if (shouldLogout == true && context.mounted) {
              await AppStateService.clearAllAppState(ref);
              if (context.mounted) {
                context.go(Routes.welcome);
              }
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  loc.logout,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContactSupportOptions(BuildContext context, AppLocalizations loc) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              loc.contactSupportTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            _contactOptionTile(
              isArabic: isArabic,
              icon: Icons.email_outlined,
              title: loc.contactViaEmail,
              subtitle: loc.contactEmailAddress,
              onTap: () {
                Navigator.pop(sheetContext);
                _openSupportEmail(context, loc, isArabic);
              },
            ),
            const SizedBox(height: 12),
            _contactOptionTile(
              isArabic: isArabic,
              icon: Icons.chat,
              title: loc.contactViaWhatsApp,
              subtitle: 'WhatsApp',
              iconColor: const Color(0xFF25D366),
              onTap: () {
                Navigator.pop(sheetContext);
                _openSupportWhatsApp(context, loc, isArabic);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactOptionTile({
    required bool isArabic,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.primary).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor ?? AppColors.primary, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isArabic ? Icons.chevron_left : Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _whatsappSupportUrl(bool isArabic) {
    const phone = '201031115768';
    final text = isArabic
        ? 'مرحبا !\nاريد التواصل بخصوص Season App'
        : 'Hello!\nI would like to contact you regarding Season App';
    return 'https://api.whatsapp.com/send?phone=$phone&text=${Uri.encodeComponent(text)}';
  }

  Future<void> _openSupportEmail(
    BuildContext context,
    AppLocalizations loc,
    bool isArabic,
  ) async {
    final subject = isArabic ? 'Season App - دعم فني' : 'Season App - Support';
    final body = isArabic
        ? 'مرحباً،\n\nأريد التواصل بخصوص Season App.\n\n'
        : 'Hello,\n\nI would like to contact you regarding Season App.\n\n';

    final uri = Uri(
      scheme: 'mailto',
      path: loc.contactEmailAddress,
      query: _encodeQuery({
        'subject': subject,
        'body': body,
      }),
    );

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        CustomToast.error(context, loc.emailAppNotAvailable);
      }
    } catch (e) {
      if (context.mounted) {
        CustomToast.error(context, loc.emailAppNotAvailable);
      }
    }
  }

  Future<void> _openSupportWhatsApp(
    BuildContext context,
    AppLocalizations loc,
    bool isArabic,
  ) async {
    try {
      final uri = Uri.parse(_whatsappSupportUrl(isArabic));
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        CustomToast.error(context, loc.whatsappNotInstalled);
      }
    } catch (e) {
      if (context.mounted) {
        CustomToast.error(context, loc.whatsappNotInstalled);
      }
    }
  }

  static String? _encodeQuery(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

}

