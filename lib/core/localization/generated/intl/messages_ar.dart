// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(weight) => "الوزن التقريبي: ${weight} كجم";

  static String m1(count) => "${count} مفعلة";

  static String m2(current, max) => "${current} / ${max} كجم";

  static String m3(userName) => "أهلاً يا ${userName}!";

  static String m4(maxWeight, currentWeight, itemWeight) =>
      "سيتم تجاوز الوزن الأقصى المسموح به (${maxWeight} كجم). الوزن الحالي: ${currentWeight} كجم. وزن العنصر: ${itemWeight} كجم.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("حول"),
    "aboutApp": MessageLookupByLibrary.simpleMessage("حول التطبيق"),
    "account": MessageLookupByLibrary.simpleMessage("الحساب"),
    "accountStatistics": MessageLookupByLibrary.simpleMessage(
      "إحصائيات الحساب",
    ),
    "activeAlerts": MessageLookupByLibrary.simpleMessage("التنبيهات النشطة"),
    "addDescription": MessageLookupByLibrary.simpleMessage(
      "أضف وصفاً للمجموعة",
    ),
    "address": MessageLookupByLibrary.simpleMessage("العنوان"),
    "ago": MessageLookupByLibrary.simpleMessage("منذ"),
    "alertFrom": MessageLookupByLibrary.simpleMessage("تنبيه من"),
    "alertMessage": MessageLookupByLibrary.simpleMessage("الرسالة"),
    "alertResolved": MessageLookupByLibrary.simpleMessage("تم حل التنبيه"),
    "alertResolvedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حل تنبيه الطوارئ",
    ),
    "alertTime": MessageLookupByLibrary.simpleMessage("وقت التنبيه"),
    "alerts": MessageLookupByLibrary.simpleMessage("تنبيه"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "لديك حساب بالفعل؟",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("تطبيق سيزون"),
    "applyAsServiceProvider": MessageLookupByLibrary.simpleMessage(
      "التقدم كمزود خدمة",
    ),
    "applyAsTrader": MessageLookupByLibrary.simpleMessage("التقدم كتاجر"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "areYouSureDelete": MessageLookupByLibrary.simpleMessage("حذف الخدمة؟"),
    "areYouSureDeleteMessage": MessageLookupByLibrary.simpleMessage(
      "سيتم حذف الخدمة نهائيًا.",
    ),
    "askForCode": MessageLookupByLibrary.simpleMessage(
      "أو اطلب الكود من منشئ المجموعة",
    ),
    "availablePoints": MessageLookupByLibrary.simpleMessage("نقطة متاحة"),
    "backToHome": MessageLookupByLibrary.simpleMessage("العودة للرئيسية"),
    "bag": MessageLookupByLibrary.simpleMessage("الحقيبة"),
    "bagAISuggestionsButton": MessageLookupByLibrary.simpleMessage(
      "اقتراحات الذكاء الاصطناعي",
    ),
    "bagAddItemButton": MessageLookupByLibrary.simpleMessage("إضافة عنصر"),
    "bagAddItemError": MessageLookupByLibrary.simpleMessage(
      "فشل إضافة العنصر. يرجى المحاولة مرة أخرى.",
    ),
    "bagAddItemSubmit": MessageLookupByLibrary.simpleMessage(
      "إضافة إلى الحقيبة",
    ),
    "bagAddItemSuccess": MessageLookupByLibrary.simpleMessage(
      "تم إضافة العنصر بنجاح.",
    ),
    "bagAddItemTitle": MessageLookupByLibrary.simpleMessage("إضافة عنصر"),
    "bagAddReminderButton": MessageLookupByLibrary.simpleMessage("إضافة تذكير"),
    "bagApproxWeight": m0,
    "bagCategoriesTitle": MessageLookupByLibrary.simpleMessage("التصنيفات"),
    "bagDeleteCancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "bagDeleteConfirm": MessageLookupByLibrary.simpleMessage("حذف"),
    "bagDeleteItemError": MessageLookupByLibrary.simpleMessage(
      "فشل إزالة العنصر. يرجى المحاولة مرة أخرى.",
    ),
    "bagDeleteItemMessage": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد من إزالة هذا العنصر من حقيبتك؟",
    ),
    "bagDeleteItemSuccess": MessageLookupByLibrary.simpleMessage(
      "تم إزالة العنصر بنجاح.",
    ),
    "bagDeleteItemTitle": MessageLookupByLibrary.simpleMessage("إزالة العنصر؟"),
    "bagDeleteReminderMessage": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد من حذف هذا التذكير؟",
    ),
    "bagDeleteReminderTitle": MessageLookupByLibrary.simpleMessage(
      "حذف التذكير؟",
    ),
    "bagDeleteSuccess": MessageLookupByLibrary.simpleMessage(
      "تم حذف التذكير بنجاح.",
    ),
    "bagEditMaxWeight": MessageLookupByLibrary.simpleMessage(
      "تعديل الحد الأقصى للوزن",
    ),
    "bagEmptyDescription": MessageLookupByLibrary.simpleMessage(
      "ابدأ بإضافة أغراضك للاستعداد للسفر.",
    ),
    "bagEmptyTitle": MessageLookupByLibrary.simpleMessage("الحقيبة فارغة"),
    "bagItemsEmpty": MessageLookupByLibrary.simpleMessage(
      "لا توجد عناصر متاحة لهذا التصنيف حالياً.",
    ),
    "bagItemsError": MessageLookupByLibrary.simpleMessage(
      "تعذر تحميل عناصر هذا التصنيف.",
    ),
    "bagItemsTitle": MessageLookupByLibrary.simpleMessage("عناصر مقترحة"),
    "bagLoadingItems": MessageLookupByLibrary.simpleMessage(
      "جاري تحميل العناصر...",
    ),
    "bagMaxWeightInfo": MessageLookupByLibrary.simpleMessage(
      "اضبط الحد الأقصى للوزن لحقيبتك. يتم قياس الوزن دائماً بالكيلوجرام.",
    ),
    "bagMaxWeightInvalid": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال وزن صحيح",
    ),
    "bagMaxWeightLabel": MessageLookupByLibrary.simpleMessage(
      "الحد الأقصى للوزن",
    ),
    "bagMaxWeightPlaceholder": MessageLookupByLibrary.simpleMessage(
      "أدخل الحد الأقصى للوزن",
    ),
    "bagMaxWeightRequired": MessageLookupByLibrary.simpleMessage(
      "الحد الأقصى للوزن مطلوب",
    ),
    "bagMaxWeightUpdated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الحد الأقصى للوزن بنجاح",
    ),
    "bagNoCategories": MessageLookupByLibrary.simpleMessage(
      "لا توجد تصنيفات متاحة حالياً.",
    ),
    "bagNoItems": MessageLookupByLibrary.simpleMessage(
      "لا توجد عناصر متاحة لهذا التصنيف.",
    ),
    "bagPageContent": MessageLookupByLibrary.simpleMessage(
      "عناصر حقيبة التسوق الخاصة بك",
    ),
    "bagQuantityLabel": MessageLookupByLibrary.simpleMessage("الكمية"),
    "bagRemindersActiveCount": m1,
    "bagRemindersEmptyDescription": MessageLookupByLibrary.simpleMessage(
      "اضغط على \"إضافة تذكير\" لإنشاء أول تذكير لرحلتك.",
    ),
    "bagRemindersEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "لا توجد تذكيرات بعد",
    ),
    "bagRemindersTitle": MessageLookupByLibrary.simpleMessage("التذكيرات"),
    "bagSelectCategory": MessageLookupByLibrary.simpleMessage("التصنيف"),
    "bagSelectCategoryPlaceholder": MessageLookupByLibrary.simpleMessage(
      "اختر التصنيف",
    ),
    "bagSelectItem": MessageLookupByLibrary.simpleMessage("العنصر"),
    "bagSelectItemPlaceholder": MessageLookupByLibrary.simpleMessage(
      "اختر العنصر",
    ),
    "bagSelectWeightUnit": MessageLookupByLibrary.simpleMessage(
      "اختر وحدة الوزن",
    ),
    "bagSubtitle": MessageLookupByLibrary.simpleMessage("شنطة الشحن الرئيسية"),
    "bagTip1": MessageLookupByLibrary.simpleMessage(
      "ضع الأشياء الثقيلة في أسفل الحقيبة.",
    ),
    "bagTip2": MessageLookupByLibrary.simpleMessage(
      "لف الملابس بدلاً من طيها لتوفير المساحة.",
    ),
    "bagTip3": MessageLookupByLibrary.simpleMessage(
      "احتفظ بالأشياء القيمة في حقيبة اليد.",
    ),
    "bagTip4": MessageLookupByLibrary.simpleMessage(
      "تأكد من الوزن المسموح به لدى شركة الطيران.",
    ),
    "bagTipsTitle": MessageLookupByLibrary.simpleMessage("نصائح التعبئة"),
    "bagTitle": MessageLookupByLibrary.simpleMessage("حقيبة السفر"),
    "bagTotalWeightLabel": MessageLookupByLibrary.simpleMessage(
      "الوزن الإجمالي",
    ),
    "bagTypesTitle": MessageLookupByLibrary.simpleMessage("أنواع الحقائب"),
    "bagUpdateQuantityError": MessageLookupByLibrary.simpleMessage(
      "فشل تحديث الكمية. يرجى المحاولة مرة أخرى.",
    ),
    "bagUpdateQuantitySuccess": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الكمية بنجاح.",
    ),
    "bagWeight": m2,
    "bagWeightUnitKg": MessageLookupByLibrary.simpleMessage("كجم"),
    "bagWeightUnitLabel": MessageLookupByLibrary.simpleMessage("وحدة الوزن"),
    "birthDate": MessageLookupByLibrary.simpleMessage("تاريخ الميلاد"),
    "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "card": MessageLookupByLibrary.simpleMessage("البطاقة"),
    "cardPageContent": MessageLookupByLibrary.simpleMessage(
      "إدارة بطاقاتك هنا",
    ),
    "changePhoto": MessageLookupByLibrary.simpleMessage("تغيير الصورة"),
    "chooseFile": MessageLookupByLibrary.simpleMessage("اختر ملف"),
    "city": MessageLookupByLibrary.simpleMessage("المدينة"),
    "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
    "codeNotSent": MessageLookupByLibrary.simpleMessage("لم يصل الرمز؟"),
    "coins": MessageLookupByLibrary.simpleMessage("النقاط"),
    "collectPoints": MessageLookupByLibrary.simpleMessage(
      "أجمع نقاط الولاء عند التصفح و أستخدام خدمات الشركاء",
    ),
    "commercialRegister": MessageLookupByLibrary.simpleMessage(
      "السجل التجاري (PDF)",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmNewPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور الجديدة مطلوب",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور مطلوب",
    ),
    "confirmResolve": MessageLookupByLibrary.simpleMessage("حل التنبيه؟"),
    "confirmResolveMessage": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد من أنك تريد وضع علامة على هذا التنبيه كمحلول؟",
    ),
    "connectionErrorMessage": MessageLookupByLibrary.simpleMessage(
      "تعذر الاتصال بالخادم.\nيرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.",
    ),
    "connectionErrorTitle": MessageLookupByLibrary.simpleMessage(
      "خطأ في الاتصال",
    ),
    "connectionFailed": MessageLookupByLibrary.simpleMessage(
      "فشل الاتصال. يرجى المحاولة مرة أخرى لاحقاً.",
    ),
    "contactEmailAddress": MessageLookupByLibrary.simpleMessage(
      "support@seasonksa.com",
    ),
    "contactSupportTitle": MessageLookupByLibrary.simpleMessage(
      "اختر طريقة التواصل",
    ),
    "contactUs": MessageLookupByLibrary.simpleMessage("تواصل معي"),
    "contactUsSubtitle": MessageLookupByLibrary.simpleMessage(
      "تواصل مع الدعم عبر البريد أو واتساب",
    ),
    "contactViaEmail": MessageLookupByLibrary.simpleMessage(
      "تواصل عن طريق إرسال إيميل",
    ),
    "contactViaWhatsApp": MessageLookupByLibrary.simpleMessage(
      "تواصل عبر واتساب",
    ),
    "copied": MessageLookupByLibrary.simpleMessage("تم النسخ!"),
    "copy": MessageLookupByLibrary.simpleMessage("نسخ"),
    "country": MessageLookupByLibrary.simpleMessage("الدولة"),
    "create": MessageLookupByLibrary.simpleMessage("إنشاء"),
    "createGroup": MessageLookupByLibrary.simpleMessage("إنشاء مجموعة"),
    "createGroupDescription": MessageLookupByLibrary.simpleMessage(
      "أنشئ مجموعة لتتبع أصدقائك وعائلتك",
    ),
    "createNewGroup": MessageLookupByLibrary.simpleMessage(
      "ابدأ بإنشاء مجموعة جديدة\nأو انضم لمجموعة موجودة",
    ),
    "createNewGroupTitle": MessageLookupByLibrary.simpleMessage(
      "إنشاء مجموعة جديدة",
    ),
    "createService": MessageLookupByLibrary.simpleMessage("إنشاء خدمة"),
    "currency": MessageLookupByLibrary.simpleMessage("العملة"),
    "currencyAmount": MessageLookupByLibrary.simpleMessage("المبلغ"),
    "currencyAmountInvalid": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال مبلغ صحيح",
    ),
    "currencyAmountPlaceholder": MessageLookupByLibrary.simpleMessage(
      "أدخل المبلغ",
    ),
    "currencyAmountRequired": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال المبلغ",
    ),
    "currencyConvert": MessageLookupByLibrary.simpleMessage("تحويل"),
    "currencyConvertedAmount": MessageLookupByLibrary.simpleMessage(
      "المبلغ المحول",
    ),
    "currencyConverter": MessageLookupByLibrary.simpleMessage("محول العملة"),
    "currencyConverterSubtitle": MessageLookupByLibrary.simpleMessage(
      "تحويل العملات فوراً",
    ),
    "currencyExchangeRate": MessageLookupByLibrary.simpleMessage(
      "سعر الصرف الإرشادي",
    ),
    "currencyFrom": MessageLookupByLibrary.simpleMessage("من"),
    "currencyRate": MessageLookupByLibrary.simpleMessage("السعر"),
    "currencyTo": MessageLookupByLibrary.simpleMessage("إلى"),
    "darkMode": MessageLookupByLibrary.simpleMessage("الوضع الليلي"),
    "days": MessageLookupByLibrary.simpleMessage("أيام"),
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("حذف الحساب"),
    "deleteAccountConfirmButton": MessageLookupByLibrary.simpleMessage(
      "نعم، احذف الحساب",
    ),
    "deleteAccountConfirmation": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد حذف حسابك؟",
    ),
    "deleteAccountFailure": MessageLookupByLibrary.simpleMessage(
      "تعذر حذف الحساب. حاول مرة أخرى.",
    ),
    "deleteAccountSubtitle": MessageLookupByLibrary.simpleMessage(
      "حذف حسابك وبياناتك نهائياً",
    ),
    "deleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "تم حذف حسابك بنجاح",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "لا يمكن التراجع عن هذا الإجراء. سيتم حذف جميع بياناتك نهائياً.",
    ),
    "deleteGroup": MessageLookupByLibrary.simpleMessage("حذف المجموعة"),
    "deletePermanently": MessageLookupByLibrary.simpleMessage("حذف نهائي"),
    "description": MessageLookupByLibrary.simpleMessage("الوصف"),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage(
      "الوصف (اختياري)",
    ),
    "details": MessageLookupByLibrary.simpleMessage("التفاصيل"),
    "digitalDirectory": MessageLookupByLibrary.simpleMessage("الدليل الرقمي"),
    "directions": MessageLookupByLibrary.simpleMessage("الاتجاهات"),
    "directionsDescription": MessageLookupByLibrary.simpleMessage(
      "احصل على الاتجاهات إلى موقع الطوارئ هذا باستخدام تطبيق الخرائط المفضل لديك",
    ),
    "directionsToAlert": MessageLookupByLibrary.simpleMessage(
      "الاتجاهات إلى موقع الطوارئ",
    ),
    "disable": MessageLookupByLibrary.simpleMessage("تعطيل"),
    "distance": MessageLookupByLibrary.simpleMessage("المسافة"),
    "distanceAllowed": MessageLookupByLibrary.simpleMessage(
      "المسافة المسموح بها قبل إرسال تنبيه",
    ),
    "dontGetLost": MessageLookupByLibrary.simpleMessage("عدم الضياع"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
    "edit": MessageLookupByLibrary.simpleMessage("تعديل"),
    "editProfile": MessageLookupByLibrary.simpleMessage("تعديل الملف الشخصي"),
    "editService": MessageLookupByLibrary.simpleMessage("تعديل الخدمة"),
    "email": MessageLookupByLibrary.simpleMessage("البريد الالكتروني"),
    "emailAppNotAvailable": MessageLookupByLibrary.simpleMessage(
      "تعذر فتح تطبيق البريد",
    ),
    "emailNotVerified": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني غير موثّق",
    ),
    "emailNotifications": MessageLookupByLibrary.simpleMessage(
      "إشعارات البريد الإلكتروني",
    ),
    "emailVerificationHint": MessageLookupByLibrary.simpleMessage(
      "وثّق بريدك الإلكتروني لتأمين حسابك",
    ),
    "emailVerificationSent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رمز التحقق إلى بريدك الإلكتروني",
    ),
    "emailVerified": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني موثّق",
    ),
    "emergencyAlerts": MessageLookupByLibrary.simpleMessage(
      "🚨 تنبيهات الطوارئ",
    ),
    "emergencyAmbulance": MessageLookupByLibrary.simpleMessage("الإسعاف"),
    "emergencyEmbassy": MessageLookupByLibrary.simpleMessage("السفارة"),
    "emergencyError": MessageLookupByLibrary.simpleMessage(
      "فشل تحميل أرقام الطوارئ",
    ),
    "emergencyErrorDescription": MessageLookupByLibrary.simpleMessage(
      "يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى",
    ),
    "emergencyFire": MessageLookupByLibrary.simpleMessage("الإطفاء"),
    "emergencyLocation": MessageLookupByLibrary.simpleMessage("موقع الطوارئ"),
    "emergencyNumbers": MessageLookupByLibrary.simpleMessage("أرقام الطوارئ"),
    "emergencyPolice": MessageLookupByLibrary.simpleMessage("الشرطة"),
    "emergencyQuickAccess": MessageLookupByLibrary.simpleMessage(
      "اضغط لعرض جهات اتصال الطوارئ",
    ),
    "emergencySubtitle": MessageLookupByLibrary.simpleMessage(
      "وصول سريع لخدمات الطوارئ",
    ),
    "enable": MessageLookupByLibrary.simpleMessage("تفعيل"),
    "enableNotifications": MessageLookupByLibrary.simpleMessage(
      "تفعيل الإشعارات",
    ),
    "endpoint": MessageLookupByLibrary.simpleMessage("نقطة النهاية:"),
    "english": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
    "enterCodeManually": MessageLookupByLibrary.simpleMessage(
      "إدخال الكود يدوياً",
    ),
    "enterEmailToReceiveResetCode": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدك الإلكتروني لتلقي رمز إعادة التعيين",
    ),
    "enterInviteCode": MessageLookupByLibrary.simpleMessage(
      "أدخل كود الدعوة للانضمام إلى المجموعة",
    ),
    "enterNewPassword": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور الجديدة",
    ),
    "errorDetails": MessageLookupByLibrary.simpleMessage("تفاصيل الخطأ:"),
    "errorLoadingCardData": MessageLookupByLibrary.simpleMessage(
      "خطأ في تحميل بيانات البطاقة",
    ),
    "errorLoadingGroup": MessageLookupByLibrary.simpleMessage(
      "خطأ في تحميل المجموعة",
    ),
    "errorLoadingProfile": MessageLookupByLibrary.simpleMessage(
      "خطأ في تحميل الملف الشخصي",
    ),
    "errorUpdatingProfile": MessageLookupByLibrary.simpleMessage(
      "خطأ في تحديث الملف الشخصي",
    ),
    "events": MessageLookupByLibrary.simpleMessage("الفعاليات"),
    "eventsEmptyDescription": MessageLookupByLibrary.simpleMessage(
      "سنُعرض الفعاليات والأنشطة في منطقتك قريباً. تابعنا لاحقاً.",
    ),
    "eventsEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "لا توجد فعاليات حالياً",
    ),
    "exclusiveRewards": MessageLookupByLibrary.simpleMessage(
      "أحصل علي مكافآت حصرية",
    ),
    "female": MessageLookupByLibrary.simpleMessage("أنثى"),
    "firstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
    "forgetPassword": MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
    "fromCenter": MessageLookupByLibrary.simpleMessage("من المركز"),
    "gallery": MessageLookupByLibrary.simpleMessage("المعرض"),
    "gender": MessageLookupByLibrary.simpleMessage("الجنس"),
    "general": MessageLookupByLibrary.simpleMessage("عام"),
    "geographicDirectory": MessageLookupByLibrary.simpleMessage(
      "الدليل الجغرافي",
    ),
    "getDirections": MessageLookupByLibrary.simpleMessage(
      "الحصول على الاتجاهات",
    ),
    "getInstantAlerts": MessageLookupByLibrary.simpleMessage(
      "احصل على تنبيهات فورية",
    ),
    "goBack": MessageLookupByLibrary.simpleMessage("رجوع"),
    "group": MessageLookupByLibrary.simpleMessage("المجموعة"),
    "groupName": MessageLookupByLibrary.simpleMessage("اسم المجموعة"),
    "groupNameExample": MessageLookupByLibrary.simpleMessage(
      "مثال: رحلة دبي - العائلة",
    ),
    "groupNotFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على المجموعة",
    ),
    "groupPageContent": MessageLookupByLibrary.simpleMessage(
      "عرض وإدارة مجموعاتك",
    ),
    "groups": MessageLookupByLibrary.simpleMessage("مجموعة"),
    "helloUser": m3,
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "homePageContent": MessageLookupByLibrary.simpleMessage(
      "مرحباً بك في الصفحة الرئيسية",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("ساعات"),
    "howToUseCard": MessageLookupByLibrary.simpleMessage("كيف تستخدم البطاقة"),
    "imagePickerCamera": MessageLookupByLibrary.simpleMessage(
      "استخدام الكاميرا",
    ),
    "imagePickerGallery": MessageLookupByLibrary.simpleMessage(
      "اختيار من المعرض",
    ),
    "invalidCodeFormat": MessageLookupByLibrary.simpleMessage("كود غير صالح"),
    "inviteCode": MessageLookupByLibrary.simpleMessage("كود الدعوة"),
    "inviteCodeTitle": MessageLookupByLibrary.simpleMessage("كود الدعوة"),
    "joinAGroup": MessageLookupByLibrary.simpleMessage("انضم إلى مجموعة"),
    "joinGroup": MessageLookupByLibrary.simpleMessage("انضم لمجموعة"),
    "joinNow": MessageLookupByLibrary.simpleMessage("انضم الآن"),
    "joining": MessageLookupByLibrary.simpleMessage("جاري الانضمام..."),
    "justNow": MessageLookupByLibrary.simpleMessage("الآن"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "languageChanged": MessageLookupByLibrary.simpleMessage(
      "تم تغيير اللغة بنجاح",
    ),
    "lastName": MessageLookupByLibrary.simpleMessage("الاسم الأخير"),
    "latitude": MessageLookupByLibrary.simpleMessage("خط العرض"),
    "leaveGroup": MessageLookupByLibrary.simpleMessage("مغادرة المجموعة"),
    "listView": MessageLookupByLibrary.simpleMessage("عرض القائمة"),
    "loading": MessageLookupByLibrary.simpleMessage("جاري التحميل"),
    "location": MessageLookupByLibrary.simpleMessage("الموقع"),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد تسجيل الخروج؟",
    ),
    "longitude": MessageLookupByLibrary.simpleMessage("خط الطول"),
    "loyaltyCard": MessageLookupByLibrary.simpleMessage("بطاقة الولاء"),
    "loyaltyPoints": MessageLookupByLibrary.simpleMessage("نقاط الولاء"),
    "male": MessageLookupByLibrary.simpleMessage("ذكر"),
    "mapView": MessageLookupByLibrary.simpleMessage("عرض الخريطة"),
    "mapsAppNotFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على تطبيق خرائط على جهازك",
    ),
    "markAsResolved": MessageLookupByLibrary.simpleMessage("وضع علامة كمحلول"),
    "member": MessageLookupByLibrary.simpleMessage("عضو"),
    "meters": MessageLookupByLibrary.simpleMessage("متر"),
    "minutes": MessageLookupByLibrary.simpleMessage("دقائق"),
    "myServices": MessageLookupByLibrary.simpleMessage("خدماتي"),
    "name": MessageLookupByLibrary.simpleMessage("الاسم"),
    "needHelp": MessageLookupByLibrary.simpleMessage("أحتاج المساعدة!"),
    "newService": MessageLookupByLibrary.simpleMessage("خدمة جديدة"),
    "nickname": MessageLookupByLibrary.simpleMessage("الاسم المستعار"),
    "noActiveAlerts": MessageLookupByLibrary.simpleMessage(
      "لا توجد تنبيهات نشطة",
    ),
    "noAlertsMessage": MessageLookupByLibrary.simpleMessage(
      "ممتاز! لا توجد تنبيهات طوارئ في الوقت الحالي.\nمجموعتك آمنة.",
    ),
    "noAppsAvailable": MessageLookupByLibrary.simpleMessage(
      "لا توجد تطبيقات متاحة",
    ),
    "noCategoriesAvailable": MessageLookupByLibrary.simpleMessage(
      "لا توجد تصنيفات متاحة",
    ),
    "noGroupsYet": MessageLookupByLibrary.simpleMessage("لا توجد مجموعات"),
    "noServicesYet": MessageLookupByLibrary.simpleMessage(
      "لا توجد خدمات حتى الآن",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "onboardingDescription1": MessageLookupByLibrary.simpleMessage(
      "كل ما تحتاجه في مكان واحد",
    ),
    "onboardingDescription2": MessageLookupByLibrary.simpleMessage(
      "خطط رحلتك بسهولة مع حقيبة السفر الذكية، دليل الطوارئ، والفعاليات المحلية",
    ),
    "onboardingDescription3": MessageLookupByLibrary.simpleMessage(
      "أكسب نقاط مع كل حجز واستبدلها بخصومات حصرية ومزايا فريدة",
    ),
    "onboardingNext": MessageLookupByLibrary.simpleMessage("التالي"),
    "onboardingSkip": MessageLookupByLibrary.simpleMessage("تخطي"),
    "onboardingStart": MessageLookupByLibrary.simpleMessage("أبدأ الاستكشاف"),
    "onboardingTitle1": MessageLookupByLibrary.simpleMessage("خدمات الدليل"),
    "onboardingTitle2": MessageLookupByLibrary.simpleMessage(
      "أدوات السفر الذكية",
    ),
    "onboardingTitle3": MessageLookupByLibrary.simpleMessage(
      "مكافآت ونقاط ولاء",
    ),
    "openInMaps": MessageLookupByLibrary.simpleMessage("فتح في الخرائط"),
    "openRegister": MessageLookupByLibrary.simpleMessage("فتح السجل التجاري"),
    "optional": MessageLookupByLibrary.simpleMessage("اختياري"),
    "or": MessageLookupByLibrary.simpleMessage("أو"),
    "orText": MessageLookupByLibrary.simpleMessage("أو"),
    "owner": MessageLookupByLibrary.simpleMessage("مالك"),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "كلمتا المرور غير متطابقتين",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("معلق"),
    "personalInformation": MessageLookupByLibrary.simpleMessage(
      "المعلومات الشخصية",
    ),
    "phone": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "placeQrCode": MessageLookupByLibrary.simpleMessage(
      "ضع رمز QR داخل الإطار",
    ),
    "pleaseEnterGroupName": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال اسم المجموعة",
    ),
    "pleaseEnterInviteCode": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال كود الدعوة",
    ),
    "pleaseEnterName": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال اسمك",
    ),
    "points": MessageLookupByLibrary.simpleMessage("نقاط"),
    "preferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
    "profile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
    "profilePageContent": MessageLookupByLibrary.simpleMessage(
      "عرض وتعديل ملفك الشخصي",
    ),
    "profileUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الملف الشخصي بنجاح",
    ),
    "pushNotifications": MessageLookupByLibrary.simpleMessage(
      "إشعارات التطبيق",
    ),
    "qrCodeUsage": MessageLookupByLibrary.simpleMessage(
      "أستخدم رمز الاستجابة السريعة QR للربط مع الأجهزة ضمن المجموعات الأمنة",
    ),
    "radius": MessageLookupByLibrary.simpleMessage("نطاق الأمان"),
    "readPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "اقرأ سياسة الخصوصية الخاصة بنا",
    ),
    "redeemSoon": MessageLookupByLibrary.simpleMessage("استبدل قريبًا"),
    "remaining": MessageLookupByLibrary.simpleMessage("متبقي"),
    "reminderAddButton": MessageLookupByLibrary.simpleMessage("حفظ التذكير"),
    "reminderAddTitle": MessageLookupByLibrary.simpleMessage("إضافة تذكير"),
    "reminderAttachmentAdd": MessageLookupByLibrary.simpleMessage("إضافة صورة"),
    "reminderAttachmentLabel": MessageLookupByLibrary.simpleMessage(
      "مرفق (اختياري)",
    ),
    "reminderCreateSuccess": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء التذكير بنجاح.",
    ),
    "reminderDateLabel": MessageLookupByLibrary.simpleMessage("التاريخ"),
    "reminderDatePlaceholder": MessageLookupByLibrary.simpleMessage(
      "اختر التاريخ",
    ),
    "reminderDateValidation": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار التاريخ.",
    ),
    "reminderEditTitle": MessageLookupByLibrary.simpleMessage("تعديل التذكير"),
    "reminderLoadError": MessageLookupByLibrary.simpleMessage(
      "تعذر تحديث التذكيرات، يرجى المحاولة مرة أخرى.",
    ),
    "reminderNotesLabel": MessageLookupByLibrary.simpleMessage(
      "ملاحظات (اختياري)",
    ),
    "reminderNotesPlaceholder": MessageLookupByLibrary.simpleMessage(
      "أضف أي ملاحظات إضافية تساعدك على التذكر.",
    ),
    "reminderRecurrenceCustom": MessageLookupByLibrary.simpleMessage("مخصص"),
    "reminderRecurrenceDaily": MessageLookupByLibrary.simpleMessage("يومي"),
    "reminderRecurrenceLabel": MessageLookupByLibrary.simpleMessage("التكرار"),
    "reminderRecurrenceOnce": MessageLookupByLibrary.simpleMessage("مرة واحدة"),
    "reminderRecurrenceWeekly": MessageLookupByLibrary.simpleMessage("أسبوعي"),
    "reminderSaveError": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء حفظ التذكير.",
    ),
    "reminderSubtitle": MessageLookupByLibrary.simpleMessage(
      "حدد تفاصيل التذكير حتى لا تفوت أي مهمة سفر مهمة.",
    ),
    "reminderTimeLabel": MessageLookupByLibrary.simpleMessage("الوقت"),
    "reminderTimePlaceholder": MessageLookupByLibrary.simpleMessage(
      "اختر الوقت",
    ),
    "reminderTimeValidation": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار الوقت.",
    ),
    "reminderTitleLabel": MessageLookupByLibrary.simpleMessage("عنوان التذكير"),
    "reminderTitlePlaceholder": MessageLookupByLibrary.simpleMessage(
      "مثال: جهز جواز السفر",
    ),
    "reminderTitleValidation": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال عنوان التذكير.",
    ),
    "reminderUpdateButton": MessageLookupByLibrary.simpleMessage(
      "تحديث التذكير",
    ),
    "reminderUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تحديث التذكير بنجاح.",
    ),
    "reportIssue": MessageLookupByLibrary.simpleMessage("الإبلاغ عن مشكلة"),
    "required": MessageLookupByLibrary.simpleMessage("مطلوب"),
    "resendCode": MessageLookupByLibrary.simpleMessage("إعادة الإرسال"),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "resolveAlert": MessageLookupByLibrary.simpleMessage("حل التنبيه"),
    "resolved": MessageLookupByLibrary.simpleMessage("محلول"),
    "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "retrying": MessageLookupByLibrary.simpleMessage("جاري إعادة المحاولة..."),
    "safetyRadius": MessageLookupByLibrary.simpleMessage("نطاق الأمان"),
    "save": MessageLookupByLibrary.simpleMessage("حفظ"),
    "saving": MessageLookupByLibrary.simpleMessage("جاري الحفظ"),
    "scanQr": MessageLookupByLibrary.simpleMessage("مسح QR"),
    "scanQrCode": MessageLookupByLibrary.simpleMessage("مسح رمز QR"),
    "scanningWillStart": MessageLookupByLibrary.simpleMessage(
      "سيتم المسح تلقائياً",
    ),
    "seconds": MessageLookupByLibrary.simpleMessage("ثانية"),
    "selectBirthDate": MessageLookupByLibrary.simpleMessage(
      "اختر تاريخ الميلاد",
    ),
    "selectImage": MessageLookupByLibrary.simpleMessage("اختيار صورة"),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("اختر اللغة"),
    "selectLocation": MessageLookupByLibrary.simpleMessage("اختر الموقع"),
    "selectOnMap": MessageLookupByLibrary.simpleMessage("اختر على الخريطة"),
    "sendResetCode": MessageLookupByLibrary.simpleMessage(
      "إرسال رمز إعادة التعيين",
    ),
    "serviceDetails": MessageLookupByLibrary.simpleMessage("تفاصيل الخدمة"),
    "serviceImages": MessageLookupByLibrary.simpleMessage("صور الخدمة"),
    "serviceName": MessageLookupByLibrary.simpleMessage("اسم الخدمة"),
    "serviceType": MessageLookupByLibrary.simpleMessage("نوع الخدمة"),
    "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "showPointsCard": MessageLookupByLibrary.simpleMessage("عرض بطاقة النقاط"),
    "signUp": MessageLookupByLibrary.simpleMessage("سجل الآن"),
    "sosAlert": MessageLookupByLibrary.simpleMessage("🚨 إشارة SOS - طوارئ"),
    "sosAlerts": MessageLookupByLibrary.simpleMessage("تنبيهات الطوارئ"),
    "sosEmergency": MessageLookupByLibrary.simpleMessage("طوارئ SOS"),
    "startNow": MessageLookupByLibrary.simpleMessage("ابدأ الان"),
    "status": MessageLookupByLibrary.simpleMessage("الحالة"),
    "support": MessageLookupByLibrary.simpleMessage("الدعم الفني"),
    "tapToResolve": MessageLookupByLibrary.simpleMessage(
      "اضغط لحل هذا التنبيه",
    ),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "الشروط والأحكام",
    ),
    "termsOfService": MessageLookupByLibrary.simpleMessage("شروط الخدمة"),
    "theme": MessageLookupByLibrary.simpleMessage("المظهر"),
    "trackYourGroup": MessageLookupByLibrary.simpleMessage(
      "تتبع مجموعتك بسهولة وأمان",
    ),
    "trips": MessageLookupByLibrary.simpleMessage("الرحلات"),
    "update": MessageLookupByLibrary.simpleMessage("تحديث"),
    "updateProfile": MessageLookupByLibrary.simpleMessage("تحديث الملف الشخصي"),
    "vendorServices": MessageLookupByLibrary.simpleMessage("خدمات البائعين"),
    "verify": MessageLookupByLibrary.simpleMessage("تحقق"),
    "verifyEmailNow": MessageLookupByLibrary.simpleMessage("توثيق البريد"),
    "verifyMail": MessageLookupByLibrary.simpleMessage(
      "تحقق من البريد الالكتروني",
    ),
    "verifyMailBody": MessageLookupByLibrary.simpleMessage(
      "لقد أرسلنا رمز تحقق مكوّن من 4 أرقام إلى بريدك الإلكتروني",
    ),
    "version": MessageLookupByLibrary.simpleMessage("الإصدار"),
    "viewAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "viewOnMap": MessageLookupByLibrary.simpleMessage("عرض على الخريطة"),
    "weightExceeded": MessageLookupByLibrary.simpleMessage(
      "تم تجاوز الوزن المسموح",
    ),
    "weightExceededMessage": m4,
    "welcome": MessageLookupByLibrary.simpleMessage("مرحبًا!"),
    "welcomeLogin": MessageLookupByLibrary.simpleMessage(
      "مرحباً بعودتك إلي SEASON",
    ),
    "welcomeSignUp": MessageLookupByLibrary.simpleMessage(
      "أنشئ حسابك وابدأ الآن!",
    ),
    "welcomeText": MessageLookupByLibrary.simpleMessage(
      "رفيقك الشامل في كل رحلة",
    ),
    "whatsappNotInstalled": MessageLookupByLibrary.simpleMessage(
      "واتساب غير مثبت على جهازك",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("نعم"),
    "yourLoyaltyPoints": MessageLookupByLibrary.simpleMessage(
      "نقاط الولاء الخاصة بك",
    ),
    "yourServices": MessageLookupByLibrary.simpleMessage("خدماتك"),
  };
}
