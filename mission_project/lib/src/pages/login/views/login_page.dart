import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../shared/enums/breakpoint.dart';
import '../../shared/widgets/custom_flexible_widget.dart';
import '../../shared/widgets/my_button.dart';
import '../controller/login_page_controller.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: AppController().changeLanguage,
              icon: Icon(Icons.language),
            ),
          ],
          title: Text(LocaleKeys.login_login.tr)),

      body: SingleChildScrollView(
        child: Breakpoint.either(
          context,
          breakpoint: Breakpoint.phone,
          before: () => _body(context),
          after: () => CustomFlexibleWidget(widget: _body(context)),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: Utils.smallPadding,
      child: Column(
        children: [
          _usernameAndPassword(context),
          Utils.giantVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleKeys.login_remember_me.tr),
              Obx(
                () => Checkbox(
                  value: controller.isRememberUser.value,
                  onChanged: controller.isLoading.value
                      ? null
                      : (value) {
                          controller.isRememberUser.value = value!;
                        },
                ),
              ),
            ],
          ),
          Utils.giantVerticalSpacer,
          _enterAndRegisterButton(context),
        ],
      ),
    );
  }

  Widget _usernameAndPassword(BuildContext context) => Form(
    key: controller.formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.login_username.tr),
        Utils.smallVerticalSpacer,
        TextFormField(
          readOnly: controller.isLoading.value,
          validator: controller.validateUserName,
          controller: controller.usernameController,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        Utils.largeVerticalSpacer,
        Text(LocaleKeys.login_password.tr),
        Utils.smallVerticalSpacer,
        Obx(
          () => TextFormField(
            readOnly: controller.isLoading.value,
            validator: controller.validatePassword,
            obscureText: controller.isObscure.value,
            controller: controller.passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: controller.isObscure.value
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () {
                  controller.isObscure.toggle();
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _enterAndRegisterButton(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyButton(
            isLoading: controller.isLoading.value,
            title: LocaleKeys.login_enter.tr,
            onPressed: () => controller.authenticate(),
          ),
          TextButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.goToRegisterPage(),
            child: Text(LocaleKeys.login_register.tr),
          ),
        ],
      ),
    );
  }
}
