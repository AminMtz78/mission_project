import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../../infrastructure/routes/route_name.dart';
import '../../shared/model/dto/mission_request_dto.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import '../repository/hunter_mission_repository.dart';

class HunterMissionDetailController extends GetxController {
  HunterMissionDetailController({required this.missionId});

  final int missionId;
  var title = 'hunter mission details page';

  final HunterMissionRepository _repository = HunterMissionRepository();
  MissionViewModel? model;
  final List<MissionTagViewModel> tagList = [];

  final priceController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isRetry = false.obs;
  final RxBool isOffering = false.obs;
  final RxBool isButtonLoading = false.obs;

  @override
  void onInit() {
    getMissionById();
    super.onInit();
  }

  Future<void> getMissionById() async {
    isLoading(true);
    isRetry(false);
    final resultOrException = await _repository.getMissionById(missionId);
    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('title', LocaleKeys.shared_server_communication_error.tr);
        isRetry(true);
        isLoading(false);
      },
      ifRight: (data) async {
        model = data;
        await getTagsByIds();
      },
    );
  }

  Future<void> getTagsByIds() async {
    tagList.clear();
    final resultOrException = await _repository.getTagsByIds(model!.tags);
    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
        isRetry(true);
        isLoading(false);
      },
      ifRight: (data) {
        tagList.addAll(data);
        isLoading(false);
      },
    );
  }

  void startOffer() {
    isOffering.value = true;
  }

  void cancelOffer() {
    priceController.clear();
    isOffering.value = false;
  }

  Future<void> checkMissionRequestUniqueness() async {
    isButtonLoading(true);
    final userId = AppController().currentUser?.id;
    if (userId == null) return;
    Map<String, dynamic> query = {'userId': userId, 'missionId': missionId};

    final resultOrException = await _repository.getRequestByMissionIdAndUserId(
      query: query,
    );

    resultOrException.fold(
      ifLeft: (err) {
        isButtonLoading(false);
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
      },
      ifRight: (data) {
        if (data.isNotEmpty) {
          isButtonLoading(false);
          Get.snackbar('', LocaleKeys.mission_request_uniqueness_error.tr);
          return;
        }
        addRequest();
      },
    );
  }

  Future<void> addRequest() async {
    final price = double.tryParse(priceController.text);
    final userId = AppController().currentUser?.id;
    if (price == null || userId == null) return;

    final resultOrException = await _repository.addRequest(
      MissionRequestDto(missionId: missionId, userId: userId, price: price),
    );

    resultOrException.fold(
      ifLeft: (err) {
        isButtonLoading(false);
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
      },
      ifRight: (data) {
        isButtonLoading(false);
        Get.offNamed(RouteName.hunterMissionList);
        Get.snackbar('', LocaleKeys.shared_The_operation_was_successful.tr);
      },
    );
  }

  @override
  void onClose() {
    priceController.dispose();
    super.onClose();
  }
}
