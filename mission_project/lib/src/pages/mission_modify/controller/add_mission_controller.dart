import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import 'modify_mission_controller.dart';

class AddMissionController extends ModifyMissionController {
  @override
  RxString get title => LocaleKeys.mission_add_mission.tr.obs;

  @override
  Future<void> onSubmit() async {
    if (selectedTag.isEmpty) {
      Get.snackbar('', LocaleKeys.mission_chose_tag_error.tr);
      return;
    }
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
