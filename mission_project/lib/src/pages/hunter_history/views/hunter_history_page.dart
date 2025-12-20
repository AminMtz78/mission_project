import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/utils/utils.dart';
import '../../shared/widgets/retry_widget.dart';
import '../controller/hunter_history_controller.dart';
import 'widgets/mission_info.dart';

class HunterHistoryPage extends GetView<HunterHistoryController> {
  const HunterHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.appBarTitle)),
      body: _body(),
    );
  }

  Widget _body() => Obx(
    () => controller.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : controller.isRetry.value
        ? RetryWidget(
            onRetry: controller.getMissions,
            isRetry: controller.isRetry.value,
          )
        : SingleChildScrollView(
      child: Column(
              children: controller.missions
                  .map(
                    (e) => Padding(
                      padding: Utils.smallPadding,
                      child: MissionInfo(
                        item: e,
                        tags: controller.fetchTagsByMission(e.tags),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ),
  );
}
