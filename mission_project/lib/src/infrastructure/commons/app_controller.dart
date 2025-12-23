import 'dart:ui';

import 'package:get/get.dart';

import '../../pages/shared/model/view_model/user_view_model.dart';
import '../routes/route_name.dart';
import 'storage_handler.dart';

class AppController {
  factory AppController() => _instance;

  AppController._();

  static final AppController _instance = AppController._();

  UserViewModel? currentUser;

  void setUser(UserViewModel user) => currentUser = user;

  void changeLanguage() {
    final current = StorageHandler().getLocale();
    if (current == 'fa') {
      StorageHandler().setLocale('en');
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      StorageHandler().setLocale('fa');
      Get.updateLocale(const Locale('fa', 'IR'));
    }
  }

  void logOut() {
    Get.offAndToNamed(RouteName.loginPage);
    StorageHandler().setRememberedUserId(null);
    currentUser = null;
  }
}
