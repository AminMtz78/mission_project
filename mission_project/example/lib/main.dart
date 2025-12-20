import 'package:flutter/material.dart';
import 'package:mission_project/mission_project.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHandler().init();
  runApp(const MyApp());
}
