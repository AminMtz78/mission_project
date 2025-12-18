import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../shared/enums/mission_status_enum.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
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
  RxString searchText = ''.obs;

  Timer? _debounce;
  final FocusNode focusNode = FocusNode();

  RxBool isLoading = false.obs;
  RxBool isSubmitLoading = false.obs;
  RxBool isRetry = false.obs;
  final RxBool showPopup = false.obs;
  RxList<MissionTagViewModel> tagList = <MissionTagViewModel>[].obs;
  RxList<MissionTagViewModel> tempSelectedTag = <MissionTagViewModel>[].obs;
  RxList<MissionTagViewModel> selectedTag = <MissionTagViewModel>[].obs;

  final LayerLink layerLink = LayerLink();

  final ModifyMissionRepository repository = ModifyMissionRepository();

  void initData() async {}

  Future<void> onSubmit() async {}

  Future<void> addTag() async {
    isLoading(true);
    if (AppController().currentUser == null) {
      return;
    }
    final resultOrException = await repository.addTag(
      MissionTagDto(
        title: tagEditingController.text.trim(),
        createdBy: AppController().currentUser!.id,
      ),
    );
    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
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
    final resultOrException = await repository.getTag(
      id: userId,
      query: tagEditingController.text.trim(),
    );
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
    tagList.clear();
    tempSelectedTag
      ..clear()
      ..addAll(selectedTag);

    Get.dialog(TagDialog());
    // await getTagsByUserId();
  }

  void onDialogSubmitButton() {
    Get.back();
    selectedTag
      ..clear()
      ..addAll(tempSelectedTag);

    tempSelectedTag.clear();
    tagEditingController.clear();
  }

  void onCloseDialogButton() {
    Get.back();
    tagEditingController.clear();
    tempSelectedTag.clear();
  }

  void onTextChanged(String value) async {
    if (tagEditingController.text.trim().isNotEmpty) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () async {
        await getTagsByUserId();
        showPopup.value = tagList.isNotEmpty;
      });
    }
  }

  void selectTag(MissionTagViewModel tag) {
    if (!tempSelectedTag.any((e) => e.id == tag.id)) {
      tempSelectedTag.add(tag);
    }
    tagList.clear();
    showPopup.value = false;
    tagEditingController.clear();
  }

  @override
  void onClose() {
    tagEditingController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();

    super.onClose();
  }
}
