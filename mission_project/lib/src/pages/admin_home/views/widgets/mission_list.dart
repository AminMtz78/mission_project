import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/admin_home_controller.dart';
import 'mission_item.dart';

class MissionList extends GetView<AdminHomeController> {
  const MissionList({super.key});

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
      onRefresh: controller.getMissions,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          mainAxisExtent: 250,
        ),
        itemBuilder: (context, index) => MissionItem(
          item: controller.missions[index],
          onTap: () =>
              controller.goToAdminRequestPage(controller.missions[index].id),
          onDelete: () =>
              controller.deleteMission(controller.missions[index].id),
          tags: controller.fetchTagsByMission(controller.missions[index].tags),
          onEdit: () =>
              controller.goToEditMissionPage(controller.missions[index].id),

        ),
        itemCount: controller.missions.length,
      ),
    );
  }
}
