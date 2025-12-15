import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../shared/enums/breakpoint.dart';
import '../../shared/widgets/custom_flexible_widget.dart';
import '../../shared/widgets/empty_widget.dart';
import '../../shared/widgets/my_button.dart';
import '../controller/modify_mission_controller.dart';
import 'widgets/tag_dialog.dart';
import 'widgets/tag_item.dart';

class ModifyMissionPage extends GetView<ModifyMissionController> {
  const ModifyMissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title)),
      body: Breakpoint.either(
        context,
        breakpoint: Breakpoint.phone,
        before: () => _body(context),
        after: () => CustomFlexibleWidget(widget: _body(context)),
      ),
    );
  }

  SingleChildScrollView _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Utils.smallPadding,
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              Utils.giantVerticalSpacer,
              _description(),
              Utils.giantVerticalSpacer,
              _price(),
              Utils.giantVerticalSpacer,
              _deadline(),
              Utils.giantVerticalSpacer,
              _tagBox(),
              Utils.giantVerticalSpacer,
              _registrationButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registrationButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyButton(
          isLoading: controller.isLoading.value,
          onPressed: () => controller.addMission(context),
          title: LocaleKeys.shared_registration.tr,
        ),
      ],
    );
  }

  Column _deadline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.shared_deadLine.tr),
        Utils.smallVerticalSpacer,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: Utils.validateEmpty,
          inputFormatters: [Utils.dateInputFormatter],
          controller: controller.deadlineController,
          decoration: _textFieldDecoration(hintText: 'yyyy-MM-dd'),
        ),
      ],
    );
  }

  Column _price() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.shared_price.tr),
        Utils.smallVerticalSpacer,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [Utils.doubleInputFormatter],
          validator: Utils.validateEmpty,
          controller: controller.priceController,
          decoration: _textFieldDecoration(),
        ),
      ],
    );
  }

  Column _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.shared_description.tr),
        Utils.smallVerticalSpacer,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: Utils.validateEmpty,
          controller: controller.descriptionController,
          decoration: _textFieldDecoration(),
        ),
      ],
    );
  }

  Column _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.shared_title.tr),
        Utils.smallVerticalSpacer,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: Utils.validateEmpty,
          controller: controller.titleController,
          decoration: _textFieldDecoration(),
        ),
      ],
    );
  }

  Widget _tagBox() => Container(
    width: double.infinity,
    padding: Utils.mediumPadding,
    decoration: BoxDecoration(
      color: Colors.grey.withValues(alpha: 0.2),
      borderRadius: BorderRadius.all(Radius.circular(Utils.smallSpace)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyButton(
          isLoading: false,
          onPressed: () {
            Get.dialog(TagDialog());
          },
          title: 'choose tag',
        ),
        Utils.mediumVerticalSpacer,
        Obx(
          () => controller.selectedTag.isNotEmpty
              ? Wrap(
                  children: [
                    ...controller.selectedTag.map(
                      (e) => TagItem(item: e, isSelected: false, onTap: null),
                    ),
                  ],
                )
              : EmptyWidget(),
        ),
      ],
    ),
  );

  InputDecoration _textFieldDecoration({String? hintText}) =>
      InputDecoration(border: OutlineInputBorder(), hintText: hintText);
}
