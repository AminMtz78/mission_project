import 'package:get/get.dart';
import 'package:mission_project/mission_project.dart';

class SplashPageController extends GetxController {
  final double logoSize = 200;

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(Duration(seconds: 5));
    checkLogin();
  }

  Future<void> checkLogin() async {
    if (StorageHandler.rememberedUserId == 0) {
      Get.offNamed(RoutePath.loginPage);
    } else {
      print('user not saved');
      //TODO : go to admin home page or hunter home page if remember user is active
    }
  }
}
