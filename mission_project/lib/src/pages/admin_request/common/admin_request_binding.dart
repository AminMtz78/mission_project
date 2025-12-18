import 'package:get/get.dart';

import '../controller/admin_request_controller.dart';

class AdminRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AdminRequestController(
        missionId: int.tryParse(Get.parameters['missionId'] ?? '') ?? 0,
      ),
    );
  }
}
