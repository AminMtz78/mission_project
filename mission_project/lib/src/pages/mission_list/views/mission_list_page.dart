import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/mission_list_controller.dart';

class MissionListPage extends GetView<MissionListController> {
  const MissionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title)),
      body: Placeholder(),
    );
  }
}
