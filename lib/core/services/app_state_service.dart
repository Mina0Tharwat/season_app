import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_app/core/providers/auth_state_provider.dart';
import 'package:season_app/core/services/auth_service.dart';
import 'package:season_app/core/services/dio_client.dart';
import 'package:season_app/core/services/notification_service.dart';
import 'package:season_app/core/services/safety_radius_alarm_service.dart';
import 'package:season_app/core/services/background_location_service.dart';
import 'package:season_app/features/auth/providers.dart';
import 'package:season_app/features/emergency/providers/emergency_providers.dart';
import 'package:season_app/features/groups/providers.dart';
import 'package:season_app/features/home/controllers/user_qr_controller.dart';
import 'package:season_app/features/home/providers/bag_providers.dart';
import 'package:season_app/features/profile/providers.dart';
import 'package:season_app/features/reminders/providers.dart';
import 'package:season_app/features/smart_bags/providers/smart_bag_providers.dart';
import 'package:season_app/features/vendor/presentation/providers/vendor_providers.dart';

class AppStateService {
  /// Clear all app state including authentication, groups, and other user data
  static Future<void> clearAllAppState(WidgetRef ref) async {
    try {
      // Notify backend so the token is revoked server-side (best-effort).
      try {
        await ref.read(authRepositoryProvider).logout();
      } catch (_) {
        // Ignore network errors; continue clearing local state.
      }

      // Stop safety radius monitoring
      SafetyRadiusAlarmService().stopMonitoring();

      // Stop background location tracking
      await stopBackgroundLocationTracking();

      await NotificationService().clearPushRegistration();

      // Clear authentication data
      await AuthService.logout();

      // Clear Dio tokens
      DioHelper.instance.clearTokens();

      // Reset every provider that caches user-specific data so the next
      // user (or guest) starts from a clean state.
      _resetUserDataProviders(ref);
    } catch (e) {
      debugPrint('Error clearing app state: $e');
      // Even if there's an error, try to clear what we can
      await AuthService.clearAll();
      DioHelper.instance.clearTokens();
      try {
        _resetUserDataProviders(ref);
      } catch (_) {}
    }
  }

  /// Refresh user-specific providers after a successful login so screens that
  /// were first built as a guest (and cached 401/empty state) reload with the
  /// new auth token. Safe to call from any login success path.
  static void refreshUserDataAfterLogin(WidgetRef ref) {
    try {
      // Flip the reactive login flag so guest screens rebuild as authenticated.
      ref.read(authStateProvider.notifier).refresh();
      _resetUserDataProviders(ref);
    } catch (e) {
      debugPrint('Error refreshing user data after login: $e');
    }
  }

  /// Invalidate/clear all providers that hold data tied to the logged-in user.
  static void _resetUserDataProviders(WidgetRef ref) {
    // Keep the reactive login flag in sync with persisted state.
    ref.read(authStateProvider.notifier).refresh();

    // Groups exposes an explicit clear that also cancels listeners.
    ref.read(groupsControllerProvider.notifier).clearAllData();

    // Invalidate the rest so they rebuild fresh on next access.
    ref.invalidate(remindersProvider);
    ref.invalidate(bagControllerProvider);
    ref.invalidate(smartBagListControllerProvider);
    ref.invalidate(smartBagDetailControllerProvider);
    ref.invalidate(profileControllerProvider);
    ref.invalidate(vendorServicesProvider);
    ref.invalidate(emergencyControllerProvider);
    ref.invalidate(userQrControllerProvider);
  }

  /// Clear only authentication data (for partial logout)
  static Future<void> clearAuthData() async {
    await AuthService.logout();
    DioHelper.instance.clearTokens();
  }
}
