import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../controller/login_page_controller.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title)),

      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
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
                onChanged: (value) {
                  controller.isRememberUser.value = value ?? false;
                },
              ),
            ),
          ],
        ),
        Utils.giantVerticalSpacer,
        _enterAndRegisterButton(context),
      ],
    );
  }

  Widget _usernameAndPassword(BuildContext context) => Form(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.login_username.tr),
        Utils.smallVerticalSpacer,
        TextField(
          controller: controller.usernameController,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        Utils.largeVerticalSpacer,
        Text(LocaleKeys.login_password.tr),
        Utils.smallVerticalSpacer,
        TextField(
          controller: controller.passwordController,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    ),
  );

  Widget _enterAndRegisterButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () => controller.authenticate(context),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Utils.tinySpace),
            ),
          ),
          child: Text(LocaleKeys.login_enter.tr),
        ),
        TextButton(
          onPressed: () => controller.goToRegisterPage(context),
          child: Text('${LocaleKeys.login_register.tr} ?'),
        ),
      ],
    );
  }
}
