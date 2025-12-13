import 'package:get/get.dart';

import '../controller/add_mission_controller.dart';
import '../controller/modify_mission_controller.dart';

class AddMissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModifyMissionController>(() => AddMissionController());
  }
}
