import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../../controller/admin_request_controller.dart';
import 'request_item.dart';

class RequestList extends GetView<AdminRequestController> {
  const RequestList({super.key});

  @override
  Widget build(BuildContext context) {
    final double pageWidth = MediaQuery.sizeOf(context).width;

    int crossAxisCount = switch (pageWidth) {
      < 600 => 1,
      < 960 => 2,
      < 1320 => 3,
      _ => 4,
    };

    return RefreshIndicator(
      onRefresh: controller.getRequestByMissionId,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: Utils.smallSpace,
          mainAxisSpacing: Utils.smallSpace,
          mainAxisExtent: 165,
        ),
        itemBuilder: (_, index) => RequestItem(
          isExpired: controller.isMissionExpired(),
          onAccept: () => controller.acceptUserRequestForMission(
            controller.requests[index],
          ),
          onUserProfile: () => controller.goToHunterHistoryPage(
            controller.requests[index].userId,
          ),
          item: controller.requests[index],
          user: controller.fetchUserToRequest(controller.requests[index]),
        ),

        itemCount: controller.requests.length,
      ),
    );
  }
}
