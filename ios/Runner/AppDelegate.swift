import Flutter
import UIKit
import CoreLocation
import UserNotifications
import FirebaseMessaging

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Configure Firebase Messaging delegate for native alarm handling
    Messaging.messaging().delegate = self
    
    // Request notification permissions
    UNUserNotificationCenter.current().delegate = self
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let locationServiceChannel = FlutterMethodChannel(name: "season_app/location_service",
                                                     binaryMessenger: controller.binaryMessenger)
    locationServiceChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "startLocationService":
        LocationUpdateService.shared.startLocationUpdates()
        result("Location service started")
      case "stopLocationService":
        LocationUpdateService.shared.stopLocationUpdates()
        result("Location service stopped")
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    // Note: Native location service is started via method channel from Flutter
    // Don't start automatically here to avoid starting before user is logged in
    let mapsChannel = FlutterMethodChannel(name: "season_app/maps",
                                          binaryMessenger: controller.binaryMessenger)
    mapsChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "launchAppleMaps":
        if let args = call.arguments as? [String: Any],
           let latitude = args["latitude"] as? Double,
           let longitude = args["longitude"] as? Double {
          self.launchAppleMaps(latitude: latitude, longitude: longitude, result: result)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENTS", message: "Latitude and longitude are required", details: nil))
        }
      case "launchGoogleMaps":
        if let args = call.arguments as? [String: Any],
           let latitude = args["latitude"] as? Double,
           let longitude = args["longitude"] as? Double {
          self.launchGoogleMaps(latitude: latitude, longitude: longitude, result: result)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENTS", message: "Latitude and longitude are required", details: nil))
        }
      case "launchUrl":
        if let args = call.arguments as? [String: Any],
           let url = args["url"] as? String {
          self.launchUrl(url: url, result: result)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENTS", message: "URL is required", details: nil))
        }
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func launchAppleMaps(latitude: Double, longitude: Double, result: @escaping FlutterResult) {
    let urlString = "http://maps.apple.com/?q=\(latitude),\(longitude)"
    if let url = URL(string: urlString) {
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: { success in
          if success {
            result("Apple Maps launched successfully")
          } else {
            result(FlutterError(code: "LAUNCH_ERROR", message: "Failed to launch Apple Maps", details: nil))
          }
        })
      } else {
        result(FlutterError(code: "APP_NOT_FOUND", message: "Apple Maps not available", details: nil))
      }
    } else {
      result(FlutterError(code: "INVALID_URL", message: "Invalid URL format", details: nil))
    }
  }
  
  private func launchGoogleMaps(latitude: Double, longitude: Double, result: @escaping FlutterResult) {
    let urlString = "comgooglemaps://?q=\(latitude),\(longitude)"
    if let url = URL(string: urlString) {
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: { success in
          if success {
            result("Google Maps launched successfully")
          } else {
            result(FlutterError(code: "LAUNCH_ERROR", message: "Failed to launch Google Maps", details: nil))
          }
        })
      } else {
        // Fallback to web version
        let webUrlString = "https://www.google.com/maps/search/?api=1&query=\(latitude),\(longitude)"
        if let webUrl = URL(string: webUrlString) {
          UIApplication.shared.open(webUrl, options: [:], completionHandler: { success in
            if success {
              result("Google Maps web launched successfully")
            } else {
              result(FlutterError(code: "LAUNCH_ERROR", message: "Failed to launch Google Maps web", details: nil))
            }
          })
        } else {
          result(FlutterError(code: "INVALID_URL", message: "Invalid web URL format", details: nil))
        }
      }
    } else {
      result(FlutterError(code: "INVALID_URL", message: "Invalid URL format", details: nil))
    }
  }
  
  private func launchUrl(url: String, result: @escaping FlutterResult) {
    if let urlObj = URL(string: url) {
      if UIApplication.shared.canOpenURL(urlObj) {
        UIApplication.shared.open(urlObj, options: [:], completionHandler: { success in
          if success {
            result("URL launched successfully")
          } else {
            result(FlutterError(code: "LAUNCH_ERROR", message: "Failed to launch URL", details: nil))
          }
        })
      } else {
        result(FlutterError(code: "NO_BROWSER", message: "No browser available", details: nil))
      }
    } else {
      result(FlutterError(code: "INVALID_URL", message: "Invalid URL format", details: nil))
    }
  }
}

