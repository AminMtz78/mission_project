import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../shared/enums/breakpoint.dart';
import '../../shared/enums/mission_status_enum.dart';
import '../../shared/widgets/custom_flexible_widget.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/retry_widget.dart';
import '../controller/hunter_mission_detail_controller.dart';
import 'widgets/mission_details_card.dart';

class HunterMissionDetailPage extends GetView<HunterMissionDetailController> {
  const HunterMissionDetailPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(LocaleKeys.mission_mission_details.tr)),
    body: Obx(
      () => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : controller.isRetry.value
          ? RetryWidget(
              isRetry: controller.isRetry.value,
              onRetry: controller.getMissionById,
            )
          : _body(context),
    ),
  );

  Widget _body(BuildContext context) => Padding(
    padding: Utils.mediumPadding,
    child: SingleChildScrollView(
      child: Column(
        children: [
          MissionDetailsCard(
            item: controller.model!,
            tags: controller.tagList,
            isInProgressWithLoggedInUser: controller
                .isInProgressWithLoggedInUser(controller.model!),
          ),
          Utils.mediumVerticalSpacer,
          if (controller.isInProgressWithLoggedInUser(controller.model!) &&
              controller.model!.status == MissionStatusEnum.inProgress)
            Breakpoint.either(
              context,
              breakpoint: Breakpoint.phone,
              before: () => Column(
                children: [
                  _submitCompletionButton(),
                  Utils.mediumVerticalSpacer,
                  _submitFailedButton(),
                ],
              ),
              after: () => Row(
                children: [
                  _submitCompletionButton(),
                  Utils.smallHorizontalSpacer,
                  _submitFailedButton(),
                ],
              ),
            ),
          if (controller.model!.status == MissionStatusEnum.free)
            _offerWidgets(context),
        ],
      ),
    ),
  );

  MyButton _submitFailedButton() {
    return MyButton(
      isLoading: controller.isFailedButtonLoading.value,
      onPressed: controller.isDoneButtonLoading.value
          ? null
          : controller.submitMissionFailure,
      title: LocaleKeys.mission_submitMissionFailure.tr,
    );
  }

  MyButton _submitCompletionButton() {
    return MyButton(
      isLoading: controller.isDoneButtonLoading.value,
      onPressed: controller.isFailedButtonLoading.value
          ? null
          : controller.submitMissionCompletion,
      title: LocaleKeys.mission_submitMissionCompletion.tr,
    );
  }

  Obx _offerWidgets(BuildContext context) => Obx(() {
    if (!controller.isOffering.value) {
      return CustomFlexibleWidget(
        widget: SizedBox(
          width: double.infinity,
          child: MyButton(
            isLoading: false,
            onPressed: controller.startOffer,
            title: LocaleKeys.mission_request_for_mission.tr,
          ),
        ),
      );
    }
    return Breakpoint.either(
      context,
      breakpoint: Breakpoint.phone,
      before: _priceAndButtons,
      after: () => CustomFlexibleWidget(widget: _priceAndButtons()),
    );
  });

  Widget _priceAndButtons() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        inputFormatters: [Utils.doubleInputFormatter],
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: LocaleKeys.mission_offer_price.tr,
          prefixIcon: Icon(Icons.attach_money),
        ),
      ),
      Utils.mediumVerticalSpacer,
      Row(
        children: [
          MyButton(
            isLoading: controller.isButtonLoading.value,
            onPressed: controller.checkMissionRequestUniqueness,
            title: LocaleKeys.shared_submit.tr,
          ),
          Utils.mediumHorizontalSpacer,
          TextButton(
            onPressed: controller.isButtonLoading.value
                ? null
                : controller.cancelOffer,
            child: Text(LocaleKeys.shared_cancel.tr),
          ),
        ],
      ),
    ],
  );
}
