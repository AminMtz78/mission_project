import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/modify_mission_repository.dart';

abstract class ModifyMissionController extends GetxController {
  String get title;

  final TextEditingController titleController = TextEditingController();

  RxBool isLoading = false.obs;
  final ModifyMissionRepository repository = ModifyMissionRepository();
}
