// core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:season_app/features/auth/presentation/screens/login_screen.dart';
import 'package:season_app/features/digital_directory/providers/digital_directory_providers.dart';
import 'package:season_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:season_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:season_app/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:season_app/features/profile/presentation/screens/webview_screen.dart';
import 'package:season_app/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:season_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:season_app/features/auth/presentation/screens/verify_reset_otp_screen.dart';
import 'package:season_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:season_app/features/home/presentation/screens/main_screen.dart';
import 'package:season_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:season_app/features/profile/presentation/screens/settings_screen.dart';
import 'package:season_app/features/vendor/presentation/screens/vendor_services_list_screen.dart';
import 'package:season_app/features/vendor/presentation/screens/vendor_service_form_screen.dart';
import 'package:season_app/features/vendor/presentation/screens/vendor_service_details_screen.dart';
import 'package:season_app/features/vendor/presentation/screens/public_vendor_services_screen.dart';
import 'package:season_app/features/vendor/presentation/screens/public_vendor_service_details_screen.dart';
import 'package:season_app/features/vendor/presentation/screens/location_picker_screen.dart';
import 'package:season_app/features/groups/presentation/screens/groups_list_screen.dart';
import 'package:season_app/features/groups/presentation/screens/group_details_screen.dart';
import 'package:season_app/features/groups/presentation/screens/create_group_screen.dart';
import 'package:season_app/features/groups/presentation/screens/join_group_screen.dart';
import 'package:season_app/features/groups/presentation/screens/qr_scanner_screen.dart';
import 'package:season_app/features/groups/presentation/screens/edit_group_screen.dart';
import 'package:season_app/features/groups/presentation/screens/sos_alerts_screen.dart';
import 'package:season_app/features/emergency/presentation/screens/emergency_screen.dart';
import 'package:season_app/features/currency/presentation/screens/currency_converter_screen.dart';
import 'package:season_app/features/digital_directory/presentation/screens/categories_screen.dart';
import 'package:season_app/features/digital_directory/presentation/screens/category_apps_screen.dart';
import 'package:season_app/features/geographical_guides/presentation/screens/geographical_directory_screen.dart';
import 'package:season_app/features/geographical_guides/presentation/screens/apply_as_trader_screen.dart';
import 'package:season_app/features/geographical_guides/presentation/screens/my_geographical_services_screen.dart';
import 'package:season_app/features/geographical_guides/presentation/screens/geographical_guide_details_screen.dart';
import 'package:season_app/features/auth/presentation/screens/connection_error_screen.dart';
import 'package:season_app/core/services/app_config_service.dart';
import 'package:season_app/core/utils/auth_gate.dart';
import 'package:season_app/core/services/dio_client.dart';
import 'package:season_app/core/services/notification_navigation_service.dart';
import 'package:season_app/core/services/session_expired_navigation_service.dart';
import 'package:season_app/features/home/presentation/screens/bag_detail_screen.dart';
import 'package:season_app/features/home/presentation/screens/bag_analysis_screen.dart';
import 'package:season_app/features/home/presentation/screens/create_bag_screen.dart';
import 'package:season_app/features/home/presentation/screens/edit_bag_screen.dart';
import 'package:season_app/features/home/presentation/screens/add_item_screen.dart';
import 'package:season_app/features/home/data/models/bag_detail_model.dart';

