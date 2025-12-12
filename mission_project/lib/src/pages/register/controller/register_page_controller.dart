import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../generated/locales.g.dart';
import '../../shared/enums/user_type_enum.dart';
import '../../shared/model/view_model/user_view_model.dart';
import '../../shared/widgets/toast_widget.dart';
import '../model/user_dto.dart';
import '../repository/register_page_repository.dart';

class RegisterPageController extends GetxController {
  String title = 'register page app bar ';

  final Rxn<UserTypeEnum> userType = Rxn();
  final GlobalKey<FormState> formKey = GlobalKey();
  final RxBool isObscure = true.obs;
  final RxBool isObscureRepeat = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool isRetry = false.obs;

  final List<UserViewModel> users = [];

  final RegisterPageRepository _repository = RegisterPageRepository();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  Future<void> checkUserExist(BuildContext context) async {
   if(formKey.currentState!.validate()){
     isLoading(true);
     isRetry(false);
     users.clear();
     final resultOrException = await _repository.getUser(
       usernameController.text,
     );
     return resultOrException.fold(
       ifLeft: (err) {
         ToastWidget.show(context, err);
         isRetry(true);
         isLoading(false);
       },
       ifRight: (data) {
         users.addAll(data);
         ToastWidget.show(context, 'this username already exist');
         isLoading(false);
       },
     );
   }
  }

  Future<void> addUser(BuildContext context) async {
   if(formKey.currentState!.validate()){
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
         ToastWidget.show(
           context,
           LocaleKeys.shared_The_operation_was_successful.tr,
         );
       },
     );
   }
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.login_Username_cannot_be_empty.tr;
    }

    final username = value.trim();

    if (username.length < 3) {
      return LocaleKeys.login_Username_must_be_at_least_3_characters.tr;
    }

    if (username.length > 20) {
      return LocaleKeys.login_Username_cannot_exceed_20_characters.tr;
    }

    final regex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$');
    if (!regex.hasMatch(username)) {
      return LocaleKeys
          .login_Username_must_start_with_a_letter_and_contain_only_letters
          .tr;
    }

    if (RegExp(r'^[0-9]+$').hasMatch(username)) {
      return LocaleKeys.login_Username_cannot_be_only_numbers.tr;
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.login_Password_cannot_be_empty.tr;
    }

    if (value.length < 8) {
      return LocaleKeys.login_Password_must_be_at_least_8_characters.tr;
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return LocaleKeys.login_At_least_one_uppercase_letter_is_required.tr;
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return LocaleKeys.login_At_least_one_number_is_required.tr;
    }

    if (!RegExp(r'[!@#$%^&*(),.?\":{}|<>]').hasMatch(value)) {
      return LocaleKeys.login_At_least_one_special_character_is_required.tr;
    }

    final weak = ["123456", "password", "qwerty", "111111"];
    for (var w in weak) {
      if (value.toLowerCase().contains(w)) {
        return LocaleKeys.login_Password_is_too_weak.tr;
      }
    }

    return null;
  }
}
