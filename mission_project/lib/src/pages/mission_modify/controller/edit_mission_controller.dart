import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import 'modify_mission_controller.dart';

class EditMissionController extends ModifyMissionController {
  EditMissionController({required this.missionId});

  final int missionId;

  @override
  RxString get title => LocaleKeys.mission_edit_mission.tr.obs;

  MissionViewModel? currentMission;

  @override
  void onInit() async {
    initData();
    super.onInit();
  }

  @override
  void initData() async {
    await getMissionById();
    fetchData();
  }

  void fetchData() {
    titleController.text = currentMission?.title ?? '';
    descriptionController.text = currentMission?.description ?? '';
    deadlineController.text = Utils.formatDate(currentMission!.deadLine);
    priceController.text = currentMission?.price.toString() ?? '';
  }

  @override
  Future<void> onSubmit() async {
    if (selectedTag.isEmpty) {
      Get.snackbar('', LocaleKeys.mission_chose_tag_error.tr);
      return;
    }

    if (formKey.currentState!.validate()) {
      isSubmitLoading(true);
      final resultOrException = await repository.editMission(
        id: missionId,
        mission: dto(),
      );
      resultOrException.fold(
        ifLeft: (err) {
          Get.snackbar(
            'title',
            LocaleKeys.shared_server_communication_error.tr,
          );
          isSubmitLoading(false);
        },
        ifRight: (data) {
          isSubmitLoading(false);
          Get.back(result: true);
        },
      );
    }
  }

  Future<void> getMissionById() async {
    isLoading(true);
    isRetry(false);
    final resultOrException = await repository.getMissionById(missionId);
    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('title', LocaleKeys.shared_server_communication_error.tr);
        isRetry(true);
        isLoading(false);
      },
      ifRight: (data) async {
        currentMission = data;
        await getTagsByIds();
      },
    );
  }

  Future<void> getTagsByIds() async {
    selectedTag.clear();
    final resultOrException = await repository.getTagsByIds(
      currentMission!.tags,
    );
    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
        isRetry(true);
        isLoading(false);
      },
      ifRight: (data) {
        selectedTag.addAll(data);
        isLoading(false);
      },
    );
  }
}
