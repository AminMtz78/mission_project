import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/commons/storage_handler.dart';
import '../../../infrastructure/routes/route_name.dart';
import '../../shared/model/view_model/user_view_model.dart';
import '../../shared/widgets/toast_widget.dart';
import '../repository/login_page_repository.dart';

class LoginPageController extends GetxController {
  final String title = 'login page app bar ';

  UserViewModel? user;

  RxBool isRememberUser = false.obs;

  final LoginPageRepository _repository = LoginPageRepository();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> goToRegisterPage(BuildContext context) async {
    final result = await Get.toNamed(RouteName.registerPage);
    if (result != null) {
      getUserById(context, result);
    }
  }

  Future<void> getUserById(BuildContext context, int id) async {
    final resultOrException = await _repository.getUser(id);

    resultOrException.fold(
      ifLeft: (err) => ToastWidget.show(context, err),
      ifRight: (user) {
        user = user;
        usernameController.text = user.username;

        passwordController.text = user.password;
      },
    );
  }

  Future<void> authenticate(BuildContext context) async {
    final resultOrException = await _repository.getUserByUsernameAndPassword(
      username: usernameController.text,
      password: passwordController.text,
    );

    resultOrException.fold(
      ifLeft: (err) => ToastWidget.show(context, err),
      ifRight: (userList) {
        if (userList.isNotEmpty) {
          if (isRememberUser.value) {
            StorageHandler.setRememberedUserId = userList.first.id;
          }
          // TODO : go to admin home page or hunter home page
        } else {
          ToastWidget.show(context, 'invalid username or password');
        }
      },
    );
  }
}
