import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/features/profile/data/models/profile_model.dart';
import 'package:season_app/features/profile/data/repositories/profile_repository.dart';
import 'package:season_app/features/profile/providers.dart';

class ProfileState {
  final ProfileModel? profile;
  final bool isLoading;
  final String? error;
  final bool isUpdating;

  ProfileState({
    this.profile,
    this.isLoading = false,
    this.error,
    this.isUpdating = false,
  });

  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
    String? error,
    bool? isUpdating,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  ProfileRepository get repository => ref.read(profileRepositoryProvider);

  @override
  ProfileState build() {
    return ProfileState();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final profile = await repository.getProfile();
      await AuthService.setEmailVerified(profile.isEmailVerified);
      state = state.copyWith(
        profile: profile,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> updateProfile({
    required String name,
    String? nickname,
    required String email,
    String? phone,
    String? birthDate,
    String? gender,
    int? avatarId,
    File? photoFile,
  }) async {
    state = state.copyWith(isUpdating: true, error: null);

    try {
      print('🎮 Controller: photoFile is ${photoFile != null ? "provided" : "null"}');
      print('🎮 Controller: avatarId is $avatarId');

      final updatedProfile = await repository.updateProfile(
        name: name,
        nickname: nickname,
        email: email,
        phone: phone,
        birthDate: birthDate,
        gender: gender,
        avatarId: avatarId,
        photoFile: photoFile,
      );
      
      state = state.copyWith(
        profile: updatedProfile,
        isUpdating: false,
      );
      await AuthService.setEmailVerified(updatedProfile.isEmailVerified);
      
      return true;
    } catch (e) {
      state = state.copyWith(
        isUpdating: false,
        error: e.toString(),
      );
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

