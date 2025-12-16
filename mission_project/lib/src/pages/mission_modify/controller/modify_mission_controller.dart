import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/mission_project.dart';
import 'package:mission_project/src/pages/shared/enums/mission_status_enum.dart';

import '../../../../generated/locales.g.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/widgets/toast_widget.dart';
import '../model/dto/mission_dto.dart';
import '../model/dto/mission_tag_dto.dart';
import '../repository/modify_mission_repository.dart';

abstract class ModifyMissionController extends GetxController {
  String get title;

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> tagFormKey = GlobalKey();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();

  final TextEditingController tagEditingController = TextEditingController();

  DateTime? selectedDate;

  RxBool isLoading = false.obs;
  RxBool isRetry = false.obs;
  RxList<MissionTagViewModel> tagList = <MissionTagViewModel>[].obs;
  RxList<MissionTagViewModel> selectedTag = <MissionTagViewModel>[].obs;
  final ModifyMissionRepository repository = ModifyMissionRepository();

  void toggleTag(MissionTagViewModel tag) {
    if (selectedTag.contains(tag)) {
      selectedTag.remove(tag);
    } else {
      selectedTag.add(tag);
    }
  }

  Future<void> onSubmit(BuildContext context) async {}

  Future<void> addTag(BuildContext context) async {
    if (tagFormKey.currentState!.validate()) {
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
  }

  Future<void> getTags(BuildContext context) async {
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
        ToastWidget.show(
          context,
          LocaleKeys.shared_server_communication_error.tr,
        );
        isRetry(true);
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
}
