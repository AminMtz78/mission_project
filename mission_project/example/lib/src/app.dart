import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/mission_project.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepPurpleAccent.withValues(alpha: 0.3),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    initialRoute: RoutePath.splashPage,
    getPages: RoutePages.pages,
    locale: StorageHandler().getLocale() == 'fa'
        ? const Locale('en', 'US')
        : const Locale('fa', 'IR'),
    translationsKeys: LocalizationService.keys,
  );
}
