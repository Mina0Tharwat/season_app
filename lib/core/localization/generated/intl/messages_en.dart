// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(weight) => "Approximate weight: ${weight} kg";

  static String m1(count) => "${count} active";

  static String m2(current, max) => "${current} / ${max} kg";

  static String m3(userName) => "Hello ${userName}!";

  static String m4(maxWeight, currentWeight, itemWeight) =>
      "The total weight will exceed the maximum allowed weight (${maxWeight} kg). Current weight: ${currentWeight} kg. Item weight: ${itemWeight} kg.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "aboutApp": MessageLookupByLibrary.simpleMessage("About App"),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "accountStatistics": MessageLookupByLibrary.simpleMessage(
      "Account Statistics",
    ),
    "activeAlerts": MessageLookupByLibrary.simpleMessage("Active Alerts"),
    "addDescription": MessageLookupByLibrary.simpleMessage("Add a description"),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "ago": MessageLookupByLibrary.simpleMessage("ago"),
    "alertFrom": MessageLookupByLibrary.simpleMessage("Alert from"),
    "alertMessage": MessageLookupByLibrary.simpleMessage("Message"),
    "alertResolved": MessageLookupByLibrary.simpleMessage("Alert Resolved"),
    "alertResolvedMessage": MessageLookupByLibrary.simpleMessage(
      "Emergency alert has been resolved",
    ),
    "alertTime": MessageLookupByLibrary.simpleMessage("Alert Time"),
    "alerts": MessageLookupByLibrary.simpleMessage("Alerts"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Season App"),
    "applyAsServiceProvider": MessageLookupByLibrary.simpleMessage(
      "Apply as Service Provider",
    ),
    "applyAsTrader": MessageLookupByLibrary.simpleMessage("Apply as Trader"),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "areYouSureDelete": MessageLookupByLibrary.simpleMessage("Delete service?"),
    "areYouSureDeleteMessage": MessageLookupByLibrary.simpleMessage(
      "This will permanently remove the service.",
    ),
    "askForCode": MessageLookupByLibrary.simpleMessage(
      "Or ask for code from group owner",
    ),
    "availablePoints": MessageLookupByLibrary.simpleMessage("available points"),
    "backToHome": MessageLookupByLibrary.simpleMessage("Back to Home"),
    "bag": MessageLookupByLibrary.simpleMessage("Bag"),
    "bagAISuggestionsButton": MessageLookupByLibrary.simpleMessage(
      "AI suggestions",
    ),
    "bagAddItemButton": MessageLookupByLibrary.simpleMessage("Add item"),
    "bagAddItemError": MessageLookupByLibrary.simpleMessage(
      "Failed to add item. Please try again.",
    ),
    "bagAddItemSubmit": MessageLookupByLibrary.simpleMessage("Add to bag"),
    "bagAddItemSuccess": MessageLookupByLibrary.simpleMessage(
      "Item added successfully.",
    ),
    "bagAddItemTitle": MessageLookupByLibrary.simpleMessage("Add item"),
    "bagAddReminderButton": MessageLookupByLibrary.simpleMessage(
      "Add reminder",
    ),
    "bagApproxWeight": m0,
    "bagCategoriesTitle": MessageLookupByLibrary.simpleMessage("Categories"),
    "bagDeleteCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "bagDeleteConfirm": MessageLookupByLibrary.simpleMessage("Delete"),
    "bagDeleteItemError": MessageLookupByLibrary.simpleMessage(
      "Failed to remove item. Please try again.",
    ),
    "bagDeleteItemMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to remove this item from your bag?",
    ),
    "bagDeleteItemSuccess": MessageLookupByLibrary.simpleMessage(
      "Item removed successfully.",
    ),
    "bagDeleteItemTitle": MessageLookupByLibrary.simpleMessage("Remove item?"),
    "bagDeleteReminderMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this reminder?",
    ),
    "bagDeleteReminderTitle": MessageLookupByLibrary.simpleMessage(
      "Delete reminder?",
    ),
    "bagDeleteSuccess": MessageLookupByLibrary.simpleMessage(
      "Reminder deleted successfully.",
    ),
    "bagEditMaxWeight": MessageLookupByLibrary.simpleMessage("Edit Max Weight"),
    "bagEmptyDescription": MessageLookupByLibrary.simpleMessage(
      "Start adding your essentials to get travel-ready.",
    ),
    "bagEmptyTitle": MessageLookupByLibrary.simpleMessage("Your bag is empty"),
    "bagItemsEmpty": MessageLookupByLibrary.simpleMessage(
      "No items to show in this category yet.",
    ),
    "bagItemsError": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t load items for this category.",
    ),
    "bagItemsTitle": MessageLookupByLibrary.simpleMessage("Suggested items"),
    "bagLoadingItems": MessageLookupByLibrary.simpleMessage("Loading items..."),
    "bagMaxWeightInfo": MessageLookupByLibrary.simpleMessage(
      "Adjust the maximum weight limit for your bag. The weight is always measured in kilograms.",
    ),
    "bagMaxWeightInvalid": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid weight",
    ),
    "bagMaxWeightLabel": MessageLookupByLibrary.simpleMessage("Max Weight"),
    "bagMaxWeightPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Enter max weight",
    ),
    "bagMaxWeightRequired": MessageLookupByLibrary.simpleMessage(
      "Max weight is required",
    ),
    "bagMaxWeightUpdated": MessageLookupByLibrary.simpleMessage(
      "Max weight updated successfully",
    ),
    "bagNoCategories": MessageLookupByLibrary.simpleMessage(
      "No categories available yet.",
    ),
    "bagNoItems": MessageLookupByLibrary.simpleMessage(
      "No items available for this category.",
    ),
    "bagPageContent": MessageLookupByLibrary.simpleMessage(
      "Your shopping bag items",
    ),
    "bagQuantityLabel": MessageLookupByLibrary.simpleMessage("Quantity"),
    "bagRemindersActiveCount": m1,
    "bagRemindersEmptyDescription": MessageLookupByLibrary.simpleMessage(
      "Tap \"Add reminder\" to create your first travel reminder.",
    ),
    "bagRemindersEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "No reminders yet",
    ),
    "bagRemindersTitle": MessageLookupByLibrary.simpleMessage("Reminders"),
    "bagSelectCategory": MessageLookupByLibrary.simpleMessage("Category"),
    "bagSelectCategoryPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Select category",
    ),
    "bagSelectItem": MessageLookupByLibrary.simpleMessage("Item"),
    "bagSelectItemPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Select item",
    ),
    "bagSelectWeightUnit": MessageLookupByLibrary.simpleMessage(
      "Select weight unit",
    ),
    "bagSubtitle": MessageLookupByLibrary.simpleMessage("Main checked luggage"),
    "bagTip1": MessageLookupByLibrary.simpleMessage(
      "Place heavier items at the bottom of your bag.",
    ),
    "bagTip2": MessageLookupByLibrary.simpleMessage(
      "Roll clothes instead of folding to save space.",
    ),
    "bagTip3": MessageLookupByLibrary.simpleMessage(
      "Keep valuable items in your carry-on.",
    ),
    "bagTip4": MessageLookupByLibrary.simpleMessage(
      "Double-check your airline\'s weight allowance.",
    ),
    "bagTipsTitle": MessageLookupByLibrary.simpleMessage("Packing tips"),
    "bagTitle": MessageLookupByLibrary.simpleMessage("Travel Bag"),
    "bagTotalWeightLabel": MessageLookupByLibrary.simpleMessage("Total weight"),
    "bagTypesTitle": MessageLookupByLibrary.simpleMessage("Bag types"),
    "bagUpdateQuantityError": MessageLookupByLibrary.simpleMessage(
      "Failed to update quantity. Please try again.",
    ),
    "bagUpdateQuantitySuccess": MessageLookupByLibrary.simpleMessage(
      "Quantity updated successfully.",
    ),
    "bagWeight": m2,
    "bagWeightUnitKg": MessageLookupByLibrary.simpleMessage("kg"),
    "bagWeightUnitLabel": MessageLookupByLibrary.simpleMessage("Weight Unit"),
    "birthDate": MessageLookupByLibrary.simpleMessage("Birth Date"),
    "camera": MessageLookupByLibrary.simpleMessage("Camera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "card": MessageLookupByLibrary.simpleMessage("Card"),
    "cardPageContent": MessageLookupByLibrary.simpleMessage(
      "Manage your cards here",
    ),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Change Photo"),
    "chooseFile": MessageLookupByLibrary.simpleMessage("Choose file"),
    "city": MessageLookupByLibrary.simpleMessage("City"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "codeNotSent": MessageLookupByLibrary.simpleMessage("Code not sent?"),
    "coins": MessageLookupByLibrary.simpleMessage("Coins"),
    "collectPoints": MessageLookupByLibrary.simpleMessage(
      "Collect loyalty points when browsing and using partner services",
    ),
    "commercialRegister": MessageLookupByLibrary.simpleMessage(
      "Commercial Register (PDF)",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmNewPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Confirm new password is required",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Confirm password is required",
    ),
    "confirmResolve": MessageLookupByLibrary.simpleMessage("Resolve Alert?"),
    "confirmResolveMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to mark this alert as resolved?",
    ),
    "connectionErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Unable to establish connection with server.\nPlease check your internet connection and try again.",
    ),
    "connectionErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Connection Error",
    ),
    "connectionFailed": MessageLookupByLibrary.simpleMessage(
      "Connection failed. Please try again later.",
    ),
    "contactEmailAddress": MessageLookupByLibrary.simpleMessage(
      "support@seasonksa.com",
    ),
    "contactSupportTitle": MessageLookupByLibrary.simpleMessage(
      "Choose how to contact us",
    ),
    "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "contactUsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Contact support via email or WhatsApp",
    ),
    "contactViaEmail": MessageLookupByLibrary.simpleMessage(
      "Contact via email",
    ),
    "contactViaWhatsApp": MessageLookupByLibrary.simpleMessage(
      "Contact via WhatsApp",
    ),
    "copied": MessageLookupByLibrary.simpleMessage("Copied!"),
    "copy": MessageLookupByLibrary.simpleMessage("Copy"),
    "country": MessageLookupByLibrary.simpleMessage("Country"),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "createGroup": MessageLookupByLibrary.simpleMessage("Create Group"),
    "createGroupDescription": MessageLookupByLibrary.simpleMessage(
      "Create a group to track your friends and family",
    ),
    "createNewGroup": MessageLookupByLibrary.simpleMessage(
      "Create a new group\nor join an existing one",
    ),
    "createNewGroupTitle": MessageLookupByLibrary.simpleMessage(
      "Create New Group",
    ),
    "createService": MessageLookupByLibrary.simpleMessage("Create a service"),
    "currency": MessageLookupByLibrary.simpleMessage("Currency"),
    "currencyAmount": MessageLookupByLibrary.simpleMessage("Amount"),
    "currencyAmountInvalid": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid amount",
    ),
    "currencyAmountPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Enter amount",
    ),
    "currencyAmountRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter an amount",
    ),
    "currencyConvert": MessageLookupByLibrary.simpleMessage("Convert"),
    "currencyConvertedAmount": MessageLookupByLibrary.simpleMessage(
      "Converted Amount",
    ),
    "currencyConverter": MessageLookupByLibrary.simpleMessage(
      "Currency Converter",
    ),
    "currencyConverterSubtitle": MessageLookupByLibrary.simpleMessage(
      "Convert currencies instantly",
    ),
    "currencyExchangeRate": MessageLookupByLibrary.simpleMessage(
      "Indicative Exchange Rate",
    ),
    "currencyFrom": MessageLookupByLibrary.simpleMessage("From"),
    "currencyRate": MessageLookupByLibrary.simpleMessage("Rate"),
    "currencyTo": MessageLookupByLibrary.simpleMessage("To"),
    "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "days": MessageLookupByLibrary.simpleMessage("days"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete Account"),
    "deleteAccountConfirmButton": MessageLookupByLibrary.simpleMessage(
      "Yes, delete account",
    ),
    "deleteAccountConfirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete your account?",
    ),
    "deleteAccountFailure": MessageLookupByLibrary.simpleMessage(
      "Could not delete account. Please try again.",
    ),
    "deleteAccountSubtitle": MessageLookupByLibrary.simpleMessage(
      "Permanently remove your account and all data",
    ),
    "deleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Your account has been deleted successfully",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "This action cannot be undone. All your data will be permanently deleted.",
    ),
    "deleteGroup": MessageLookupByLibrary.simpleMessage("Delete Group"),
    "deletePermanently": MessageLookupByLibrary.simpleMessage(
      "Delete permanently",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage(
      "Description (Optional)",
    ),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "digitalDirectory": MessageLookupByLibrary.simpleMessage(
      "Digital Directory",
    ),
    "directions": MessageLookupByLibrary.simpleMessage("Directions"),
    "directionsDescription": MessageLookupByLibrary.simpleMessage(
      "Get directions to this emergency location using your preferred maps app",
    ),
    "directionsToAlert": MessageLookupByLibrary.simpleMessage(
      "Directions to Emergency Location",
    ),
    "disable": MessageLookupByLibrary.simpleMessage("Disable"),
    "distance": MessageLookupByLibrary.simpleMessage("Distance"),
    "distanceAllowed": MessageLookupByLibrary.simpleMessage(
      "Distance allowed before sending alert",
    ),
    "dontGetLost": MessageLookupByLibrary.simpleMessage("Don\'t Get Lost"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "editService": MessageLookupByLibrary.simpleMessage("Edit Service"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailAppNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Could not open email app",
    ),
    "emailNotVerified": MessageLookupByLibrary.simpleMessage(
      "Email not verified",
    ),
    "emailNotifications": MessageLookupByLibrary.simpleMessage(
      "Email Notifications",
    ),
    "emailVerificationHint": MessageLookupByLibrary.simpleMessage(
      "Verify your email to secure your account",
    ),
    "emailVerificationSent": MessageLookupByLibrary.simpleMessage(
      "Verification code sent to your email",
    ),
    "emailVerified": MessageLookupByLibrary.simpleMessage("Email verified"),
    "emergencyAlerts": MessageLookupByLibrary.simpleMessage(
      "🚨 Emergency Alerts",
    ),
    "emergencyAmbulance": MessageLookupByLibrary.simpleMessage("Ambulance"),
    "emergencyEmbassy": MessageLookupByLibrary.simpleMessage("Embassy"),
    "emergencyError": MessageLookupByLibrary.simpleMessage(
      "Failed to load emergency numbers",
    ),
    "emergencyErrorDescription": MessageLookupByLibrary.simpleMessage(
      "Please check your internet connection and try again",
    ),
    "emergencyFire": MessageLookupByLibrary.simpleMessage("Fire Department"),
    "emergencyLocation": MessageLookupByLibrary.simpleMessage(
      "Emergency Location",
    ),
    "emergencyNumbers": MessageLookupByLibrary.simpleMessage(
      "Emergency Numbers",
    ),
    "emergencyPolice": MessageLookupByLibrary.simpleMessage("Police"),
    "emergencyQuickAccess": MessageLookupByLibrary.simpleMessage(
      "Tap to view emergency contacts",
    ),
    "emergencySubtitle": MessageLookupByLibrary.simpleMessage(
      "Quick access to emergency services",
    ),
    "enable": MessageLookupByLibrary.simpleMessage("Enable"),
    "enableNotifications": MessageLookupByLibrary.simpleMessage(
      "Enable Notifications",
    ),
    "endpoint": MessageLookupByLibrary.simpleMessage("Endpoint:"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterCodeManually": MessageLookupByLibrary.simpleMessage(
      "Enter Code Manually",
    ),
    "enterEmailToReceiveResetCode": MessageLookupByLibrary.simpleMessage(
      "Enter your email to receive reset code",
    ),
    "enterInviteCode": MessageLookupByLibrary.simpleMessage(
      "Enter the invite code to join the group",
    ),
    "enterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your new password",
    ),
    "errorDetails": MessageLookupByLibrary.simpleMessage("Error Details:"),
    "errorLoadingCardData": MessageLookupByLibrary.simpleMessage(
      "Error loading card data",
    ),
    "errorLoadingGroup": MessageLookupByLibrary.simpleMessage(
      "Error Loading Group",
    ),
    "errorLoadingProfile": MessageLookupByLibrary.simpleMessage(
      "Error loading profile",
    ),
    "errorUpdatingProfile": MessageLookupByLibrary.simpleMessage(
      "Error updating profile",
    ),
    "events": MessageLookupByLibrary.simpleMessage("Events"),
    "eventsEmptyDescription": MessageLookupByLibrary.simpleMessage(
      "We\'ll show events and activities in your area soon. Check back later.",
    ),
    "eventsEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "No events at the moment",
    ),
    "exclusiveRewards": MessageLookupByLibrary.simpleMessage(
      "Get exclusive rewards",
    ),
    "female": MessageLookupByLibrary.simpleMessage("Female"),
    "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
    "forgetPassword": MessageLookupByLibrary.simpleMessage("Forget Password?"),
    "fromCenter": MessageLookupByLibrary.simpleMessage("from center"),
    "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
    "gender": MessageLookupByLibrary.simpleMessage("Gender"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "geographicDirectory": MessageLookupByLibrary.simpleMessage(
      "Geographic Directory",
    ),
    "getDirections": MessageLookupByLibrary.simpleMessage("Get Directions"),
    "getInstantAlerts": MessageLookupByLibrary.simpleMessage(
      "Get instant alerts",
    ),
    "goBack": MessageLookupByLibrary.simpleMessage("Go Back"),
    "group": MessageLookupByLibrary.simpleMessage("Group"),
    "groupName": MessageLookupByLibrary.simpleMessage("Group Name"),
    "groupNameExample": MessageLookupByLibrary.simpleMessage(
      "Ex: Dubai Trip - Family",
    ),
    "groupNotFound": MessageLookupByLibrary.simpleMessage("Group not found"),
    "groupPageContent": MessageLookupByLibrary.simpleMessage(
      "View and manage your groups",
    ),
    "groups": MessageLookupByLibrary.simpleMessage("Groups"),
    "helloUser": m3,
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "homePageContent": MessageLookupByLibrary.simpleMessage(
      "Welcome to your home page",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("hours"),
    "howToUseCard": MessageLookupByLibrary.simpleMessage("How to use the card"),
    "imagePickerCamera": MessageLookupByLibrary.simpleMessage("Use camera"),
    "imagePickerGallery": MessageLookupByLibrary.simpleMessage(
      "Choose from gallery",
    ),
    "invalidCodeFormat": MessageLookupByLibrary.simpleMessage(
      "Invalid code format",
    ),
    "inviteCode": MessageLookupByLibrary.simpleMessage("Invite Code"),
    "inviteCodeTitle": MessageLookupByLibrary.simpleMessage("Invite Code"),
    "joinAGroup": MessageLookupByLibrary.simpleMessage("Join a Group"),
    "joinGroup": MessageLookupByLibrary.simpleMessage("Join Group"),
    "joinNow": MessageLookupByLibrary.simpleMessage("Join Now"),
    "joining": MessageLookupByLibrary.simpleMessage("Joining..."),
    "justNow": MessageLookupByLibrary.simpleMessage("Just now"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageChanged": MessageLookupByLibrary.simpleMessage(
      "Language changed successfully",
    ),
    "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "latitude": MessageLookupByLibrary.simpleMessage("Latitude"),
    "leaveGroup": MessageLookupByLibrary.simpleMessage("Leave Group"),
    "listView": MessageLookupByLibrary.simpleMessage("List View"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading"),
    "location": MessageLookupByLibrary.simpleMessage("Location"),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to logout?",
    ),
    "longitude": MessageLookupByLibrary.simpleMessage("Longitude"),
    "loyaltyCard": MessageLookupByLibrary.simpleMessage("Loyalty Card"),
    "loyaltyPoints": MessageLookupByLibrary.simpleMessage("Loyalty Points"),
    "male": MessageLookupByLibrary.simpleMessage("Male"),
    "mapView": MessageLookupByLibrary.simpleMessage("Map View"),
    "mapsAppNotFound": MessageLookupByLibrary.simpleMessage(
      "No maps app found on your device",
    ),
    "markAsResolved": MessageLookupByLibrary.simpleMessage("Mark as Resolved"),
    "member": MessageLookupByLibrary.simpleMessage("Member"),
    "meters": MessageLookupByLibrary.simpleMessage("meters"),
    "minutes": MessageLookupByLibrary.simpleMessage("minutes"),
    "myServices": MessageLookupByLibrary.simpleMessage("My Services"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "needHelp": MessageLookupByLibrary.simpleMessage("I need help!"),
    "newService": MessageLookupByLibrary.simpleMessage("New Service"),
    "nickname": MessageLookupByLibrary.simpleMessage("Nickname"),
    "noActiveAlerts": MessageLookupByLibrary.simpleMessage("No Active Alerts"),
    "noAlertsMessage": MessageLookupByLibrary.simpleMessage(
      "Great! No emergency alerts at the moment.\nYour group is safe.",
    ),
    "noAppsAvailable": MessageLookupByLibrary.simpleMessage(
      "No apps available",
    ),
    "noCategoriesAvailable": MessageLookupByLibrary.simpleMessage(
      "No categories available",
    ),
    "noGroupsYet": MessageLookupByLibrary.simpleMessage("No Groups Yet"),
    "noServicesYet": MessageLookupByLibrary.simpleMessage(
      "You have no services yet",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "onboardingDescription1": MessageLookupByLibrary.simpleMessage(
      "Everything you need in one place",
    ),
    "onboardingDescription2": MessageLookupByLibrary.simpleMessage(
      "Plan your trip easily with smart travel bag, emergency guide, and local events",
    ),
    "onboardingDescription3": MessageLookupByLibrary.simpleMessage(
      "Earn points with every booking and redeem them for exclusive discounts and unique benefits",
    ),
    "onboardingNext": MessageLookupByLibrary.simpleMessage("Next"),
    "onboardingSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "onboardingStart": MessageLookupByLibrary.simpleMessage("Start Exploring"),
    "onboardingTitle1": MessageLookupByLibrary.simpleMessage(
      "Directory Services",
    ),
    "onboardingTitle2": MessageLookupByLibrary.simpleMessage(
      "Smart Travel Tools",
    ),
    "onboardingTitle3": MessageLookupByLibrary.simpleMessage(
      "Rewards and Loyalty Points",
    ),
    "openInMaps": MessageLookupByLibrary.simpleMessage("Open in Maps"),
    "openRegister": MessageLookupByLibrary.simpleMessage(
      "Open commercial register",
    ),
    "optional": MessageLookupByLibrary.simpleMessage("Optional"),
    "or": MessageLookupByLibrary.simpleMessage("OR"),
    "orText": MessageLookupByLibrary.simpleMessage("OR"),
    "owner": MessageLookupByLibrary.simpleMessage("Owner"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "personalInformation": MessageLookupByLibrary.simpleMessage(
      "Personal Information",
    ),
    "phone": MessageLookupByLibrary.simpleMessage("Phone"),
    "placeQrCode": MessageLookupByLibrary.simpleMessage(
      "Place QR code inside the frame",
    ),
    "pleaseEnterGroupName": MessageLookupByLibrary.simpleMessage(
      "Please enter group name",
    ),
    "pleaseEnterInviteCode": MessageLookupByLibrary.simpleMessage(
      "Please enter invite code",
    ),
    "pleaseEnterName": MessageLookupByLibrary.simpleMessage(
      "Please enter your name",
    ),
    "points": MessageLookupByLibrary.simpleMessage("Points"),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profilePageContent": MessageLookupByLibrary.simpleMessage(
      "View and edit your profile",
    ),
    "profileUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully",
    ),
    "pushNotifications": MessageLookupByLibrary.simpleMessage(
      "Push Notifications",
    ),
    "qrCodeUsage": MessageLookupByLibrary.simpleMessage(
      "Use the QR code to link with devices within secure groups",
    ),
    "radius": MessageLookupByLibrary.simpleMessage("Radius"),
    "readPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Read our privacy policy",
    ),
    "redeemSoon": MessageLookupByLibrary.simpleMessage("Redeem Soon"),
    "remaining": MessageLookupByLibrary.simpleMessage("remaining"),
    "reminderAddButton": MessageLookupByLibrary.simpleMessage("Save reminder"),
    "reminderAddTitle": MessageLookupByLibrary.simpleMessage("Add reminder"),
    "reminderAttachmentAdd": MessageLookupByLibrary.simpleMessage(
      "Attach image",
    ),
    "reminderAttachmentLabel": MessageLookupByLibrary.simpleMessage(
      "Attachment (optional)",
    ),
    "reminderCreateSuccess": MessageLookupByLibrary.simpleMessage(
      "Reminder created successfully.",
    ),
    "reminderDateLabel": MessageLookupByLibrary.simpleMessage("Date"),
    "reminderDatePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Select date",
    ),
    "reminderDateValidation": MessageLookupByLibrary.simpleMessage(
      "Please choose a date.",
    ),
    "reminderEditTitle": MessageLookupByLibrary.simpleMessage("Edit reminder"),
    "reminderLoadError": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t refresh reminders. Please try again.",
    ),
    "reminderNotesLabel": MessageLookupByLibrary.simpleMessage(
      "Notes (optional)",
    ),
    "reminderNotesPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Add any extra notes that help you remember.",
    ),
    "reminderRecurrenceCustom": MessageLookupByLibrary.simpleMessage("Custom"),
    "reminderRecurrenceDaily": MessageLookupByLibrary.simpleMessage("Daily"),
    "reminderRecurrenceLabel": MessageLookupByLibrary.simpleMessage(
      "Recurrence",
    ),
    "reminderRecurrenceOnce": MessageLookupByLibrary.simpleMessage("One time"),
    "reminderRecurrenceWeekly": MessageLookupByLibrary.simpleMessage("Weekly"),
    "reminderSaveError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong while saving the reminder.",
    ),
    "reminderSubtitle": MessageLookupByLibrary.simpleMessage(
      "Set reminder details so you never miss an important travel task.",
    ),
    "reminderTimeLabel": MessageLookupByLibrary.simpleMessage("Time"),
    "reminderTimePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Select time",
    ),
    "reminderTimeValidation": MessageLookupByLibrary.simpleMessage(
      "Please choose a time.",
    ),
    "reminderTitleLabel": MessageLookupByLibrary.simpleMessage(
      "Reminder title",
    ),
    "reminderTitlePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Example: Prepare passport",
    ),
    "reminderTitleValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter a reminder title.",
    ),
    "reminderUpdateButton": MessageLookupByLibrary.simpleMessage(
      "Update reminder",
    ),
    "reminderUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Reminder updated successfully.",
    ),
    "reportIssue": MessageLookupByLibrary.simpleMessage("Report an Issue"),
    "required": MessageLookupByLibrary.simpleMessage("Required"),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "resolveAlert": MessageLookupByLibrary.simpleMessage("Resolve Alert"),
    "resolved": MessageLookupByLibrary.simpleMessage("Resolved"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "retrying": MessageLookupByLibrary.simpleMessage("Retrying..."),
    "safetyRadius": MessageLookupByLibrary.simpleMessage("Safety Radius"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saving": MessageLookupByLibrary.simpleMessage("Saving"),
    "scanQr": MessageLookupByLibrary.simpleMessage("Scan QR"),
    "scanQrCode": MessageLookupByLibrary.simpleMessage("Scan QR Code"),
    "scanningWillStart": MessageLookupByLibrary.simpleMessage(
      "Scanning will start automatically",
    ),
    "seconds": MessageLookupByLibrary.simpleMessage("seconds"),
    "selectBirthDate": MessageLookupByLibrary.simpleMessage(
      "Select Birth Date",
    ),
    "selectImage": MessageLookupByLibrary.simpleMessage("Select Image"),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Select Language"),
    "selectLocation": MessageLookupByLibrary.simpleMessage("Select location"),
    "selectOnMap": MessageLookupByLibrary.simpleMessage("Select on Map"),
    "sendResetCode": MessageLookupByLibrary.simpleMessage("Send Reset Code"),
    "serviceDetails": MessageLookupByLibrary.simpleMessage("Service details"),
    "serviceImages": MessageLookupByLibrary.simpleMessage("Service images"),
    "serviceName": MessageLookupByLibrary.simpleMessage("Service name"),
    "serviceType": MessageLookupByLibrary.simpleMessage("Service Type"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "showPointsCard": MessageLookupByLibrary.simpleMessage("Show Points Card"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "sosAlert": MessageLookupByLibrary.simpleMessage("🚨 SOS Alert!"),
    "sosAlerts": MessageLookupByLibrary.simpleMessage("SOS Alerts"),
    "sosEmergency": MessageLookupByLibrary.simpleMessage("SOS Emergency"),
    "startNow": MessageLookupByLibrary.simpleMessage("Start Now"),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "support": MessageLookupByLibrary.simpleMessage("Support"),
    "tapToResolve": MessageLookupByLibrary.simpleMessage(
      "Tap to resolve this alert",
    ),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Terms and Conditions",
    ),
    "termsOfService": MessageLookupByLibrary.simpleMessage("Terms of service"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "trackYourGroup": MessageLookupByLibrary.simpleMessage(
      "Track your group safely",
    ),
    "trips": MessageLookupByLibrary.simpleMessage("Trips"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updateProfile": MessageLookupByLibrary.simpleMessage("Update Profile"),
    "vendorServices": MessageLookupByLibrary.simpleMessage("Vendor Services"),
    "verify": MessageLookupByLibrary.simpleMessage("Verify"),
    "verifyEmailNow": MessageLookupByLibrary.simpleMessage("Verify email"),
    "verifyMail": MessageLookupByLibrary.simpleMessage("Verify Mail"),
    "verifyMailBody": MessageLookupByLibrary.simpleMessage(
      "We have sent a verification code to your email",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
    "viewOnMap": MessageLookupByLibrary.simpleMessage("View on Map"),
    "weightExceeded": MessageLookupByLibrary.simpleMessage("Weight Exceeded"),
    "weightExceededMessage": m4,
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome!"),
    "welcomeLogin": MessageLookupByLibrary.simpleMessage(
      "Welcome back to SEASON",
    ),
    "welcomeSignUp": MessageLookupByLibrary.simpleMessage(
      "Create your account and get started!",
    ),
    "welcomeText": MessageLookupByLibrary.simpleMessage(
      "Your comprehensive companion for every journey",
    ),
    "whatsappNotInstalled": MessageLookupByLibrary.simpleMessage(
      "WhatsApp is not installed on your device",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "yourLoyaltyPoints": MessageLookupByLibrary.simpleMessage(
      "Your Loyalty Points",
    ),
    "yourServices": MessageLookupByLibrary.simpleMessage("Your services"),
  };
}
