import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/src/pages/shared/widgets/retry_widget.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/enums/breakpoint.dart';

import '../../../shared/widgets/custom_flexible_widget.dart';
import '../../../shared/widgets/empty_widget.dart';
import '../../controller/modify_mission_controller.dart';
import 'tag_item.dart';

class TagDialog extends GetView<ModifyMissionController> {
  TagDialog({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : controller.isRetry.value
          ? RetryWidget(
              isRetry: controller.isRetry.value,
              onRetry: controller.getTagsByUserId,
            )
          : Breakpoint.either(
              context,
              breakpoint: Breakpoint.phone,
              before: () => _body(context),
              after: () => CustomFlexibleWidget(widget: _body(context)),
            ),
    );
  }

  Widget _body(BuildContext context) => Material(
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Utils.smallSpace)),
      ),
      child: Padding(
        padding: Utils.mediumPadding,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _header(),
                Utils.largeVerticalSpacer,
                _tagTextField(context),
                Utils.mediumVerticalSpacer,
                _tags(),
                Utils.mediumVerticalSpacer,
                ElevatedButton(
                  onPressed: () => controller.onDialogSubmitButton(),
                  child: Text(LocaleKeys.shared_submit.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Obx _tags() {
    return Obx(
      () => controller.tagList.isNotEmpty
          ? Wrap(
                  children: controller.tagList
                      .map(
                        (e) => Obx(
                          () => TagItem(
                            item: e,
                            isSelected: controller.isTagSelected(e),
                            onTap: () => controller.toggleTag(e),
                          ),
                        ),
                      )
                      .toList(),
                )
          : EmptyWidget(),
    );
  }

  Widget _tagTextField(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? CircularProgressIndicator()
          : TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: Utils.validateEmpty,
              controller: controller.tagEditingController,
              decoration: InputDecoration(
                hintText: LocaleKeys.shared_title.tr,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.addTag(context);
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ),
    );
  }

  Column _header() {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: controller.onCloseDialogButton,
              icon: Icon(Icons.close),
            ),
          ],
        ),
        Text(LocaleKeys.shared_tag.tr, style: TextStyle(fontSize: 50)),
      ],
    );
  }
}
