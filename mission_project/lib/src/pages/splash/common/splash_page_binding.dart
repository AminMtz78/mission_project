import 'package:get/get.dart';
import 'package:mission_project/src/pages/splash/controller/splash_page_controller.dart';

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPageController());
  }
}
