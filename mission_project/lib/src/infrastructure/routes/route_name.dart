import 'route_path.dart';

class RouteName {
  static const String splashPage = RoutePath.splashPage;
  static const String loginPage = RoutePath.loginPage;

  static const String registerPage =
      '${RoutePath.loginPage}${RoutePath.registerPage}';

  static const String adminHomePage = RoutePath.adminHomePage;
  static const String hunterMissionList = RoutePath.hunterMissionList;

  static const String addMission =
      RoutePath.adminHomePage + RoutePath.addMission;

  static const String editMission =
      RoutePath.adminHomePage + RoutePath.editMission;
}
