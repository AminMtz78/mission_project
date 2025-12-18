import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/hunter_mission_detail_controller.dart';

class HunterMissionDetailPage extends GetView<HunterMissionDetailController> {
  const HunterMissionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(controller.title)));
  }
}
