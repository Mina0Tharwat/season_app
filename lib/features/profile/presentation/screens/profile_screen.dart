import 'package:country_code_picker/country_code_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/router/routes.dart';
import 'package:season_app/core/providers/auth_state_provider.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/core/utils/auth_gate.dart';
import 'package:season_app/features/home/controllers/user_qr_controller.dart';
import 'package:season_app/features/profile/providers.dart';
import 'package:season_app/features/vendor/presentation/providers/vendor_providers.dart';
import 'package:season_app/shared/widgets/custom_button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!AuthService.isLoggedIn()) return;
      ref.read(profileControllerProvider.notifier).loadProfile();
      ref.read(userQrControllerProvider.notifier).loadUserQr();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    // Reload profile data as soon as the user transitions from guest to logged in.
    ref.listen(authStateProvider, (previous, next) {
      if (next == true && previous != true) {
        ref.read(profileControllerProvider.notifier).loadProfile();
        ref.read(userQrControllerProvider.notifier).loadUserQr();
      }
    });

    final isLoggedIn = ref.watch(authStateProvider);
    final profileState = ref.watch(profileControllerProvider);
    final userQrState = ref.watch(userQrControllerProvider);
    final vendorServicesAsync = ref.watch(vendorServicesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    
    // Check if user has services
    final hasServices = vendorServicesAsync.maybeWhen(
      data: (services) => services.isNotEmpty,
      orElse: () => false,
    );

    if (!isLoggedIn) {
      return GuestLoginPrompt(message: loc.profilePageContent);
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: profileState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileState.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        loc.errorLoadingProfile,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(profileControllerProvider.notifier).loadProfile();
                        },
                        child: Text(loc.resendCode),
                      ),
                    ],
                  ),
                )
              : profileState.profile == null
                  ? Center(child: Text(loc.errorLoadingProfile))
                  : RefreshIndicator(
                      onRefresh: () async {
                        await ref.read(profileControllerProvider.notifier).loadProfile();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            // Profile Header with gradient
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primary,
                                  ],
                                ),
                         
                              ),
                              child: SafeArea(
                                bottom: false,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                                  child: Column(
                                    children: [
                                      // Settings Icon - RTL aware positioning
                                      Align(
                                        alignment: isRTL ? Alignment.topLeft : Alignment.topRight,
                                        child: Container(
                                          margin: const EdgeInsets.only(bottom: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                context.push(Routes.settings);
                                              },
                                              borderRadius: BorderRadius.circular(12),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: Icon(
                                                  Icons.settings,
                                                  color: Colors.white,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Profile Image
                                      Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 3,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.white,
                              backgroundImage: profileState.profile?.avatarPath != null
                                  ? AssetImage(profileState.profile!.avatarPath!)
                                  : (profileState.profile?.photoUrl != null
                                      ? CachedNetworkImageProvider(
                                          profileState.profile!.photoUrl!,
                                        )
                                      : null) as ImageProvider?,
                              child: profileState.profile?.avatarPath == null && profileState.profile?.photoUrl == null
                                  ? Text(
                                      profileState.profile?.name[0].toUpperCase() ?? 'U',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : null,
                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                context.push('/profile/edit');
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: AppColors.secondary,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.2),
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      // Name
                                      Text(
                                        profileState.profile?.name ?? '',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      // Show Points Card Button
                                      if (userQrState.userQr != null)
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _showPointsCardBottomSheet(context, userQrState.userQr!, loc);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: AppColors.primary,
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              elevation: 2,
                                            ),
                                            child: Text(
                                              loc.showPointsCard,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),              

                            // Personal Information Section
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                   
                                  const SizedBox(height: 16),
                                  _buildInfoCard(
                                    icon: Icons.email,
                                    title: loc.email,
                                    value: profileState.profile?.email ?? '',
                                  ),
                                  const SizedBox(height: 12),
                                  _buildPhoneCard(
                                    phone: profileState.profile?.phone ?? '',
                                    isRTL: isRTL,
                                    title: loc.phone,
                                  ),
                                  if (profileState.profile?.birthDate != null && profileState.profile!.birthDate!.isNotEmpty) ...[
                                    const SizedBox(height: 12),
                                    _buildInfoCard(
                                      icon: Icons.cake,
                                      title: loc.birthDate,
                                      value: profileState.profile!.birthDate!,
                                    ),
                                  ],
                                  if (profileState.profile?.gender != null && profileState.profile!.gender!.isNotEmpty) ...[
                                    const SizedBox(height: 12),
                                    _buildInfoCard(
                                      icon: Icons.person,
                                      title: loc.gender,
                                      value: profileState.profile!.gender == 'male' ? loc.male : loc.female,
                                    ),
                                  ],
                           
                                  const SizedBox(height: 24),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          text: hasServices ? loc.myServices : loc.applyAsServiceProvider,
                                          color: AppColors.secondary,
                                          onPressed: () {
                                            context.push(Routes.vendorServices);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: CustomButton(
                                          text: loc.applyAsTrader,
                                          color: AppColors.primary,
                                          onPressed: () {
                                            context.push(Routes.myGeographicalServices);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 16),

                                
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
    );
  }

  void _showPointsCardBottomSheet(BuildContext context, userQr, AppLocalizations loc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark 
              ? AppColors.backgroundDark 
              : AppColors.backgroundLight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // Card Widget
                  _buildCardWidget(userQr, loc),
                  const SizedBox(height: 24),
                  // Info Section
                  _buildInfoSection(loc),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
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
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneCard({
    required String phone,
    required bool isRTL,
    required String title,
  }) {
    // Parse phone to extract country code and number
    String displayPhone = phone;
    
    if (phone.isNotEmpty) {
      final plusIndex = phone.indexOf('+');
      if (plusIndex != -1) {
        // Find the end of the country code
        final spaceIndex = phone.indexOf(' ', plusIndex);
        if (spaceIndex != -1) {
          final countryCodeStr = phone.substring(plusIndex, spaceIndex);
          final number = phone.substring(spaceIndex + 1);
          
          // Try to get the country code
          try {
            final code = CountryCode.fromDialCode(countryCodeStr);
            
            // Display phone with code and number (right to left for Arabic, left to right for English)
            if (isRTL) {
              displayPhone = '$number ${code.dialCode}';
            } else {
              displayPhone = '${code.dialCode} $number';
            }
          } catch (e) {
            displayPhone = phone;
          }
        } else {
          displayPhone = phone;
        }
      }
    }
    
    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.phone,
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
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  displayPhone,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWidget(userQr, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/png/card_background.png',
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay for better text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
            ),
            
            // Card Content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // User Name
                  Text(
                    userQr.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
               
                  // QR Code
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: QrImageView(
                        data: userQr.qrCodeUrl,
                        version: QrVersions.auto,
                        size: 80.0,
                        foregroundColor: AppColors.primary,
                        backgroundColor: Colors.white,
                      ),
                  ),
                  const SizedBox(height: 8),
                  // Loyalty Points
                  Text(
                    l10n.loyaltyPoints,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cairo',
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${userQr.coins} ${l10n.points}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    l10n.howToUseCard,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildInfoItem(
                  icon: Icons.stars,
                  title: l10n.collectPoints,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildInfoItem(
                  icon: Icons.card_giftcard,
                  title: l10n.exclusiveRewards,
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: color,
            size: 18,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              fontFamily: 'Cairo',
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

