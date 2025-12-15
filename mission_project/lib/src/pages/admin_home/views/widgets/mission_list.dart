import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/src/pages/shared/enums/breakpoint.dart';

import '../../../shared/widgets/custom_grid_view.dart';
import '../../controller/admin_home_controller.dart';
import 'mission_item.dart';

class MissionList extends GetView<AdminHomeController> {
  const MissionList({super.key});

  @override
  Widget build(BuildContext context) {
    final double pageWidth = MediaQuery.sizeOf(context).width;
    return CustomGridView(
      itemBuilder: (context, mission, item) => MissionItem(item: mission),
      items: controller.missions,
      crossAxisCount: pageWidth < Breakpoint.phone.maxWidth ? 2 : 3,
    );
  }
}
