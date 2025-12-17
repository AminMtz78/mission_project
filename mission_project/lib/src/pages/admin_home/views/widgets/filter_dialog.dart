import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/enums/date_enum.dart';
import '../../controller/admin_home_controller.dart';

class FilterDialog extends GetView<AdminHomeController> {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: Utils.mediumPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(LocaleKeys.shared_price_range.tr),
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
            Utils.mediumVerticalSpacer,
            ElevatedButton(
              onPressed: () {
                controller.applyFilters();
              },
              child: Text(LocaleKeys.shared_submit.tr),
            ),
          ],
        ),
      ),
    );
  }
}
