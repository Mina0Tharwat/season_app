// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Season App`
  String get appTitle {
    return Intl.message('Season App', name: 'appTitle', desc: '', args: []);
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message('Welcome!', name: 'welcome', desc: '', args: []);
  }

  /// `Hello {userName}!`
  String helloUser(Object userName) {
    return Intl.message(
      'Hello $userName!',
      name: 'helloUser',
      desc: '',
      args: [userName],
    );
  }

  /// `Your comprehensive companion for every journey`
  String get welcomeText {
    return Intl.message(
      'Your comprehensive companion for every journey',
      name: 'welcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Start Now`
  String get startNow {
    return Intl.message('Start Now', name: 'startNow', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Welcome back to SEASON`
  String get welcomeLogin {
    return Intl.message(
      'Welcome back to SEASON',
      name: 'welcomeLogin',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forget Password?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message('OR', name: 'or', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create your account and get started!`
  String get welcomeSignUp {
    return Intl.message(
      'Create your account and get started!',
      name: 'welcomeSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Verify Mail`
  String get verifyMail {
    return Intl.message('Verify Mail', name: 'verifyMail', desc: '', args: []);
  }

  /// `We have sent a verification code to your email`
  String get verifyMailBody {
    return Intl.message(
      'We have sent a verification code to your email',
      name: 'verifyMailBody',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Loading`
  String get loading {
    return Intl.message('Loading', name: 'loading', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Card`
  String get card {
    return Intl.message('Card', name: 'card', desc: '', args: []);
  }

  /// `Group`
  String get group {
    return Intl.message('Group', name: 'group', desc: '', args: []);
  }

  /// `Bag`
  String get bag {
    return Intl.message('Bag', name: 'bag', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Welcome to your home page`
  String get homePageContent {
    return Intl.message(
      'Welcome to your home page',
      name: 'homePageContent',
      desc: '',
      args: [],
    );
  }

  /// `Manage your cards here`
  String get cardPageContent {
    return Intl.message(
      'Manage your cards here',
      name: 'cardPageContent',
      desc: '',
      args: [],
    );
  }

  /// `View and manage your groups`
  String get groupPageContent {
    return Intl.message(
      'View and manage your groups',
      name: 'groupPageContent',
      desc: '',
      args: [],
    );
  }

  /// `Your shopping bag items`
  String get bagPageContent {
    return Intl.message(
      'Your shopping bag items',
      name: 'bagPageContent',
      desc: '',
      args: [],
    );
  }

  /// `View and edit your profile`
  String get profilePageContent {
    return Intl.message(
      'View and edit your profile',
      name: 'profilePageContent',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to receive reset code`
  String get enterEmailToReceiveResetCode {
    return Intl.message(
      'Enter your email to receive reset code',
      name: 'enterEmailToReceiveResetCode',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Code`
  String get sendResetCode {
    return Intl.message(
      'Send Reset Code',
      name: 'sendResetCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password is required`
  String get confirmPasswordRequired {
    return Intl.message(
      'Confirm password is required',
      name: 'confirmPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `remaining`
  String get remaining {
    return Intl.message('remaining', name: 'remaining', desc: '', args: []);
  }

  /// `seconds`
  String get seconds {
    return Intl.message('seconds', name: 'seconds', desc: '', args: []);
  }

  /// `Code not sent?`
  String get codeNotSent {
    return Intl.message(
      'Code not sent?',
      name: 'codeNotSent',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get enterNewPassword {
    return Intl.message(
      'Enter your new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password is required`
  String get confirmNewPasswordRequired {
    return Intl.message(
      'Confirm new password is required',
      name: 'confirmNewPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get logoutConfirmation {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Nickname`
  String get nickname {
    return Intl.message('Nickname', name: 'nickname', desc: '', args: []);
  }

  /// `Birth Date`
  String get birthDate {
    return Intl.message('Birth Date', name: 'birthDate', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `Coins`
  String get coins {
    return Intl.message('Coins', name: 'coins', desc: '', args: []);
  }

  /// `Trips`
  String get trips {
    return Intl.message('Trips', name: 'trips', desc: '', args: []);
  }

  /// `Select Image`
  String get selectImage {
    return Intl.message(
      'Select Image',
      name: 'selectImage',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Change Photo`
  String get changePhoto {
    return Intl.message(
      'Change Photo',
      name: 'changePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Apply as Service Provider`
  String get applyAsServiceProvider {
    return Intl.message(
      'Apply as Service Provider',
      name: 'applyAsServiceProvider',
      desc: '',
      args: [],
    );
  }

  /// `Apply as Trader`
  String get applyAsTrader {
    return Intl.message(
      'Apply as Trader',
      name: 'applyAsTrader',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error loading profile`
  String get errorLoadingProfile {
    return Intl.message(
      'Error loading profile',
      name: 'errorLoadingProfile',
      desc: '',
      args: [],
    );
  }

  /// `Error updating profile`
  String get errorUpdatingProfile {
    return Intl.message(
      'Error updating profile',
      name: 'errorUpdatingProfile',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterName',
      desc: '',
      args: [],
    );
  }

  /// `Saving`
  String get saving {
    return Intl.message('Saving', name: 'saving', desc: '', args: []);
  }

  /// `Select Birth Date`
  String get selectBirthDate {
    return Intl.message(
      'Select Birth Date',
      name: 'selectBirthDate',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Account Statistics`
  String get accountStatistics {
    return Intl.message(
      'Account Statistics',
      name: 'accountStatistics',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get optional {
    return Intl.message('Optional', name: 'optional', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Push Notifications`
  String get pushNotifications {
    return Intl.message(
      'Push Notifications',
      name: 'pushNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Email Notifications`
  String get emailNotifications {
    return Intl.message(
      'Email Notifications',
      name: 'emailNotifications',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `About App`
  String get aboutApp {
    return Intl.message('About App', name: 'aboutApp', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Email verified`
  String get emailVerified {
    return Intl.message(
      'Email verified',
      name: 'emailVerified',
      desc: '',
      args: [],
    );
  }

  /// `Email not verified`
  String get emailNotVerified {
    return Intl.message(
      'Email not verified',
      name: 'emailNotVerified',
      desc: '',
      args: [],
    );
  }

  /// `Verify email`
  String get verifyEmailNow {
    return Intl.message(
      'Verify email',
      name: 'verifyEmailNow',
      desc: '',
      args: [],
    );
  }

  /// `Verify your email to secure your account`
  String get emailVerificationHint {
    return Intl.message(
      'Verify your email to secure your account',
      name: 'emailVerificationHint',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent to your email`
  String get emailVerificationSent {
    return Intl.message(
      'Verification code sent to your email',
      name: 'emailVerificationSent',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Permanently remove your account and all data`
  String get deleteAccountSubtitle {
    return Intl.message(
      'Permanently remove your account and all data',
      name: 'deleteAccountSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get deleteAccountConfirmation {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'deleteAccountConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been deleted successfully`
  String get deleteAccountSuccess {
    return Intl.message(
      'Your account has been deleted successfully',
      name: 'deleteAccountSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Yes, delete account`
  String get deleteAccountConfirmButton {
    return Intl.message(
      'Yes, delete account',
      name: 'deleteAccountConfirmButton',
      desc: '',
      args: [],
    );
  }

  /// `Could not delete account. Please try again.`
  String get deleteAccountFailure {
    return Intl.message(
      'Could not delete account. Please try again.',
      name: 'deleteAccountFailure',
      desc: '',
      args: [],
    );
  }

  /// `Language changed successfully`
  String get languageChanged {
    return Intl.message(
      'Language changed successfully',
      name: 'languageChanged',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `Don't Get Lost`
  String get dontGetLost {
    return Intl.message(
      'Don\'t Get Lost',
      name: 'dontGetLost',
      desc: '',
      args: [],
    );
  }

  /// `Track your group safely`
  String get trackYourGroup {
    return Intl.message(
      'Track your group safely',
      name: 'trackYourGroup',
      desc: '',
      args: [],
    );
  }

  /// `No Groups Yet`
  String get noGroupsYet {
    return Intl.message(
      'No Groups Yet',
      name: 'noGroupsYet',
      desc: '',
      args: [],
    );
  }

  /// `Create a new group\nor join an existing one`
  String get createNewGroup {
    return Intl.message(
      'Create a new group\nor join an existing one',
      name: 'createNewGroup',
      desc: '',
      args: [],
    );
  }

  /// `Create Group`
  String get createGroup {
    return Intl.message(
      'Create Group',
      name: 'createGroup',
      desc: '',
      args: [],
    );
  }

  /// `Join Group`
  String get joinGroup {
    return Intl.message('Join Group', name: 'joinGroup', desc: '', args: []);
  }

  /// `Scan QR Code`
  String get scanQrCode {
    return Intl.message('Scan QR Code', name: 'scanQrCode', desc: '', args: []);
  }

  /// `Enter Code Manually`
  String get enterCodeManually {
    return Intl.message(
      'Enter Code Manually',
      name: 'enterCodeManually',
      desc: '',
      args: [],
    );
  }

  /// `Place QR code inside the frame`
  String get placeQrCode {
    return Intl.message(
      'Place QR code inside the frame',
      name: 'placeQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Scanning will start automatically`
  String get scanningWillStart {
    return Intl.message(
      'Scanning will start automatically',
      name: 'scanningWillStart',
      desc: '',
      args: [],
    );
  }

  /// `Join Now`
  String get joinNow {
    return Intl.message('Join Now', name: 'joinNow', desc: '', args: []);
  }

  /// `OR`
  String get orText {
    return Intl.message('OR', name: 'orText', desc: '', args: []);
  }

  /// `Or ask for code from group owner`
  String get askForCode {
    return Intl.message(
      'Or ask for code from group owner',
      name: 'askForCode',
      desc: '',
      args: [],
    );
  }

  /// `Invite Code`
  String get inviteCode {
    return Intl.message('Invite Code', name: 'inviteCode', desc: '', args: []);
  }

  /// `Enter the invite code to join the group`
  String get enterInviteCode {
    return Intl.message(
      'Enter the invite code to join the group',
      name: 'enterInviteCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter invite code`
  String get pleaseEnterInviteCode {
    return Intl.message(
      'Please enter invite code',
      name: 'pleaseEnterInviteCode',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code format`
  String get invalidCodeFormat {
    return Intl.message(
      'Invalid code format',
      name: 'invalidCodeFormat',
      desc: '',
      args: [],
    );
  }

  /// `Group Name`
  String get groupName {
    return Intl.message('Group Name', name: 'groupName', desc: '', args: []);
  }

  /// `Ex: Dubai Trip - Family`
  String get groupNameExample {
    return Intl.message(
      'Ex: Dubai Trip - Family',
      name: 'groupNameExample',
      desc: '',
      args: [],
    );
  }

  /// `Please enter group name`
  String get pleaseEnterGroupName {
    return Intl.message(
      'Please enter group name',
      name: 'pleaseEnterGroupName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Description (Optional)`
  String get descriptionOptional {
    return Intl.message(
      'Description (Optional)',
      name: 'descriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Add a description`
  String get addDescription {
    return Intl.message(
      'Add a description',
      name: 'addDescription',
      desc: '',
      args: [],
    );
  }

  /// `Safety Radius`
  String get safetyRadius {
    return Intl.message(
      'Safety Radius',
      name: 'safetyRadius',
      desc: '',
      args: [],
    );
  }

  /// `meters`
  String get meters {
    return Intl.message('meters', name: 'meters', desc: '', args: []);
  }

  /// `Distance allowed before sending alert`
  String get distanceAllowed {
    return Intl.message(
      'Distance allowed before sending alert',
      name: 'distanceAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Enable Notifications`
  String get enableNotifications {
    return Intl.message(
      'Enable Notifications',
      name: 'enableNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Get instant alerts`
  String get getInstantAlerts {
    return Intl.message(
      'Get instant alerts',
      name: 'getInstantAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Join a Group`
  String get joinAGroup {
    return Intl.message('Join a Group', name: 'joinAGroup', desc: '', args: []);
  }

  /// `Create New Group`
  String get createNewGroupTitle {
    return Intl.message(
      'Create New Group',
      name: 'createNewGroupTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create a group to track your friends and family`
  String get createGroupDescription {
    return Intl.message(
      'Create a group to track your friends and family',
      name: 'createGroupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get groups {
    return Intl.message('Groups', name: 'groups', desc: '', args: []);
  }

  /// `Alerts`
  String get alerts {
    return Intl.message('Alerts', name: 'alerts', desc: '', args: []);
  }

  /// `Radius`
  String get radius {
    return Intl.message('Radius', name: 'radius', desc: '', args: []);
  }

  /// `Owner`
  String get owner {
    return Intl.message('Owner', name: 'owner', desc: '', args: []);
  }

  /// `Member`
  String get member {
    return Intl.message('Member', name: 'member', desc: '', args: []);
  }

  /// `from center`
  String get fromCenter {
    return Intl.message('from center', name: 'fromCenter', desc: '', args: []);
  }

  /// `Error Loading Group`
  String get errorLoadingGroup {
    return Intl.message(
      'Error Loading Group',
      name: 'errorLoadingGroup',
      desc: '',
      args: [],
    );
  }

  /// `Group not found`
  String get groupNotFound {
    return Intl.message(
      'Group not found',
      name: 'groupNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Error Details:`
  String get errorDetails {
    return Intl.message(
      'Error Details:',
      name: 'errorDetails',
      desc: '',
      args: [],
    );
  }

  /// `Endpoint:`
  String get endpoint {
    return Intl.message('Endpoint:', name: 'endpoint', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Go Back`
  String get goBack {
    return Intl.message('Go Back', name: 'goBack', desc: '', args: []);
  }

  /// `Leave Group`
  String get leaveGroup {
    return Intl.message('Leave Group', name: 'leaveGroup', desc: '', args: []);
  }

  /// `Delete Group`
  String get deleteGroup {
    return Intl.message(
      'Delete Group',
      name: 'deleteGroup',
      desc: '',
      args: [],
    );
  }

  /// `Invite Code`
  String get inviteCodeTitle {
    return Intl.message(
      'Invite Code',
      name: 'inviteCodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Copied!`
  String get copied {
    return Intl.message('Copied!', name: 'copied', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `SOS Emergency`
  String get sosEmergency {
    return Intl.message(
      'SOS Emergency',
      name: 'sosEmergency',
      desc: '',
      args: [],
    );
  }

  /// `🚨 SOS Alert!`
  String get sosAlert {
    return Intl.message('🚨 SOS Alert!', name: 'sosAlert', desc: '', args: []);
  }

  /// `I need help!`
  String get needHelp {
    return Intl.message('I need help!', name: 'needHelp', desc: '', args: []);
  }

  /// `Joining...`
  String get joining {
    return Intl.message('Joining...', name: 'joining', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Scan QR`
  String get scanQr {
    return Intl.message('Scan QR', name: 'scanQr', desc: '', args: []);
  }

  /// `SOS Alerts`
  String get sosAlerts {
    return Intl.message('SOS Alerts', name: 'sosAlerts', desc: '', args: []);
  }

  /// `🚨 Emergency Alerts`
  String get emergencyAlerts {
    return Intl.message(
      '🚨 Emergency Alerts',
      name: 'emergencyAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Active Alerts`
  String get activeAlerts {
    return Intl.message(
      'Active Alerts',
      name: 'activeAlerts',
      desc: '',
      args: [],
    );
  }

  /// `No Active Alerts`
  String get noActiveAlerts {
    return Intl.message(
      'No Active Alerts',
      name: 'noActiveAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Great! No emergency alerts at the moment.\nYour group is safe.`
  String get noAlertsMessage {
    return Intl.message(
      'Great! No emergency alerts at the moment.\nYour group is safe.',
      name: 'noAlertsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Alert from`
  String get alertFrom {
    return Intl.message('Alert from', name: 'alertFrom', desc: '', args: []);
  }

  /// `Alert Time`
  String get alertTime {
    return Intl.message('Alert Time', name: 'alertTime', desc: '', args: []);
  }

  /// `Message`
  String get alertMessage {
    return Intl.message('Message', name: 'alertMessage', desc: '', args: []);
  }

  /// `Resolve Alert`
  String get resolveAlert {
    return Intl.message(
      'Resolve Alert',
      name: 'resolveAlert',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Resolved`
  String get markAsResolved {
    return Intl.message(
      'Mark as Resolved',
      name: 'markAsResolved',
      desc: '',
      args: [],
    );
  }

  /// `Alert Resolved`
  String get alertResolved {
    return Intl.message(
      'Alert Resolved',
      name: 'alertResolved',
      desc: '',
      args: [],
    );
  }

  /// `Emergency alert has been resolved`
  String get alertResolvedMessage {
    return Intl.message(
      'Emergency alert has been resolved',
      name: 'alertResolvedMessage',
      desc: '',
      args: [],
    );
  }

  /// `View on Map`
  String get viewOnMap {
    return Intl.message('View on Map', name: 'viewOnMap', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Distance`
  String get distance {
    return Intl.message('Distance', name: 'distance', desc: '', args: []);
  }

  /// `ago`
  String get ago {
    return Intl.message('ago', name: 'ago', desc: '', args: []);
  }

  /// `minutes`
  String get minutes {
    return Intl.message('minutes', name: 'minutes', desc: '', args: []);
  }

  /// `hours`
  String get hours {
    return Intl.message('hours', name: 'hours', desc: '', args: []);
  }

  /// `days`
  String get days {
    return Intl.message('days', name: 'days', desc: '', args: []);
  }

  /// `Map View`
  String get mapView {
    return Intl.message('Map View', name: 'mapView', desc: '', args: []);
  }

  /// `List View`
  String get listView {
    return Intl.message('List View', name: 'listView', desc: '', args: []);
  }

  /// `Emergency Location`
  String get emergencyLocation {
    return Intl.message(
      'Emergency Location',
      name: 'emergencyLocation',
      desc: '',
      args: [],
    );
  }

  /// `Tap to resolve this alert`
  String get tapToResolve {
    return Intl.message(
      'Tap to resolve this alert',
      name: 'tapToResolve',
      desc: '',
      args: [],
    );
  }

  /// `Resolve Alert?`
  String get confirmResolve {
    return Intl.message(
      'Resolve Alert?',
      name: 'confirmResolve',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to mark this alert as resolved?`
  String get confirmResolveMessage {
    return Intl.message(
      'Are you sure you want to mark this alert as resolved?',
      name: 'confirmResolveMessage',
      desc: '',
      args: [],
    );
  }

  /// `Resolved`
  String get resolved {
    return Intl.message('Resolved', name: 'resolved', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `Get Directions`
  String get getDirections {
    return Intl.message(
      'Get Directions',
      name: 'getDirections',
      desc: '',
      args: [],
    );
  }

  /// `Directions to Emergency Location`
  String get directionsToAlert {
    return Intl.message(
      'Directions to Emergency Location',
      name: 'directionsToAlert',
      desc: '',
      args: [],
    );
  }

  /// `Open in Maps`
  String get openInMaps {
    return Intl.message('Open in Maps', name: 'openInMaps', desc: '', args: []);
  }

  /// `Get directions to this emergency location using your preferred maps app`
  String get directionsDescription {
    return Intl.message(
      'Get directions to this emergency location using your preferred maps app',
      name: 'directionsDescription',
      desc: '',
      args: [],
    );
  }

  /// `No maps app found on your device`
  String get mapsAppNotFound {
    return Intl.message(
      'No maps app found on your device',
      name: 'mapsAppNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Directions`
  String get directions {
    return Intl.message('Directions', name: 'directions', desc: '', args: []);
  }

  /// `Points`
  String get points {
    return Intl.message('Points', name: 'points', desc: '', args: []);
  }

  /// `Loyalty Card`
  String get loyaltyCard {
    return Intl.message(
      'Loyalty Card',
      name: 'loyaltyCard',
      desc: '',
      args: [],
    );
  }

  /// `Error loading card data`
  String get errorLoadingCardData {
    return Intl.message(
      'Error loading card data',
      name: 'errorLoadingCardData',
      desc: '',
      args: [],
    );
  }

  /// `Loyalty Points`
  String get loyaltyPoints {
    return Intl.message(
      'Loyalty Points',
      name: 'loyaltyPoints',
      desc: '',
      args: [],
    );
  }

  /// `How to use the card`
  String get howToUseCard {
    return Intl.message(
      'How to use the card',
      name: 'howToUseCard',
      desc: '',
      args: [],
    );
  }

  /// `Use the QR code to link with devices within secure groups`
  String get qrCodeUsage {
    return Intl.message(
      'Use the QR code to link with devices within secure groups',
      name: 'qrCodeUsage',
      desc: '',
      args: [],
    );
  }

  /// `Collect loyalty points when browsing and using partner services`
  String get collectPoints {
    return Intl.message(
      'Collect loyalty points when browsing and using partner services',
      name: 'collectPoints',
      desc: '',
      args: [],
    );
  }

  /// `Get exclusive rewards`
  String get exclusiveRewards {
    return Intl.message(
      'Get exclusive rewards',
      name: 'exclusiveRewards',
      desc: '',
      args: [],
    );
  }

  /// `Read our privacy policy`
  String get readPrivacyPolicy {
    return Intl.message(
      'Read our privacy policy',
      name: 'readPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of service`
  String get termsOfService {
    return Intl.message(
      'Terms of service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone. All your data will be permanently deleted.`
  String get deleteAccountWarning {
    return Intl.message(
      'This action cannot be undone. All your data will be permanently deleted.',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `New Service`
  String get newService {
    return Intl.message('New Service', name: 'newService', desc: '', args: []);
  }

  /// `Edit Service`
  String get editService {
    return Intl.message(
      'Edit Service',
      name: 'editService',
      desc: '',
      args: [],
    );
  }

  /// `Service Type`
  String get serviceType {
    return Intl.message(
      'Service Type',
      name: 'serviceType',
      desc: '',
      args: [],
    );
  }

  /// `Choose file`
  String get chooseFile {
    return Intl.message('Choose file', name: 'chooseFile', desc: '', args: []);
  }

  /// `Commercial Register (PDF)`
  String get commercialRegister {
    return Intl.message(
      'Commercial Register (PDF)',
      name: 'commercialRegister',
      desc: '',
      args: [],
    );
  }

  /// `Select on Map`
  String get selectOnMap {
    return Intl.message(
      'Select on Map',
      name: 'selectOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Latitude`
  String get latitude {
    return Intl.message('Latitude', name: 'latitude', desc: '', args: []);
  }

  /// `Longitude`
  String get longitude {
    return Intl.message('Longitude', name: 'longitude', desc: '', args: []);
  }

  /// `Create a service`
  String get createService {
    return Intl.message(
      'Create a service',
      name: 'createService',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Service details`
  String get serviceDetails {
    return Intl.message(
      'Service details',
      name: 'serviceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Your services`
  String get yourServices {
    return Intl.message(
      'Your services',
      name: 'yourServices',
      desc: '',
      args: [],
    );
  }

  /// `You have no services yet`
  String get noServicesYet {
    return Intl.message(
      'You have no services yet',
      name: 'noServicesYet',
      desc: '',
      args: [],
    );
  }

  /// `Open commercial register`
  String get openRegister {
    return Intl.message(
      'Open commercial register',
      name: 'openRegister',
      desc: '',
      args: [],
    );
  }

  /// `Select location`
  String get selectLocation {
    return Intl.message(
      'Select location',
      name: 'selectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Delete service?`
  String get areYouSureDelete {
    return Intl.message(
      'Delete service?',
      name: 'areYouSureDelete',
      desc: '',
      args: [],
    );
  }

  /// `This will permanently remove the service.`
  String get areYouSureDeleteMessage {
    return Intl.message(
      'This will permanently remove the service.',
      name: 'areYouSureDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Service name`
  String get serviceName {
    return Intl.message(
      'Service name',
      name: 'serviceName',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message('Enable', name: 'enable', desc: '', args: []);
  }

  /// `Disable`
  String get disable {
    return Intl.message('Disable', name: 'disable', desc: '', args: []);
  }

  /// `Delete permanently`
  String get deletePermanently {
    return Intl.message(
      'Delete permanently',
      name: 'deletePermanently',
      desc: '',
      args: [],
    );
  }

  /// `Service images`
  String get serviceImages {
    return Intl.message(
      'Service images',
      name: 'serviceImages',
      desc: '',
      args: [],
    );
  }

  /// `My Services`
  String get myServices {
    return Intl.message('My Services', name: 'myServices', desc: '', args: []);
  }

  /// `Travel Bag`
  String get bagTitle {
    return Intl.message('Travel Bag', name: 'bagTitle', desc: '', args: []);
  }

  /// `Main checked luggage`
  String get bagSubtitle {
    return Intl.message(
      'Main checked luggage',
      name: 'bagSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Total weight`
  String get bagTotalWeightLabel {
    return Intl.message(
      'Total weight',
      name: 'bagTotalWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `{current} / {max} kg`
  String bagWeight(String current, String max) {
    return Intl.message(
      '$current / $max kg',
      name: 'bagWeight',
      desc: '',
      args: [current, max],
    );
  }

  /// `Add item`
  String get bagAddItemButton {
    return Intl.message(
      'Add item',
      name: 'bagAddItemButton',
      desc: '',
      args: [],
    );
  }

  /// `AI suggestions`
  String get bagAISuggestionsButton {
    return Intl.message(
      'AI suggestions',
      name: 'bagAISuggestionsButton',
      desc: '',
      args: [],
    );
  }

  /// `Reminders`
  String get bagRemindersTitle {
    return Intl.message(
      'Reminders',
      name: 'bagRemindersTitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} active`
  String bagRemindersActiveCount(int count) {
    return Intl.message(
      '$count active',
      name: 'bagRemindersActiveCount',
      desc: '',
      args: [count],
    );
  }

  /// `Add reminder`
  String get bagAddReminderButton {
    return Intl.message(
      'Add reminder',
      name: 'bagAddReminderButton',
      desc: '',
      args: [],
    );
  }

  /// `No reminders yet`
  String get bagRemindersEmptyTitle {
    return Intl.message(
      'No reminders yet',
      name: 'bagRemindersEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap "Add reminder" to create your first travel reminder.`
  String get bagRemindersEmptyDescription {
    return Intl.message(
      'Tap "Add reminder" to create your first travel reminder.',
      name: 'bagRemindersEmptyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your bag is empty`
  String get bagEmptyTitle {
    return Intl.message(
      'Your bag is empty',
      name: 'bagEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start adding your essentials to get travel-ready.`
  String get bagEmptyDescription {
    return Intl.message(
      'Start adding your essentials to get travel-ready.',
      name: 'bagEmptyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Packing tips`
  String get bagTipsTitle {
    return Intl.message(
      'Packing tips',
      name: 'bagTipsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Place heavier items at the bottom of your bag.`
  String get bagTip1 {
    return Intl.message(
      'Place heavier items at the bottom of your bag.',
      name: 'bagTip1',
      desc: '',
      args: [],
    );
  }

  /// `Roll clothes instead of folding to save space.`
  String get bagTip2 {
    return Intl.message(
      'Roll clothes instead of folding to save space.',
      name: 'bagTip2',
      desc: '',
      args: [],
    );
  }

  /// `Keep valuable items in your carry-on.`
  String get bagTip3 {
    return Intl.message(
      'Keep valuable items in your carry-on.',
      name: 'bagTip3',
      desc: '',
      args: [],
    );
  }

  /// `Double-check your airline's weight allowance.`
  String get bagTip4 {
    return Intl.message(
      'Double-check your airline\'s weight allowance.',
      name: 'bagTip4',
      desc: '',
      args: [],
    );
  }

  /// `Delete reminder?`
  String get bagDeleteReminderTitle {
    return Intl.message(
      'Delete reminder?',
      name: 'bagDeleteReminderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this reminder?`
  String get bagDeleteReminderMessage {
    return Intl.message(
      'Are you sure you want to delete this reminder?',
      name: 'bagDeleteReminderMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get bagDeleteCancel {
    return Intl.message('Cancel', name: 'bagDeleteCancel', desc: '', args: []);
  }

  /// `Delete`
  String get bagDeleteConfirm {
    return Intl.message('Delete', name: 'bagDeleteConfirm', desc: '', args: []);
  }

  /// `Reminder deleted successfully.`
  String get bagDeleteSuccess {
    return Intl.message(
      'Reminder deleted successfully.',
      name: 'bagDeleteSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Remove item?`
  String get bagDeleteItemTitle {
    return Intl.message(
      'Remove item?',
      name: 'bagDeleteItemTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove this item from your bag?`
  String get bagDeleteItemMessage {
    return Intl.message(
      'Are you sure you want to remove this item from your bag?',
      name: 'bagDeleteItemMessage',
      desc: '',
      args: [],
    );
  }

  /// `Item removed successfully.`
  String get bagDeleteItemSuccess {
    return Intl.message(
      'Item removed successfully.',
      name: 'bagDeleteItemSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to remove item. Please try again.`
  String get bagDeleteItemError {
    return Intl.message(
      'Failed to remove item. Please try again.',
      name: 'bagDeleteItemError',
      desc: '',
      args: [],
    );
  }

  /// `Item added successfully.`
  String get bagAddItemSuccess {
    return Intl.message(
      'Item added successfully.',
      name: 'bagAddItemSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add item. Please try again.`
  String get bagAddItemError {
    return Intl.message(
      'Failed to add item. Please try again.',
      name: 'bagAddItemError',
      desc: '',
      args: [],
    );
  }

  /// `Quantity updated successfully.`
  String get bagUpdateQuantitySuccess {
    return Intl.message(
      'Quantity updated successfully.',
      name: 'bagUpdateQuantitySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update quantity. Please try again.`
  String get bagUpdateQuantityError {
    return Intl.message(
      'Failed to update quantity. Please try again.',
      name: 'bagUpdateQuantityError',
      desc: '',
      args: [],
    );
  }

  /// `Bag types`
  String get bagTypesTitle {
    return Intl.message('Bag types', name: 'bagTypesTitle', desc: '', args: []);
  }

  /// `Categories`
  String get bagCategoriesTitle {
    return Intl.message(
      'Categories',
      name: 'bagCategoriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Suggested items`
  String get bagItemsTitle {
    return Intl.message(
      'Suggested items',
      name: 'bagItemsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No items to show in this category yet.`
  String get bagItemsEmpty {
    return Intl.message(
      'No items to show in this category yet.',
      name: 'bagItemsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't load items for this category.`
  String get bagItemsError {
    return Intl.message(
      'We couldn\'t load items for this category.',
      name: 'bagItemsError',
      desc: '',
      args: [],
    );
  }

  /// `Add item`
  String get bagAddItemTitle {
    return Intl.message(
      'Add item',
      name: 'bagAddItemTitle',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get bagSelectCategory {
    return Intl.message(
      'Category',
      name: 'bagSelectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Select category`
  String get bagSelectCategoryPlaceholder {
    return Intl.message(
      'Select category',
      name: 'bagSelectCategoryPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get bagSelectItem {
    return Intl.message('Item', name: 'bagSelectItem', desc: '', args: []);
  }

  /// `Select item`
  String get bagSelectItemPlaceholder {
    return Intl.message(
      'Select item',
      name: 'bagSelectItemPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get bagQuantityLabel {
    return Intl.message(
      'Quantity',
      name: 'bagQuantityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Approximate weight: {weight} kg`
  String bagApproxWeight(String weight) {
    return Intl.message(
      'Approximate weight: $weight kg',
      name: 'bagApproxWeight',
      desc: '',
      args: [weight],
    );
  }

  /// `Add to bag`
  String get bagAddItemSubmit {
    return Intl.message(
      'Add to bag',
      name: 'bagAddItemSubmit',
      desc: '',
      args: [],
    );
  }

  /// `No categories available yet.`
  String get bagNoCategories {
    return Intl.message(
      'No categories available yet.',
      name: 'bagNoCategories',
      desc: '',
      args: [],
    );
  }

  /// `No items available for this category.`
  String get bagNoItems {
    return Intl.message(
      'No items available for this category.',
      name: 'bagNoItems',
      desc: '',
      args: [],
    );
  }

  /// `Loading items...`
  String get bagLoadingItems {
    return Intl.message(
      'Loading items...',
      name: 'bagLoadingItems',
      desc: '',
      args: [],
    );
  }

  /// `Edit Max Weight`
  String get bagEditMaxWeight {
    return Intl.message(
      'Edit Max Weight',
      name: 'bagEditMaxWeight',
      desc: '',
      args: [],
    );
  }

  /// `Max Weight`
  String get bagMaxWeightLabel {
    return Intl.message(
      'Max Weight',
      name: 'bagMaxWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter max weight`
  String get bagMaxWeightPlaceholder {
    return Intl.message(
      'Enter max weight',
      name: 'bagMaxWeightPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Max weight is required`
  String get bagMaxWeightRequired {
    return Intl.message(
      'Max weight is required',
      name: 'bagMaxWeightRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid weight`
  String get bagMaxWeightInvalid {
    return Intl.message(
      'Please enter a valid weight',
      name: 'bagMaxWeightInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Weight Unit`
  String get bagWeightUnitLabel {
    return Intl.message(
      'Weight Unit',
      name: 'bagWeightUnitLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select weight unit`
  String get bagSelectWeightUnit {
    return Intl.message(
      'Select weight unit',
      name: 'bagSelectWeightUnit',
      desc: '',
      args: [],
    );
  }

  /// `Max weight updated successfully`
  String get bagMaxWeightUpdated {
    return Intl.message(
      'Max weight updated successfully',
      name: 'bagMaxWeightUpdated',
      desc: '',
      args: [],
    );
  }

  /// `kg`
  String get bagWeightUnitKg {
    return Intl.message('kg', name: 'bagWeightUnitKg', desc: '', args: []);
  }

  /// `Adjust the maximum weight limit for your bag. The weight is always measured in kilograms.`
  String get bagMaxWeightInfo {
    return Intl.message(
      'Adjust the maximum weight limit for your bag. The weight is always measured in kilograms.',
      name: 'bagMaxWeightInfo',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `We couldn't refresh reminders. Please try again.`
  String get reminderLoadError {
    return Intl.message(
      'We couldn\'t refresh reminders. Please try again.',
      name: 'reminderLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Add reminder`
  String get reminderAddTitle {
    return Intl.message(
      'Add reminder',
      name: 'reminderAddTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit reminder`
  String get reminderEditTitle {
    return Intl.message(
      'Edit reminder',
      name: 'reminderEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Set reminder details so you never miss an important travel task.`
  String get reminderSubtitle {
    return Intl.message(
      'Set reminder details so you never miss an important travel task.',
      name: 'reminderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Reminder title`
  String get reminderTitleLabel {
    return Intl.message(
      'Reminder title',
      name: 'reminderTitleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Example: Prepare passport`
  String get reminderTitlePlaceholder {
    return Intl.message(
      'Example: Prepare passport',
      name: 'reminderTitlePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a reminder title.`
  String get reminderTitleValidation {
    return Intl.message(
      'Please enter a reminder title.',
      name: 'reminderTitleValidation',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get reminderDateLabel {
    return Intl.message('Date', name: 'reminderDateLabel', desc: '', args: []);
  }

  /// `Select date`
  String get reminderDatePlaceholder {
    return Intl.message(
      'Select date',
      name: 'reminderDatePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a date.`
  String get reminderDateValidation {
    return Intl.message(
      'Please choose a date.',
      name: 'reminderDateValidation',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get reminderTimeLabel {
    return Intl.message('Time', name: 'reminderTimeLabel', desc: '', args: []);
  }

  /// `Select time`
  String get reminderTimePlaceholder {
    return Intl.message(
      'Select time',
      name: 'reminderTimePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a time.`
  String get reminderTimeValidation {
    return Intl.message(
      'Please choose a time.',
      name: 'reminderTimeValidation',
      desc: '',
      args: [],
    );
  }

  /// `Recurrence`
  String get reminderRecurrenceLabel {
    return Intl.message(
      'Recurrence',
      name: 'reminderRecurrenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `One time`
  String get reminderRecurrenceOnce {
    return Intl.message(
      'One time',
      name: 'reminderRecurrenceOnce',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get reminderRecurrenceDaily {
    return Intl.message(
      'Daily',
      name: 'reminderRecurrenceDaily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get reminderRecurrenceWeekly {
    return Intl.message(
      'Weekly',
      name: 'reminderRecurrenceWeekly',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get reminderRecurrenceCustom {
    return Intl.message(
      'Custom',
      name: 'reminderRecurrenceCustom',
      desc: '',
      args: [],
    );
  }

  /// `Notes (optional)`
  String get reminderNotesLabel {
    return Intl.message(
      'Notes (optional)',
      name: 'reminderNotesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add any extra notes that help you remember.`
  String get reminderNotesPlaceholder {
    return Intl.message(
      'Add any extra notes that help you remember.',
      name: 'reminderNotesPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Attachment (optional)`
  String get reminderAttachmentLabel {
    return Intl.message(
      'Attachment (optional)',
      name: 'reminderAttachmentLabel',
      desc: '',
      args: [],
    );
  }

  /// `Attach image`
  String get reminderAttachmentAdd {
    return Intl.message(
      'Attach image',
      name: 'reminderAttachmentAdd',
      desc: '',
      args: [],
    );
  }

  /// `Save reminder`
  String get reminderAddButton {
    return Intl.message(
      'Save reminder',
      name: 'reminderAddButton',
      desc: '',
      args: [],
    );
  }

  /// `Update reminder`
  String get reminderUpdateButton {
    return Intl.message(
      'Update reminder',
      name: 'reminderUpdateButton',
      desc: '',
      args: [],
    );
  }

  /// `Reminder created successfully.`
  String get reminderCreateSuccess {
    return Intl.message(
      'Reminder created successfully.',
      name: 'reminderCreateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Reminder updated successfully.`
  String get reminderUpdateSuccess {
    return Intl.message(
      'Reminder updated successfully.',
      name: 'reminderUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while saving the reminder.`
  String get reminderSaveError {
    return Intl.message(
      'Something went wrong while saving the reminder.',
      name: 'reminderSaveError',
      desc: '',
      args: [],
    );
  }

  /// `Choose from gallery`
  String get imagePickerGallery {
    return Intl.message(
      'Choose from gallery',
      name: 'imagePickerGallery',
      desc: '',
      args: [],
    );
  }

  /// `Use camera`
  String get imagePickerCamera {
    return Intl.message(
      'Use camera',
      name: 'imagePickerCamera',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Numbers`
  String get emergencyNumbers {
    return Intl.message(
      'Emergency Numbers',
      name: 'emergencyNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Quick access to emergency services`
  String get emergencySubtitle {
    return Intl.message(
      'Quick access to emergency services',
      name: 'emergencySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Fire Department`
  String get emergencyFire {
    return Intl.message(
      'Fire Department',
      name: 'emergencyFire',
      desc: '',
      args: [],
    );
  }

  /// `Police`
  String get emergencyPolice {
    return Intl.message('Police', name: 'emergencyPolice', desc: '', args: []);
  }

  /// `Ambulance`
  String get emergencyAmbulance {
    return Intl.message(
      'Ambulance',
      name: 'emergencyAmbulance',
      desc: '',
      args: [],
    );
  }

  /// `Embassy`
  String get emergencyEmbassy {
    return Intl.message(
      'Embassy',
      name: 'emergencyEmbassy',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load emergency numbers`
  String get emergencyError {
    return Intl.message(
      'Failed to load emergency numbers',
      name: 'emergencyError',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again`
  String get emergencyErrorDescription {
    return Intl.message(
      'Please check your internet connection and try again',
      name: 'emergencyErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Tap to view emergency contacts`
  String get emergencyQuickAccess {
    return Intl.message(
      'Tap to view emergency contacts',
      name: 'emergencyQuickAccess',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Required`
  String get required {
    return Intl.message('Required', name: 'required', desc: '', args: []);
  }

  /// `Currency Converter`
  String get currencyConverter {
    return Intl.message(
      'Currency Converter',
      name: 'currencyConverter',
      desc: '',
      args: [],
    );
  }

  /// `Convert currencies instantly`
  String get currencyConverterSubtitle {
    return Intl.message(
      'Convert currencies instantly',
      name: 'currencyConverterSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get currencyFrom {
    return Intl.message('From', name: 'currencyFrom', desc: '', args: []);
  }

  /// `To`
  String get currencyTo {
    return Intl.message('To', name: 'currencyTo', desc: '', args: []);
  }

  /// `Amount`
  String get currencyAmount {
    return Intl.message('Amount', name: 'currencyAmount', desc: '', args: []);
  }

  /// `Enter amount`
  String get currencyAmountPlaceholder {
    return Intl.message(
      'Enter amount',
      name: 'currencyAmountPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an amount`
  String get currencyAmountRequired {
    return Intl.message(
      'Please enter an amount',
      name: 'currencyAmountRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid amount`
  String get currencyAmountInvalid {
    return Intl.message(
      'Please enter a valid amount',
      name: 'currencyAmountInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Convert`
  String get currencyConvert {
    return Intl.message('Convert', name: 'currencyConvert', desc: '', args: []);
  }

  /// `Rate`
  String get currencyRate {
    return Intl.message('Rate', name: 'currencyRate', desc: '', args: []);
  }

  /// `Converted Amount`
  String get currencyConvertedAmount {
    return Intl.message(
      'Converted Amount',
      name: 'currencyConvertedAmount',
      desc: '',
      args: [],
    );
  }

  /// `Indicative Exchange Rate`
  String get currencyExchangeRate {
    return Intl.message(
      'Indicative Exchange Rate',
      name: 'currencyExchangeRate',
      desc: '',
      args: [],
    );
  }

  /// `Vendor Services`
  String get vendorServices {
    return Intl.message(
      'Vendor Services',
      name: 'vendorServices',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Digital Directory`
  String get digitalDirectory {
    return Intl.message(
      'Digital Directory',
      name: 'digitalDirectory',
      desc: '',
      args: [],
    );
  }

  /// `Geographic Directory`
  String get geographicDirectory {
    return Intl.message(
      'Geographic Directory',
      name: 'geographicDirectory',
      desc: '',
      args: [],
    );
  }

  /// `No categories available`
  String get noCategoriesAvailable {
    return Intl.message(
      'No categories available',
      name: 'noCategoriesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No apps available`
  String get noAppsAvailable {
    return Intl.message(
      'No apps available',
      name: 'noAppsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get events {
    return Intl.message('Events', name: 'events', desc: '', args: []);
  }

  /// `No events at the moment`
  String get eventsEmptyTitle {
    return Intl.message(
      'No events at the moment',
      name: 'eventsEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `We'll show events and activities in your area soon. Check back later.`
  String get eventsEmptyDescription {
    return Intl.message(
      'We\'ll show events and activities in your area soon. Check back later.',
      name: 'eventsEmptyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your Loyalty Points`
  String get yourLoyaltyPoints {
    return Intl.message(
      'Your Loyalty Points',
      name: 'yourLoyaltyPoints',
      desc: '',
      args: [],
    );
  }

  /// `available points`
  String get availablePoints {
    return Intl.message(
      'available points',
      name: 'availablePoints',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Soon`
  String get redeemSoon {
    return Intl.message('Redeem Soon', name: 'redeemSoon', desc: '', args: []);
  }

  /// `Show Points Card`
  String get showPointsCard {
    return Intl.message(
      'Show Points Card',
      name: 'showPointsCard',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get onboardingSkip {
    return Intl.message('Skip', name: 'onboardingSkip', desc: '', args: []);
  }

  /// `Next`
  String get onboardingNext {
    return Intl.message('Next', name: 'onboardingNext', desc: '', args: []);
  }

  /// `Start Exploring`
  String get onboardingStart {
    return Intl.message(
      'Start Exploring',
      name: 'onboardingStart',
      desc: '',
      args: [],
    );
  }

  /// `Directory Services`
  String get onboardingTitle1 {
    return Intl.message(
      'Directory Services',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Everything you need in one place`
  String get onboardingDescription1 {
    return Intl.message(
      'Everything you need in one place',
      name: 'onboardingDescription1',
      desc: '',
      args: [],
    );
  }

  /// `Smart Travel Tools`
  String get onboardingTitle2 {
    return Intl.message(
      'Smart Travel Tools',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Plan your trip easily with smart travel bag, emergency guide, and local events`
  String get onboardingDescription2 {
    return Intl.message(
      'Plan your trip easily with smart travel bag, emergency guide, and local events',
      name: 'onboardingDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Rewards and Loyalty Points`
  String get onboardingTitle3 {
    return Intl.message(
      'Rewards and Loyalty Points',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Earn points with every booking and redeem them for exclusive discounts and unique benefits`
  String get onboardingDescription3 {
    return Intl.message(
      'Earn points with every booking and redeem them for exclusive discounts and unique benefits',
      name: 'onboardingDescription3',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get connectionErrorTitle {
    return Intl.message(
      'Connection Error',
      name: 'connectionErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Unable to establish connection with server.\nPlease check your internet connection and try again.`
  String get connectionErrorMessage {
    return Intl.message(
      'Unable to establish connection with server.\nPlease check your internet connection and try again.',
      name: 'connectionErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Retrying...`
  String get retrying {
    return Intl.message('Retrying...', name: 'retrying', desc: '', args: []);
  }

  /// `Back to Home`
  String get backToHome {
    return Intl.message('Back to Home', name: 'backToHome', desc: '', args: []);
  }

  /// `Connection failed. Please try again later.`
  String get connectionFailed {
    return Intl.message(
      'Connection failed. Please try again later.',
      name: 'connectionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Weight Exceeded`
  String get weightExceeded {
    return Intl.message(
      'Weight Exceeded',
      name: 'weightExceeded',
      desc: '',
      args: [],
    );
  }

  /// `The total weight will exceed the maximum allowed weight ({maxWeight} kg). Current weight: {currentWeight} kg. Item weight: {itemWeight} kg.`
  String weightExceededMessage(
    String maxWeight,
    String currentWeight,
    String itemWeight,
  ) {
    return Intl.message(
      'The total weight will exceed the maximum allowed weight ($maxWeight kg). Current weight: $currentWeight kg. Item weight: $itemWeight kg.',
      name: 'weightExceededMessage',
      desc: '',
      args: [maxWeight, currentWeight, itemWeight],
    );
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Report an Issue`
  String get reportIssue {
    return Intl.message(
      'Report an Issue',
      name: 'reportIssue',
      desc: '',
      args: [],
    );
  }

  /// `Contact support via email or WhatsApp`
  String get contactUsSubtitle {
    return Intl.message(
      'Contact support via email or WhatsApp',
      name: 'contactUsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose how to contact us`
  String get contactSupportTitle {
    return Intl.message(
      'Choose how to contact us',
      name: 'contactSupportTitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact via email`
  String get contactViaEmail {
    return Intl.message(
      'Contact via email',
      name: 'contactViaEmail',
      desc: '',
      args: [],
    );
  }

  /// `Contact via WhatsApp`
  String get contactViaWhatsApp {
    return Intl.message(
      'Contact via WhatsApp',
      name: 'contactViaWhatsApp',
      desc: '',
      args: [],
    );
  }

  /// `support@seasonksa.com`
  String get contactEmailAddress {
    return Intl.message(
      'support@seasonksa.com',
      name: 'contactEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp is not installed on your device`
  String get whatsappNotInstalled {
    return Intl.message(
      'WhatsApp is not installed on your device',
      name: 'whatsappNotInstalled',
      desc: '',
      args: [],
    );
  }

  /// `Could not open email app`
  String get emailAppNotAvailable {
    return Intl.message(
      'Could not open email app',
      name: 'emailAppNotAvailable',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
