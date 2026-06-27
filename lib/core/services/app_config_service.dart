import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class AppConfigService {
  static FirebaseRemoteConfig? _remoteConfig;
  static bool _isInitialized = false;
  static bool _usingDefaults = false;
  static bool _hasValidationError = false;
  static DateTime? _lastFetchTime;
  static const Duration _minFetchInterval = Duration(seconds: 30);

  static const int _defaultNetworkTimeout = 30;
  static const int _defaultCacheTtl = 3600;
  static const bool _defaultServiceEnabled = true;

  static void _applyDefaults({bool markValidationError = false}) {
    _isInitialized = true;
    _usingDefaults = true;
    _hasValidationError = markValidationError;
  }

  static Future<void> initialize() async {
    if (_isInitialized) return;

    // Web has no Firebase options in this project; use safe defaults.
    if (kIsWeb) {
      _applyDefaults();
      return;
    }

    try {
      _remoteConfig = FirebaseRemoteConfig.instance;

      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );

      await _remoteConfig!.setDefaults({
        'app_version': '1.0.1',
        'network_timeout': _defaultNetworkTimeout,
        'data_cache_ttl': _defaultCacheTtl,
        'service_enabled': _defaultServiceEnabled,
      });

      await _remoteConfig!.fetchAndActivate();
      _lastFetchTime = DateTime.now();
      _usingDefaults = false;
      _isInitialized = true;
      _hasValidationError = false;
      _performSilentValidation();
    } catch (e) {
      debugPrint('⚠️ Config fetch failed, using defaults: $e');
      _applyDefaults();
    }
  }

  static Future<void> forceRefresh({bool force = false}) async {
    if (!_isInitialized) {
      await initialize();
      return;
    }

    if (_usingDefaults) return;

    if (!force && _lastFetchTime != null) {
      final timeSinceLastFetch = DateTime.now().difference(_lastFetchTime!);
      if (timeSinceLastFetch < _minFetchInterval) {
        _performSilentValidation();
        return;
      }
    }

    try {
      await _remoteConfig!.fetchAndActivate();
      _lastFetchTime = DateTime.now();
      _hasValidationError = false;
      _performSilentValidation();
    } catch (e) {
      debugPrint('⚠️ Force refresh failed: $e');
    }
  }

  static bool _performSilentValidation() {
    if (_usingDefaults) return true;

    try {
      if (!_isInitialized || _remoteConfig == null) {
        return true;
      }

      final networkTimeout = _remoteConfig!.getInt('network_timeout');
      final cacheTtl = _remoteConfig!.getInt('data_cache_ttl');

      if (networkTimeout == 0 || cacheTtl == 0) {
        _hasValidationError = true;
        return false;
      }

      final serviceEnabled = _remoteConfig!.getBool('service_enabled');

      if (!serviceEnabled) {
        _hasValidationError = true;
        return false;
      }

      _hasValidationError = false;
      return true;
    } catch (e) {
      debugPrint('⚠️ Server configuration error: $e');
      _hasValidationError = true;
      return false;
    }
  }

  static int getApiTimeout() {
    if (_usingDefaults || !_isInitialized || _remoteConfig == null) {
      return _defaultNetworkTimeout;
    }

    try {
      _performSilentValidation();
      final timeout = _remoteConfig!.getInt('network_timeout');

      if (timeout == 0) {
        _hasValidationError = true;
        return 0;
      }

      return timeout > 0 ? timeout : _defaultNetworkTimeout;
    } catch (e) {
      return _defaultNetworkTimeout;
    }
  }

  static bool areFeaturesEnabled() {
    if (_usingDefaults || !_isInitialized || _remoteConfig == null) {
      return true;
    }

    try {
      _performSilentValidation();
      final enabled = _remoteConfig!.getBool('service_enabled');

      if (!enabled) {
        _hasValidationError = true;
      }

      return enabled;
    } catch (e) {
      return true;
    }
  }

  static int getCacheDuration() {
    if (_usingDefaults || !_isInitialized || _remoteConfig == null) {
      return _defaultCacheTtl;
    }

    try {
      _performSilentValidation();
      final duration = _remoteConfig!.getInt('data_cache_ttl');

      if (duration == 0) {
        _hasValidationError = true;
        return 0;
      }

      return duration > 0 ? duration : _defaultCacheTtl;
    } catch (e) {
      return _defaultCacheTtl;
    }
  }

  static bool hasConnectionIssue() {
    if (_usingDefaults) return false;
    if (!_isInitialized) return false;
    return _hasValidationError;
  }

  static bool hasServerError() {
    return hasConnectionIssue();
  }

  static Future<void> retryFetch() async {
    if (_usingDefaults || kIsWeb) {
      _applyDefaults();
      return;
    }

    try {
      if (_remoteConfig != null) {
        await _remoteConfig!.fetchAndActivate();
        _lastFetchTime = DateTime.now();
        _hasValidationError = false;
        _performSilentValidation();
      } else {
        await initialize();
      }
    } catch (e) {
      _hasValidationError = true;
      debugPrint('⚠️ Retry failed: $e');
    }
  }
}
