import 'package:get/get.dart';

class FontManager {
  static const String fontFamilyArabic = "Cairo";
  static const String fontFamilyEnglish = "SegoeUI";
  static final String currentFontFamily = Get.locale?.languageCode == 'ar' ? fontFamilyArabic : fontFamilyEnglish;
}
