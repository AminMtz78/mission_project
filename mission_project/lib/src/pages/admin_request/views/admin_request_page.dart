import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../shared/enums/mission_status_enum.dart';
import '../../shared/widgets/empty_widget.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/retry_widget.dart';
import '../controller/admin_request_controller.dart';
import 'widgets/mission_header_card.dart';
import 'widgets/request_list.dart';

class AdminRequestPage extends GetView<AdminRequestController> {
  const AdminRequestPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(LocaleKeys.mission_requests.tr)),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          MissionHeaderCard(item: controller.model!, tags: controller.tagList),
          Utils.mediumVerticalSpacer,
          if (controller.model!.status == MissionStatusEnum.free)
            Column(
              children: [
                Text(
                  LocaleKeys.mission_requests.tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Utils.mediumVerticalSpacer,
              ],
            ),
          if (controller.model!.status == MissionStatusEnum.pendingDoneApproval)
            _doneMissionButton(),
          if (controller.model!.status == MissionStatusEnum.free) _requests(),
        ],
      ),
    ),
  );

  Widget _doneMissionButton() {
    return MyButton(
      color: Colors.greenAccent.shade400,
      isLoading: controller.isButtonLoading.value,
      onPressed: controller.submitMissionCompletion,
      title: LocaleKeys.mission_submitMissionCompletion.tr,
    );
  }

  Widget _requests() =>
      Obx(() => controller.requests.isNotEmpty ? RequestList() : EmptyWidget());
}
