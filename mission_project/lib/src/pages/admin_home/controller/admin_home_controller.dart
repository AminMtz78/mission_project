import 'package:get/get.dart';

import '../../../infrastructure/routes/route_name.dart';

class AdminHomeController extends GetxController {
  final String title = 'admin mission app bar';

  Future<void> goToAddMissionPage() async {
    final result = await Get.toNamed(RouteName.addMission);
    if (result != null) {}
  }
}
