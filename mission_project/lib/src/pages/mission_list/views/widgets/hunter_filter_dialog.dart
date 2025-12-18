import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/enums/date_enum.dart';
import '../../controller/hunter_mission_list_controller.dart';
import 'tag_item.dart';

class HunterFilterDialog extends GetView<HunterMissionListController> {
  const HunterFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: Utils.mediumPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(LocaleKeys.shared_price_range.tr),
            Column(
              children: [
                Obx(
                  () => RangeSlider(
                    min: controller.minPrice,
                    max: controller.maxPrice,
                    divisions: 20,
                    values: RangeValues(
                      controller.tempMinPrice.value,
                      controller.tempMaxPrice.value,
                    ),
                    labels: RangeLabels(
                      controller.tempMinPrice.value.toStringAsFixed(0),
                      controller.tempMaxPrice.value.toStringAsFixed(0),
                    ),
                    onChanged: (values) {
                      controller.tempMinPrice.value = values.start;
                      controller.tempMaxPrice.value = values.end;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: Utils.mediumSpace,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.minPrice.toString()),
                      Text(controller.maxPrice.toString()),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Obx(
              () => CheckboxListTile(
                title: Text('Expired'),
                value: controller.tempIsExpired.value,
                onChanged: (v) => controller.tempIsExpired.value = v!,
              ),
            ),
            Obx(
              () => CheckboxListTile(
                title: Text('In Progress'),
                value: controller.tempIsInProgress.value,
                onChanged: (v) => controller.tempIsInProgress.value = v!,
              ),
            ),
            Obx(
              () => CheckboxListTile(
                title: Text('Done'),
                value: controller.tempIsDone.value,
                onChanged: (v) => controller.tempIsDone.value = v!,
              ),
            ),
            Divider(),
            Obx(
              () => RadioGroup<DateEnum>(
                groupValue: controller.tempSortDate.value,
                onChanged: (value) {
                  controller.tempSortDate.value = value;
                },
                child: Column(
                  children: [
                    RadioListTile<DateEnum>(
                      value: DateEnum.newest,
                      title: Text('newest'),
                    ),
                    Utils.smallVerticalSpacer,
                    RadioListTile<DateEnum>(
                      value: DateEnum.oldest,
                      title: Text('oldest'),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Column(
              children: [
                Text(LocaleKeys.shared_tag.tr),
                Utils.smallVerticalSpacer,
                Obx(
                  () => Wrap(
                    children: [
                      ...controller.allUsedTags.map(
                        (e) => Obx(
                          () => TagItem(
                            item: e,
                            selected: controller.isTagSelected(e).value,
                            onTap: () => controller.onTagSelected(e),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Utils.mediumVerticalSpacer,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _submitButton(),
                Utils.smallHorizontalSpacer,
                _deleteFilterButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _submitButton() {
    return ElevatedButton(
      onPressed: () {
        controller.applyFilters();
      },
      child: Text(LocaleKeys.shared_submit.tr),
    );
  }

  ElevatedButton _deleteFilterButton() {
    return ElevatedButton(
      onPressed: () {
        controller.deleteFilter();
      },
      child: Text(LocaleKeys.shared_delete.tr),
    );
  }
}
