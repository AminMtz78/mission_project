import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/src/pages/splash/controller/splash_page_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: FlutterLogo(size: controller.logoSize));
  }
}
