import 'route_path.dart';

class RouteName {
  static const String splashPage = RoutePath.splashPage;
  static const String loginPage = RoutePath.loginPage;
  static const String registerPage =
      '${RoutePath.loginPage}${RoutePath.registerPage}';
}
