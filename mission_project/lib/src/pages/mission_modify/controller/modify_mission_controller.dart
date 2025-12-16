import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../shared/enums/mission_status_enum.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/widgets/toast_widget.dart';
import '../model/dto/mission_dto.dart';
import '../model/dto/mission_tag_dto.dart';
import '../repository/modify_mission_repository.dart';
import '../views/widgets/tag_dialog.dart';

abstract class ModifyMissionController extends GetxController {
  String get title;

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();

  final TextEditingController tagEditingController = TextEditingController();

  DateTime? selectedDate;

  RxBool isLoading = false.obs;
  RxBool isRetry = false.obs;
  RxList<MissionTagViewModel> tagList = <MissionTagViewModel>[].obs;
  RxList<MissionTagViewModel> tempSelectedTag = <MissionTagViewModel>[].obs;
  RxList<MissionTagViewModel> selectedTag = <MissionTagViewModel>[].obs;
  final ModifyMissionRepository repository = ModifyMissionRepository();


  void initData() async {}

  void toggleTag(MissionTagViewModel tag) {
    if (tempSelectedTag.any((t) => t.id == tag.id)) {
      tempSelectedTag.removeWhere((t) => t.id == tag.id);
    } else {
      tempSelectedTag.add(tag);
    }
  }

  Future<void> onSubmit() async {}

  Future<void> addTag(BuildContext context) async {
    isLoading(true);
    if (AppController().currentUser == null) {
      ToastWidget.show(context, 'error in user in app controller');
      return;
    }
    final resultOrException = await repository.addTag(
      MissionTagDto(
        title: tagEditingController.text,
        createdBy: AppController().currentUser!.id,
      ),
    );
    resultOrException.fold(
      ifLeft: (err) {
        ToastWidget.show(
          context,
          LocaleKeys.shared_server_communication_error.tr,
        );
        isLoading(false);
      },
      ifRight: (data) {
        tagList.add(data);
        isLoading(false);
        tagEditingController.clear();
      },
    );
  }

  Future<void> getTagsByUserId() async {
    tagList.clear();
    isLoading(true);
    isRetry(false);
    final int? userId = AppController().currentUser?.id;
    if (userId == null) {
      return;
    }
    final resultOrException = await repository.getTag(userId);
    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('title', LocaleKeys.shared_server_communication_error.tr);
        isRetry(true);
        isLoading(false);
      },
      ifRight: (data) {
        tagList.addAll(data);
        isLoading(false);
      },
    );
  }

  MissionDto dto() {
    selectedDate = DateTime.parse(deadlineController.text);

    return MissionDto(
      title: titleController.text,
      description: descriptionController.text,
      price: double.parse(priceController.text),
      deadLine: selectedDate!,
      tags: selectedTag.map((e) => e.id).toList(),
      status: MissionStatusEnum.free,
      createdBy: AppController().currentUser!.id,
    );
  }

  void goToTagDialog() async {
    tempSelectedTag
      ..clear()
      ..addAll(selectedTag);

    Get.dialog(TagDialog());
    await getTagsByUserId();
  }

  void onDialogSubmitButton() {
    Get.back();
    selectedTag
      ..clear()
      ..addAll(tempSelectedTag);

    tempSelectedTag.clear();
  }

  void onCloseDialogButton() {
    Get.back();
    tagEditingController.clear();
    tempSelectedTag.clear();
  }

  bool isTagSelected(MissionTagViewModel tag) {
    int index = tempSelectedTag.indexWhere((e) => e.id == tag.id);
    if (index != -1) {
      return true;
    }
    return false;
  }
}
