import 'package:get/get.dart';

import '../controller/hunter_history_controller.dart';

class HunterHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HunterHistoryController(
        hunterId: int.tryParse(Get.parameters['id'] ?? '') ?? 0,
      ),
    );
  }
}