import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: Routes.splash,
    debugLogDiagnostics: true,
    // refreshListenable: GoRouterRefreshStream(
      // ref.watch(authControllerProvider.notifier).authStateChanges,
    // ),
    redirect: (context, state) async {
      if (state.uri.path != Routes.connectionError) {
        await AppConfigService.forceRefresh();
      }
      
      final apiTimeout = AppConfigService.getApiTimeout();
      if (apiTimeout == 0 || AppConfigService.hasConnectionIssue()) {
        return Routes.connectionError;
      }

      final guestRedirect = AuthGate.guestRedirect(state.uri.path);
      if (guestRedirect != null) {
        return guestRedirect;
      }
      
      return null;
    
      // final user = ref.read(authControllerProvider).valueOrNull;
      // final isLoggingIn = state.location == Routes.login;
      //
      // // المستخدم مش داخل → رجعه على login
      // if (user == null && !isLoggingIn) return Routes.login;
      //
      // // المستخدم داخل → ميخشّش login تاني
      // if (user != null && isLoggingIn) return Routes.home;
      //
      // return null;
    },
    routes: [
      GoRoute(
        path: Routes.connectionError,
        builder: (context, state) => const ConnectionErrorScreen(),
      ),
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: Routes.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: Routes.verifyOtp,
        builder: (context, state) {
          final returnTo = state.uri.queryParameters['from'];
          return VerifyOtpScreen(returnTo: returnTo);
        },
      ),
      GoRoute(
        path: Routes.webview,
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? '';
          final title = state.uri.queryParameters['title'] ?? '';
          return WebViewScreen(url: url, title: title);
        },
      ),
      
      // Forgot Password Routes
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: Routes.verifyResetOtp,
        builder: (context, state) => const VerifyResetOtpScreen(),
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      
      // Home Route (supports tab query parameter: ?tab=bag|reminders|groups|profile)
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          final tabParam = state.uri.queryParameters['tab'];
          return MainScreen(initialTab: tabParam);
        },
      ),
      
      // Profile Routes
      GoRoute(
        path: Routes.profileEdit,
        builder: (context, state) => const EditProfileScreen(),
      ),
      
      // Settings Route
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Emergency Route
      GoRoute(
        path: Routes.emergency,
        builder: (context, state) => const EmergencyScreen(),
      ),

      // Currency Converter Route
      GoRoute(
        path: Routes.currencyConverter,
        builder: (context, state) => const CurrencyConverterScreen(),
      ),

      // Vendor Services
      GoRoute(
        path: Routes.vendorServices,
        builder: (context, state) => const VendorServicesListScreen(),
      ),
      GoRoute(
        path: Routes.vendorServiceNew,
        builder: (context, state) => const VendorServiceFormScreen(),
      ),
      // Public Vendor Services - Must come before /vendor/services/:id to avoid route conflicts
      GoRoute(
        path: Routes.publicVendorServices,
        builder: (context, state) => const PublicVendorServicesScreen(),
      ),
      GoRoute(
        path: Routes.publicVendorServiceDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return PublicVendorServiceDetailsScreen(serviceId: id);
        },
      ),
      GoRoute(
        path: Routes.vendorServiceEdit,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return VendorServiceFormScreen(serviceId: id);
        },
      ),
      GoRoute(
        path: Routes.vendorServiceDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return VendorServiceDetailsScreen(serviceId: id);
        },
      ),
      GoRoute(
        path: Routes.locationPicker,
        builder: (context, state) {
          final lat = double.tryParse(state.uri.queryParameters['lat'] ?? '0') ?? 0;
          final lng = double.tryParse(state.uri.queryParameters['lng'] ?? '0') ?? 0;
          return LocationPickerScreen(initialLat: lat, initialLng: lng);
        },
      ),
      // Digital Directory
      GoRoute(
        path: Routes.categories,
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: Routes.categoryApps,
        builder: (context, state) {
          final categoryId = int.parse(state.pathParameters['id']!);
          // Get category name from provider
          return Consumer(
            builder: (context, ref, child) {
              final categoriesAsync = ref.watch(categoriesProvider);
              return categoriesAsync.when(
                loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
                error: (e, s) => Scaffold(body: Center(child: Text(e.toString()))),
                data: (categories) {
                  final category = categories.firstWhere(
                    (c) => c.id == categoryId,
                    orElse: () => categories.first,
                  );
                  return CategoryAppsScreen(
                    categoryId: categoryId,
                    categoryName: category.name,
                  );
                },
              );
            },
          );
        },
      ),
      
      // Groups Routes - Order matters! Specific routes before :id pattern
      GoRoute(
        path: '/groups',
        builder: (context, state) => const GroupsListScreen(),
      ),
      GoRoute(
        path: '/groups/create',
        builder: (context, state) => const CreateGroupScreen(),
      ),
      GoRoute(
        path: '/groups/join',
        builder: (context, state) => const JoinGroupScreen(),
      ),
      GoRoute(
        path: '/groups/qr-scanner',
        builder: (context, state) => const QRScannerScreen(),
      ),
      GoRoute(
        path: '/groups/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return GroupDetailsScreen(groupId: id);
        },
      ),
      GoRoute(
        path: '/groups/:id/edit',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return EditGroupScreen(groupId: id);
        },
      ),
      GoRoute(
        path: '/groups/:id/sos',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return SosAlertsScreen(groupId: id);
        },
      ),
      
      // Geographical Guides Routes
      // IMPORTANT: More specific routes must come before parameterized routes
      GoRoute(
        path: Routes.geographicalDirectory,
        builder: (context, state) => const GeographicalDirectoryScreen(),
      ),
      GoRoute(
        path: Routes.applyAsTrader,
        builder: (context, state) => const MyGeographicalServicesScreen(),
      ),
      GoRoute(
        path: Routes.myGeographicalServices,
        builder: (context, state) => const MyGeographicalServicesScreen(),
      ),
      GoRoute(
        path: Routes.myGeographicalServiceDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return GeographicalGuideDetailsScreen(guideId: id, isMyService: true);
        },
      ),
      GoRoute(
        path: Routes.newGeographicalGuide,
        builder: (context, state) => const ApplyAsTraderScreen(),
      ),
      GoRoute(
        path: Routes.editGeographicalGuide,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ApplyAsTraderScreen(guideId: id);
        },
      ),
      GoRoute(
        path: Routes.geographicalGuideDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return GeographicalGuideDetailsScreen(guideId: id);
        },
      ),
      
      // Bag Routes
      GoRoute(
        path: Routes.createBag,
        builder: (context, state) => const CreateBagScreen(),
      ),
      GoRoute(
        path: Routes.bagDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return BagDetailScreen(bagId: id);
        },
      ),
      GoRoute(
        path: Routes.bagAnalysis,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final analysisData = state.extra as Map<String, dynamic>? ?? {};
          return BagAnalysisScreen(bagId: id, analysisData: analysisData);
        },
      ),
      GoRoute(
        path: Routes.editBag,
        builder: (context, state) {
          final bag = state.extra as BagDetailModel;
          return EditBagScreen(bag: bag);
        },
      ),
      GoRoute(
        path: Routes.addItems,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return AddItemScreen(bagId: id);
        },
      ),
    ],
  );
  SessionExpiredNavigationService.register(
    router: router,
    clearDioTokens: () => DioHelper.instance.clearTokens(),
  );
  NotificationNavigationService.register(router);
  return router;
});
