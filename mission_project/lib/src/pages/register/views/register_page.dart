import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/generated/locales.g.dart';

import '../../../infrastructure/utils/utils.dart';
import '../controller/register_page_controller.dart';

class RegisterPage extends GetView<RegisterPageController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title)),
      body: usernameAndPassWordWidget(context),
    );
  }

  Widget usernameAndPassWordWidget(BuildContext context) {
    return Column(
      children: [
        Form(
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
              Utils.giantVerticalSpacer,
              Text(LocaleKeys.login_password.tr),
              Utils.smallVerticalSpacer,
              TextField(
                controller: controller.repeatPasswordController,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Utils.giantVerticalSpacer,
              registerButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget registerButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.addUser(context),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Utils.tinySpace),
        ),
      ),
      child: Text(LocaleKeys.login_register.tr),
    );
  }
}
