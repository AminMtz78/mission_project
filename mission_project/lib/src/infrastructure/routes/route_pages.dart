import 'package:get/get.dart';
import 'package:mission_project/src/pages/splash/common/splash_page_binding.dart';
import 'package:mission_project/src/pages/splash/views/splash_page.dart';

import '../../pages/login/common/login_page_binding.dart';
import '../../pages/login/views/login_page.dart';
import '../../pages/register/common/register_page_binding.dart';
import '../../pages/register/views/register_page.dart';
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
  ];
}
