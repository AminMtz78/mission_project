import 'package:get/get.dart';

import '../../../infrastructure/commons/app_controller.dart';
import '../../../infrastructure/commons/storage_handler.dart';
import '../../../infrastructure/routes/route_path.dart';
import '../../shared/enums/user_type_enum.dart';
import '../repository/splash_page_repository.dart';

class SplashPageController extends GetxController {
  final SplashPageRepository _repository = SplashPageRepository();
  final double logoSize = 200;

  @override
  void onReady() {
    super.onReady();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(Duration(seconds: 3));
    final int?  userId = StorageHandler().getUserId();
    print('user id  :::::: $userId');

    if (userId == null) {
      Get.offNamed(RoutePath.loginPage);
      return;
    }

    await getUserById(userId);

    final user = AppController().currentUser;

    if (user == null) {
      Get.snackbar('Error', 'User not found');
      Get.offNamed(RoutePath.loginPage);
      return;
    }

    switch (user.userType) {
      case UserTypeEnum.admin:
        Get.offNamed(RoutePath.adminHomePage);
        break;

      case UserTypeEnum.hunter:
        Get.offNamed(RoutePath.hunterMissionList);
        break;
    }
  }

  Future<void> getUserById(int id) async {
    final result = await _repository.getUser(id);

    result.fold(
      ifLeft: (_) => Get.snackbar('Error', 'Failed to load user'),
      ifRight: (user) => AppController().setUser = user,
    );
  }
}
