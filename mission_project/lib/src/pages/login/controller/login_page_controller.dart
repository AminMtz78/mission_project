import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../../infrastructure/commons/storage_handler.dart';
import '../../../infrastructure/routes/route_name.dart';
import '../../../infrastructure/routes/route_path.dart';
import '../../shared/enums/user_type_enum.dart';
import '../../shared/model/view_model/user_view_model.dart';
import '../repository/login_page_repository.dart';

class LoginPageController extends GetxController {
  final String title = LocaleKeys.login_login.tr;

  UserViewModel? user;
  final RxBool isObscure = true.obs;
  final RxBool isLoading = false.obs;

  final RxBool isRememberUser = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey();

  final LoginPageRepository _repository = LoginPageRepository();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  Future<void> goToRegisterPage() async {
    final result = await Get.toNamed(RouteName.registerPage);
    if (result != null) {
      getUserById(result);
    }
  }

  Future<void> getUserById(int id) async {
    final resultOrException = await _repository.getUser(id);

    resultOrException.fold(
      ifLeft: (err) =>
          Get.snackbar('', LocaleKeys.shared_server_communication_error.tr),
      ifRight: (user) {
        user = user;
        usernameController.text = user.username;
        passwordController.text = user.password;
      },
    );
  }

  Future<void> authenticate() async {
    if (formKey.currentState!.validate()) {
      isLoading(true);
      final resultOrException = await _repository.getUserByUsernameAndPassword(
        username: usernameController.text,
        password: passwordController.text,
      );

      resultOrException.fold(
        ifLeft: (err) =>
            Get.snackbar('', LocaleKeys.shared_server_communication_error.tr),
        ifRight: (userList) {
          if (userList.isNotEmpty) {
            AppController().setUser(userList.first);
            if (isRememberUser.value) {
              StorageHandler().setRememberedUserId(userList.first.id);
            }
            if (userList.first.userType == UserTypeEnum.admin) {
              Get.offNamed(RoutePath.adminHomePage);
            } else {
              Get.offNamed(RoutePath.hunterMissionList);
            }
          } else {
            Get.snackbar('', LocaleKeys.login_invalid_username_or_password.tr);
          }
        },
      );
      isLoading(false);
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.login_Password_cannot_be_empty.tr;
    }
    return null;
  }

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.login_Username_cannot_be_empty.tr;
    }
    return null;
  }
}
