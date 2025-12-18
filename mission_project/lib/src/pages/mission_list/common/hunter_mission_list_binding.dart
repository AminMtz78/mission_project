import 'package:get/get.dart';

import '../controller/hunter_mission_list_controller.dart';


class HunterMissionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HunterMissionListController());
  }
}
