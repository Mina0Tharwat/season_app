import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_app/core/services/auth_service.dart';

/// Reactive login state. Screens that show guest prompts should `ref.watch`
/// this instead of calling [AuthService.isLoggedIn] directly, so they rebuild
/// immediately after a login or logout.
class AuthStateNotifier extends Notifier<bool> {
  @override
  bool build() => AuthService.isLoggedIn();

  /// Re-read the persisted login flag and notify listeners.
  void refresh() {
    state = AuthService.isLoggedIn();
  }
}

final authStateProvider =
    NotifierProvider<AuthStateNotifier, bool>(AuthStateNotifier.new);
