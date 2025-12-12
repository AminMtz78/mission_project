import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/generated/locales.g.dart';
import 'package:mission_project/src/pages/shared/enums/user_type_enum.dart';
import 'package:mission_project/src/pages/shared/widgets/my_button.dart';

import '../../../infrastructure/utils/utils.dart';
import '../controller/register_page_controller.dart';

class RegisterPage extends GetView<RegisterPageController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: Utils.largePadding,
          child: Column(
            children: [
              _adminAndHunter(),
              Utils.mediumVerticalSpacer,
              _usernameAndPassWordWidget(context),
              Utils.giantVerticalSpacer,
              _registerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _adminAndHunter() {
    return Obx(
      () => RadioGroup<UserTypeEnum>(
        groupValue: controller.userType.value,
        onChanged: (value) => controller.userType.value = value,
        child: Column(
          children: [
            Row(
              children: [
                Text(UserTypeEnum.admin.title.tr),
                Radio<UserTypeEnum>(value: UserTypeEnum.admin),
              ],
            ),
            Utils.smallVerticalSpacer,
            Row(
              children: [
                Text(UserTypeEnum.hunter.title.tr),
                Radio<UserTypeEnum>(value: UserTypeEnum.hunter),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _usernameAndPassWordWidget(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.login_username.tr),
          Utils.smallVerticalSpacer,
          TextFormField(
            validator: controller.validateUsername,
            controller: controller.usernameController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          Utils.largeVerticalSpacer,
          Text(LocaleKeys.login_password.tr),
          Utils.smallVerticalSpacer,
          Obx(
            () => TextFormField(
              validator: (value) => controller.validatePassword(value),
              obscureText: controller.isObscure.value,
              controller: controller.passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isObscure.value = !controller.isObscure.value;
                  },
                  icon: controller.isObscure.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
            ),
          ),
          Utils.giantVerticalSpacer,
          Text(LocaleKeys.login_password.tr),
          Utils.smallVerticalSpacer,
          Obx(
            () => TextFormField(
              obscureText: controller.isObscureRepeat.value,
              controller: controller.repeatPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isObscureRepeat.value =
                        !controller.isObscureRepeat.value;
                  },
                  icon: controller.isObscureRepeat.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return Obx(
      () => MyButton(
        isLoading: controller.isLoading.value,
        title: LocaleKeys.login_register.tr,
        onPressed: () => controller.addUser(context),
      ),
    );
  }
}
