import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../shared/enums/breakpoint.dart';
import '../../shared/enums/user_type_enum.dart';
import '../../shared/widgets/my_button.dart';
import '../controller/register_page_controller.dart';

class RegisterPage extends GetView<RegisterPageController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.login_register.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: Utils.largePadding,
          child: Breakpoint.either(
            context,
            breakpoint: Breakpoint.phone,
            before: () => _forSmallSc(context),
            after: () => _forLargeSc(context),
          ),
        ),
      ),
    );
  }

  Widget _forSmallSc(BuildContext context) => _body(context);

  Widget _forLargeSc(BuildContext context) => Row(
    children: [
      Flexible(fit: FlexFit.tight, child: SizedBox()),
      Flexible(fit: FlexFit.tight, child: _body(context)),
      Flexible(fit: FlexFit.tight, child: SizedBox()),
    ],
  );

  Widget _body(BuildContext context) => Column(
    children: [
      _adminAndHunter(),
      Utils.mediumVerticalSpacer,
      _usernameAndPassWordWidget(context),
      Utils.giantVerticalSpacer,
      _registerButton(context),
    ],
  );

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
          Obx(
            () => TextFormField(
              validator: controller.validateUsername,
              controller: controller.usernameController,
              decoration: InputDecoration(border: OutlineInputBorder()),
              autovalidateMode: controller.isSubmitted.value
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
            ),
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
                    controller.isObscure.toggle();
                  },
                  icon: controller.isObscure.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
              autovalidateMode: controller.isSubmitted.value
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
            ),
          ),
          Utils.giantVerticalSpacer,
          Text(LocaleKeys.login_password.tr),
          Utils.smallVerticalSpacer,
          Obx(
            () => TextFormField(
              validator: controller.validatePassword,
              obscureText: controller.isObscureRepeat.value,
              controller: controller.repeatPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isObscureRepeat.toggle();
                  },
                  icon: controller.isObscureRepeat.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
              autovalidateMode: controller.isSubmitted.value
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
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
