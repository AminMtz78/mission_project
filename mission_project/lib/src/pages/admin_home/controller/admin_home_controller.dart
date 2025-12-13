import 'package:get/get.dart';

import '../../../infrastructure/routes/route_path.dart';

class AdminHomeController extends GetxController {
  final String title = 'admin mission app bar';

  Future<void> goToAddMissionPage() async {
    final result = await Get.toNamed(RoutePath.addMission);
  }
}
