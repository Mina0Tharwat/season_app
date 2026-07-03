import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:season_app/core/constants/app_colors.dart';
import 'package:season_app/core/localization/generated/l10n.dart';
import 'package:season_app/core/utils/phone_country_parser.dart';
import 'package:season_app/core/utils/validators.dart';
import 'package:season_app/features/profile/providers.dart';
import 'package:season_app/shared/providers/locale_provider.dart';
import 'package:season_app/shared/widgets/custom_button.dart';
import 'package:season_app/shared/widgets/custom_text_field.dart';
import 'package:season_app/shared/widgets/custom_dropdown.dart';
import 'package:season_app/shared/widgets/avatar_selector_dialog.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  
  String? _selectedGender;
  int? _selectedAvatarId;
  DateTime? _selectedDate;
  CountryCode selectedCountryCode = CountryCode.fromDialCode('+966'); // Default to Saudi Arabia
  /// Raw phone from API; used to skip sending `phone` when unchanged (avoids duplicate-phone errors).
  String? _originalPhoneFromProfile;

  @override
  void initState() {
    super.initState();
    // Initialize form with current profile data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profile = ref.read(profileControllerProvider).profile;
      if (profile != null) {
        setState(() {
          _originalPhoneFromProfile = profile.phone;
          _nameController.text = profile.name;
          _nicknameController.text = profile.nickname ?? '';
          _emailController.text = profile.email;

          final parsed = parseProfilePhoneForEdit(profile.phone);
          selectedCountryCode = parsed.country;
          _phoneController.text = parsed.nationalNumber;
          
          _birthDateController.text = profile.birthDate ?? '';
          _selectedGender = profile.gender;
          _selectedAvatarId = profile.avatarId;
          if (profile.birthDate != null && profile.birthDate!.isNotEmpty) {
            try {
              _selectedDate = DateTime.parse(profile.birthDate!);
            } catch (e) {
              // Invalid date format
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _showAvatarSelector() async {
    final avatarId = await showDialog<int>(
      context: context,
      builder: (context) => AvatarSelectorDialog(
        currentAvatarId: _selectedAvatarId,
      ),
    );

    if (avatarId != null) {
      setState(() {
        _selectedAvatarId = avatarId;
      });
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _birthDateController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<File?> _getAvatarFileFromAsset(int avatarId) async {
    try {
      // Load the asset as bytes
      final byteData = await rootBundle.load('assets/images/png/avatars/$avatarId.png');
      
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      
      // Create a temporary file
      final file = File('${tempDir.path}/avatar_$avatarId.png');
      
      // Write the bytes to the file
      await file.writeAsBytes(byteData.buffer.asUint8List());
      
      return file;
    } catch (e) {
      print('Error converting avatar to file: $e');
      return null;
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final loc = AppLocalizations.of(context);

    // Convert selected avatar to file if avatar is selected
    File? photoFile;
    if (_selectedAvatarId != null) {
      print('🖼️ Converting avatar $_selectedAvatarId to file...');
      photoFile = await _getAvatarFileFromAsset(_selectedAvatarId!);
      print('✅ Avatar converted: ${photoFile?.path}');
    }

    print('📝 Calling updateProfile with photoFile: ${photoFile != null ? photoFile.path : "null"}');

    final profilePhone =
        _originalPhoneFromProfile ?? ref.read(profileControllerProvider).profile?.phone;
    final storedCanon = canonicalInternationalPhoneDigits(profilePhone ?? '');
    final formCanon = canonicalInternationalPhoneDigitsFromForm(
      country: selectedCountryCode,
      nationalInput: _phoneController.text,
    );
    final phoneUnchanged = storedCanon == formCanon;

    final fullPhoneNumber = '${selectedCountryCode.dialCode}${_phoneController.text.trim()}';
    final String? phoneToSend = phoneUnchanged ? null : fullPhoneNumber;

    final success = await ref.read(profileControllerProvider.notifier).updateProfile(
      name: _nameController.text.trim(),
      nickname: _nicknameController.text.trim().isEmpty ? null : _nicknameController.text.trim(),
      email: _emailController.text.trim(),
      phone: phoneToSend,
      birthDate: _birthDateController.text.trim().isEmpty ? null : _birthDateController.text.trim(),
      gender: _selectedGender,
      avatarId: null,
      photoFile: photoFile, // Send the avatar image as photo_url
    );

    if (success && mounted) {
      _originalPhoneFromProfile =
          ref.read(profileControllerProvider).profile?.phone ?? _originalPhoneFromProfile;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.profileUpdatedSuccessfully),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    } else if (mounted) {
      final error = ref.read(profileControllerProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? loc.errorUpdatingProfile),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final profileState = ref.watch(profileControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(loc.editProfile),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Avatar Section
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: 
                      _selectedAvatarId != null
                              ? AssetImage('assets/images/png/avatars/$_selectedAvatarId.png')
                              : (profileState.profile?.photoUrl != null
                              ? NetworkImage(profileState.profile!.photoUrl!)
                              : null) as ImageProvider?,
                      child: _selectedAvatarId == null && profileState.profile?.photoUrl == null
                          ? Text(
                              profileState.profile?.name[0].toUpperCase() ?? 'U',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ) : null,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton.icon(
                    onPressed: _showAvatarSelector,
                    icon: const Icon(Icons.face),
                    label: Text(loc.changePhoto),
                  ),
                ),
                const SizedBox(height: 24),

                // Name Field
                CustomTextField(
                  controller: _nameController,
                  hintText: loc.name,
                  prefixIcon: const Icon(Icons.person),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return loc.pleaseEnterName;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Nickname Field
                CustomTextField(
                  controller: _nicknameController,
                  hintText: '${loc.nickname} (${loc.optional})',
                  prefixIcon: const Icon(Icons.alternate_email),
                ),
                const SizedBox(height: 16),

                // Email Field
                CustomTextField(
                  controller: _emailController,
                  hintText: loc.email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Phone Field with Country Code
                Directionality( 
                  textDirection: TextDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        key: ValueKey(
                          'edit_phone_${selectedCountryCode.code}_${selectedCountryCode.dialCode}',
                        ),
                        controller: _phoneController,
                        hintText: '${loc.phone} (${loc.optional})',
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.phone,
                        showCountryPicker: true,
                        initialCountry: selectedCountryCode,
                        onCountryChanged: (code) {
                          setState(() {
                            selectedCountryCode = code;
                            // Remove leading zero if switching to Saudi Arabia
                            if (code.dialCode == '+966' && _phoneController.text.startsWith('0')) {
                              _phoneController.text = _phoneController.text.substring(1);
                            }
                          });
                        },
                        onChanged: (val) {
                          // Remove leading zero if country code is +966 (Saudi Arabia)
                          if (selectedCountryCode.dialCode == '+966' && val.startsWith('0')) {
                            final cleanedNumber = val.substring(1);
                            _phoneController.value = TextEditingValue(
                              text: cleanedNumber,
                              selection: TextSelection.collapsed(offset: cleanedNumber.length),
                            );
                          }
                        },
                        validator: (value) {
                          final isArabic = ref.watch(localeProvider).languageCode == 'ar';
                          return Validators.optionalPhone(
                            value,
                            isArabic: isArabic,
                            countryCode: selectedCountryCode.dialCode,
                          );
                        },
                      ),
               
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Birth Date Field
                CustomTextField(
                  controller: _birthDateController,
                  hintText: '${loc.birthDate} (${loc.optional})',
                  prefixIcon: const Icon(Icons.cake),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _selectDate,
                  ),
                  onChanged: null,
                ),
                const SizedBox(height: 16),

                // Gender Dropdown
                CustomDropdown(
                  hintText: loc.gender,
                  value: _selectedGender,
                  prefixIcon: const Icon(Icons.person_outline),
                  items: [
                    DropdownMenuItem(
                      value: 'male',
                      child: Text(loc.male),
                    ),
                    DropdownMenuItem(
                      value: 'female',
                      child: Text(loc.female),
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select gender';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),

                const SizedBox(height: 32),

                // Save Button
                CustomButton(
                  text: loc.updateProfile,
                  isLoading: profileState.isUpdating,
                  color: AppColors.primary,
                  onPressed: profileState.isUpdating ? null : _saveProfile,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
