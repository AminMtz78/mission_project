import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import 'modify_mission_controller.dart';

class AddMissionController extends ModifyMissionController {
  @override
  String get title => 'add mission app bar';

  @override
  Future<void> onSubmit() async {
    if (formKey.currentState!.validate()) {
      isSubmitLoading(true);
      final resultOrException = await repository.addMission(dto());
      resultOrException.fold(
        ifLeft: (err) {
          Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
          isSubmitLoading(false);
        },
        ifRight: (data) {
          isSubmitLoading(false);
          tagEditingController.clear();
          Get.back(result: true);
        },
      );
    }
  }
}
