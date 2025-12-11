import 'dart:ui';

import 'package:get/get.dart';
import 'storage_handler.dart';

class AppController {
  factory AppController() => _instance;

  AppController._();

  static final AppController _instance = AppController._();

  void changeLanguage() {
    if (StorageHandler.locale == 'en') {
      StorageHandler.setLocale = 'fa';

      Get.updateLocale(const Locale('fa', 'IR'));
    } else {
      StorageHandler.setLocale = 'en';
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}
