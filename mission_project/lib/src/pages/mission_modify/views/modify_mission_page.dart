import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../shared/widgets/my_button.dart';
import '../controller/modify_mission_controller.dart';
import 'widgets/tag_dialog.dart';

class ModifyMissionPage extends GetView<ModifyMissionController> {
  const ModifyMissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: Utils.smallPadding,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.shared_title.tr),
                Utils.smallVerticalSpacer,
                TextFormField(decoration: _textFieldDecoration()),
                Utils.giantVerticalSpacer,
                Text(LocaleKeys.shared_description.tr),
                Utils.smallVerticalSpacer,
                TextFormField(decoration: _textFieldDecoration()),
                Utils.giantVerticalSpacer,
                Text(LocaleKeys.shared_price.tr),
                Utils.smallVerticalSpacer,
                TextFormField(decoration: _textFieldDecoration()),
                Utils.giantVerticalSpacer,
                Text(LocaleKeys.shared_deadLine.tr),
                Utils.smallVerticalSpacer,
                TextFormField(decoration: _textFieldDecoration()),
                Utils.giantVerticalSpacer,
                _tagBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tagBox() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(Utils.smallSpace)),
    ),
    child: Column(
      children: [
        MyButton(
          isLoading: false,
          onPressed: () {
            Get.dialog(TagDialog());
          },
          title: 'choose tag',
        ),
        Wrap(children: []),
      ],
    ),
  );

  InputDecoration _textFieldDecoration() =>
      InputDecoration(border: OutlineInputBorder());
}
