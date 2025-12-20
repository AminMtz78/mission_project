import 'package:get/get.dart';

import '../../pages/admin_home/common/admin_home_binding.dart';
import '../../pages/admin_home/views/admin_home_page.dart';
import '../../pages/admin_request/common/admin_request_binding.dart';
import '../../pages/admin_request/views/admin_request_page.dart';
import '../../pages/hunter_history/common/hunter_history_binding.dart';
import '../../pages/hunter_history/views/hunter_history_page.dart';
import '../../pages/hunter_mission_detail/common/hunter_mission_detail_binding.dart';
import '../../pages/hunter_mission_detail/views/hunter_mission_detail_page.dart';
import '../../pages/login/common/login_page_binding.dart';
import '../../pages/login/views/login_page.dart';
import '../../pages/mission_list/common/hunter_mission_list_binding.dart';
import '../../pages/mission_list/views/hunter_mission_list_page.dart';
import '../../pages/mission_modify/common/add_mission_binding.dart';
import '../../pages/mission_modify/common/edit_mission_binding.dart';
import '../../pages/mission_modify/views/modify_mission_page.dart';
import '../../pages/register/common/register_page_binding.dart';
import '../../pages/register/views/register_page.dart';
import '../../pages/splash/common/splash_page_binding.dart';
import '../../pages/splash/views/splash_page.dart';
import 'route_path.dart';

class RoutePages {
  static List<GetPage> pages = [
    GetPage(
      name: RoutePath.splashPage,
      page: () => SplashPage(),
      binding: SplashPageBinding(),
    ),

    GetPage(
      name: RoutePath.loginPage,
      page: () => LoginPage(),
      binding: LoginPageBinding(),
      children: [
        GetPage(
          name: RoutePath.registerPage,
          page: () => RegisterPage(),
          binding: RegisterPageBinding(),
        ),
      ],
    ),
    GetPage(
      name: RoutePath.adminHomePage,
      page: () => AdminHomePage(),
      binding: AdminHomeBinding(),
      children: [
        GetPage(
          name: RoutePath.adminRequest,
          page: () => AdminRequestPage(),
          binding: AdminRequestBinding(),
        ),
        GetPage(
          name: RoutePath.addMission,
          page: () => ModifyMissionPage(),
          binding: AddMissionBinding(),
        ),
        GetPage(
          name: RoutePath.editMission,
          page: () => ModifyMissionPage(),
          binding: EditMissionBinding(),
        ),
      ],
    ),
    GetPage(
      name: RoutePath.hunterMissionList,
      page: () => HunterMissionListPage(),
      binding: HunterMissionListBinding(),
      children: [
        GetPage(
          name: RoutePath.hunterMissionDetail,
          page: () => HunterMissionDetailPage(),
          binding: HunterMissionDetailBinding(),
          children: [
            GetPage(
              name: RoutePath.hunterHistory,
              page: () => HunterHistoryPage(),
              binding: HunterHistoryBinding(),
            ),
          ],
        ),
      ],
    ),
  ];
}