// MARK: - Firebase Messaging Delegate
extension AppDelegate: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("📱 Firebase registration token: \(fcmToken ?? "nil")")
    // Token is also handled by Flutter FirebaseMessaging plugin
  }
}

// MARK: - UNUserNotificationCenterDelegate
// Note: FlutterAppDelegate already conforms to UNUserNotificationCenterDelegate,
// so these methods must use `override` and the conformance must not be redeclared.
extension AppDelegate {
  // Handle notification when app is in foreground or terminated
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    let userInfo = notification.request.content.userInfo
    print("📩 Notification received (app in foreground)")
    print("   UserInfo: \(userInfo)")
    
    // Check if this is an alarm
    let isAlarm = userInfo["type"] as? String == "safety_radius_alert" ||
                  userInfo["notification_type"] as? String == "safety_radius_alert"
    
    // Verify admin status
    let isAdmin = userInfo["is_admin"] as? String == "true" ||
                  userInfo["is_owner"] as? String == "true" ||
                  userInfo["for_admin"] as? String == "true"
    
    if isAlarm && isAdmin {
      print("🚨 Alarm notification detected - showing with critical sound")
      // Show notification with sound even in foreground
      if #available(iOS 14.0, *) {
        completionHandler([.banner, .sound, .badge, .list])
      } else {
        completionHandler([.alert, .sound, .badge])
      }
    } else {
      // Regular notification
      if #available(iOS 14.0, *) {
        completionHandler([.banner, .sound, .badge])
      } else {
        completionHandler([.alert, .sound, .badge])
      }
    }
  }
  
  // Handle notification tap (when app is terminated and user taps notification)
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    let userInfo = response.notification.request.content.userInfo
    print("📱 Notification tapped: \(userInfo)")
    
    // Handle navigation based on notification data
    // This is also handled by Flutter's notification tap handler
    completionHandler()
  }
  
  // Handle notification when app is launched from terminated state
  override func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable: Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
  ) {
    print("📩 Remote notification received (app terminated)")
    print("   UserInfo: \(userInfo)")
    
    // Check if this is a safety radius alarm
    let isSafetyRadiusAlarm = userInfo["type"] as? String == "safety_radius_alert" ||
                              userInfo["notification_type"] as? String == "safety_radius_alert"
    
    // Verify admin status
    let isAdmin = userInfo["is_admin"] as? String == "true" ||
                  userInfo["is_owner"] as? String == "true" ||
                  userInfo["for_admin"] as? String == "true"
    
    if isSafetyRadiusAlarm && isAdmin {
      print("🚨 Safety radius alarm detected - showing native notification")
      showAlarmNotification(userInfo: userInfo)
    }
    
    completionHandler(.newData)
  }
  
  private func showAlarmNotification(userInfo: [AnyHashable: Any]) {
    // Extract title and body
    let title = userInfo["title"] as? String ?? "🚨 Safety Alert"
    let body = userInfo["body"] as? String ?? "A group member is outside the safety radius!"
    
    // Create notification content
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.defaultCritical // Critical sound for alarm
    content.categoryIdentifier = "ALARM"
    content.userInfo = userInfo as! [String: Any]
    
    // Set interruption level to critical for iOS 15+
    if #available(iOS 15.0, *) {
      content.interruptionLevel = .critical
    }
    
    // Create notification request
    let request = UNNotificationRequest(
      identifier: "safety_radius_alarm_\(Date().timeIntervalSince1970)",
      content: content,
      trigger: nil // Show immediately
    )
    
    // Add notification to center
    UNUserNotificationCenter.current().add(request) { error in
      if let error = error {
        print("❌ Error showing alarm notification: \(error.localizedDescription)")
      } else {
        print("✅ Alarm notification shown: \(title)")
      }
    }
  }
}
