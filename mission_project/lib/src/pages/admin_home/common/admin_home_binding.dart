import 'package:get/get.dart';

import '../controller/admin_home_controller.dart';

class AdminHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> AdminHomeController());
  }
}