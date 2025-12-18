import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Breakpoint.either(
      context,
      breakpoint: Breakpoint.phone,
      before: () => _body(context),
      after: () => CustomFlexibleWidget(widget: _body(context)),
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
              children: [
                _header(),
                Utils.largeVerticalSpacer,
                _popup(),
                Utils.mediumVerticalSpacer,
                _tags(),
                Utils.mediumVerticalSpacer,
                Divider(),
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
      () => controller.tempSelectedTag.isNotEmpty
          ? Wrap(
              children: controller.tempSelectedTag
                  .map(
                    (e) => TagItem(
                      item: e,
                      onTap: () => controller.tempSelectedTag.remove(e),
                    ),
                  )
                  .toList(),
            )
          : EmptyWidget(),
    );
  }

  Widget _tagTextField() {
    return Obx(
      () => controller.isLoading.value
          ? CircularProgressIndicator()
          : TextFormField(
              autofocus: true,
              // focusNode: controller.focusNode,
              onChanged: controller.onTextChanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.tagEditingController,
              decoration: InputDecoration(
                hintText: LocaleKeys.shared_title.tr,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () =>
                      controller.tagEditingController.text.trim().isEmpty
                      ? null
                      : controller.addTag(),
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

  Widget _popup() => Column(
    children: [
      CompositedTransformTarget(
        link: controller.layerLink,
        child: _tagTextField(),
      ),

      Obx(() {
        if (!controller.showPopup.value) return const SizedBox();

        return CompositedTransformFollower(
          link: controller.layerLink,
          offset: const Offset(0, 56),
          showWhenUnlinked: false,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            child: Wrap(
              children: controller.tagList
                  .map(
                    (e) =>
                        TagItem(item: e, onTap: () => controller.selectTag(e)),
                  )
                  .toList(),
            ),
          ),
        );
      }),
    ],
  );
}
