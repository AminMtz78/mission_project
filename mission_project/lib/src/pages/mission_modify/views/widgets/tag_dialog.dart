import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/enums/breakpoint.dart';
import '../../../shared/widgets/custom_flexible_widget.dart';
import '../../controller/modify_mission_controller.dart';

class TagDialog extends GetView<ModifyMissionController> {
  const TagDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Breakpoint.either(
      context,
      breakpoint: Breakpoint.phone,
      before: _body,
      after: () => CustomFlexibleWidget(widget: _body()),
    );
  }

  Widget _body() => Material(
    child: Padding(
      padding: Utils.mediumPadding,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Text(LocaleKeys.shared_tag.tr, style: TextStyle(fontSize: 50)),
            Utils.largeVerticalSpacer,
            TextFormField(
              controller: controller.titleController,
              decoration: InputDecoration(
                hintText: LocaleKeys.shared_title.tr,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
