import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/hunter_history_controller.dart';

class HunterHistoryPage extends GetView<HunterHistoryController> {
  const HunterHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(controller.appBarTitle)));
  }
}
