import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/src/components/grid_date_picker.dart';
import 'package:mission_project/src/pages/shared/enums/breakpoint.dart';
import 'package:mission_project/src/pages/shared/widgets/my_button.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../controller/login_page_controller.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title)),

      body: SingleChildScrollView(
        child: Breakpoint.either(
          context,
          breakpoint: Breakpoint.phone,
          before: () => _body(context),
          after: () => _forLargeSc(context),
        ),
      ),
    );
  }

  Widget _forLargeSc(BuildContext context) => Row(
    children: [
      Flexible(fit: FlexFit.tight, child: SizedBox()),
      Flexible(fit: FlexFit.tight, child: _body(context)),
      Flexible(fit: FlexFit.tight, child: SizedBox()),
    ],
  );

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
                          controller.isRememberUser.value = value ?? false;
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
            onPressed: () => controller.authenticate(context),
          ),
          TextButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.goToRegisterPage(context),
            child: Text(LocaleKeys.login_register.tr),
          ),
        ],
      ),
    );
  }
}
