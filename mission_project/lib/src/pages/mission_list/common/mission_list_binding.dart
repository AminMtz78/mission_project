import 'package:get/get.dart';

import '../controller/mission_list_controller.dart';


class MissionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MissionListController());
  }
}
