import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../shared/widgets/toast_widget.dart';
import 'modify_mission_controller.dart';

class AddMissionController extends ModifyMissionController {
  @override
  String get title => 'add mission app bar';


  @override
  Future<void> onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading(true);
      if (AppController().currentUser == null) {
        ToastWidget.show(context, 'error in user in app controller');
        return;
      }
      final resultOrException = await repository.addMission(dto());
      resultOrException.fold(
        ifLeft: (err) {
          ToastWidget.show(
            context,
            LocaleKeys.shared_server_communication_error.tr,
          );
          isLoading(false);
        },
        ifRight: (data) {
          isLoading(false);
          tagEditingController.clear();
        },
      );
    }
  }
}
