import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/src/pages/shared/enums/user_type_enum.dart';

import '../../shared/model/view_model/user_view_model.dart';
import '../../shared/widgets/toast_widget.dart';
import '../model/user_dto.dart';

import '../repository/register_page_repository.dart';

class RegisterPageController extends GetxController {
  String title = 'register page app bar ';

  final Rxn<UserTypeEnum> userType = Rxn();

  final List<UserViewModel> users = [];

  final RegisterPageRepository _repository = RegisterPageRepository();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  Future<void> checkUserExist(BuildContext context) async {
    users.clear();
    final resultOrException = await _repository.getUser(
      usernameController.text,
    );
    return resultOrException.fold(
      ifLeft: (err) => ToastWidget.show(context, err),
      ifRight: (data) {
        users.addAll(data);
        ToastWidget.show(context, 'this username already exist');
      },
    );
  }

  Future<void> addUser(BuildContext context) async {
    if (passwordController.text != repeatPasswordController.text ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty) {
      ToastWidget.show(context, 'enter username and password');
      return;
    }
    await checkUserExist(context);
    if (users.isNotEmpty) {
      return;
    }
    final resultOrException = await _repository.addNewUser(
      UserDto(
        username: usernameController.text,
        password: passwordController.text,
        userType: userType.value!,
      ),
    );
    resultOrException.fold(
      ifLeft: (exception) => ToastWidget.show(context, exception),
      ifRight: (result) {
        Get.back(result: result);
        ToastWidget.show(context, "عملیات با موفقیت انجام شد");
      },
    );
  }
}
