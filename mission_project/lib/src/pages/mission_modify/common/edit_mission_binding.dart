import 'package:get/get.dart';

import '../controller/edit_mission_controller.dart';
import '../controller/modify_mission_controller.dart';


class EditMissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModifyMissionController>(
      () => EditMissionController(
        missionId: int.tryParse(Get.parameters['id']!) ?? 0, // missionId: int.tryParse(Get.parameters['id']!) ?? 0,
      ),
    );
  }
}
