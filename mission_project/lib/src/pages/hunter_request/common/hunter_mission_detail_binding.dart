import 'package:get/get.dart';

import '../controller/hunter_mission_detail_controller.dart';

class HunterMissionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HunterMissionDetailController(
        missionId: int.tryParse(Get.parameters['missionId'] ?? '') ?? 0,
      ),
    );
  }
}
