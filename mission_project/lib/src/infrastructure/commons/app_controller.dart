import 'dart:ui';

import 'package:get/get.dart';
import 'package:mission_project/src/pages/shared/model/view_model/user_view_model.dart';

import '../routes/route_name.dart';
import 'storage_handler.dart';

class AppController {
  factory AppController() => _instance;

  AppController._();

  static final AppController _instance = AppController._();

  UserViewModel? currentUser;

  void setUser(UserViewModel user) => currentUser = user;

  void changeLanguage() {
    if (StorageHandler().getLocale() == 'fa') {
      StorageHandler().setLocale('en');
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      StorageHandler().setLocale('fa');
      Get.updateLocale(const Locale('fa', 'IR'));
    }
  }

  void logOut() {
    Get.offNamed(RouteName.loginPage);
    StorageHandler().setRememberedUserId(null);
  }
}
