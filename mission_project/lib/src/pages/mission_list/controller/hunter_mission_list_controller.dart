import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../../infrastructure/routes/route_name.dart';
import '../../shared/enums/date_enum.dart';
import '../../shared/enums/mission_status_enum.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import '../repository/hunter_mission_list_repository.dart';
import '../views/widgets/hunter_filter_dialog.dart';

class HunterMissionListController extends GetxController {
  final String title = LocaleKeys.mission_mission_list.tr;

  final HunterMissionListRepository _repository = HunterMissionListRepository();

  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  RxBool isLoading = false.obs;
  RxBool isRetry = false.obs;

  Rxn<MissionTagViewModel> filterTagModel = Rxn();
  Rxn<MissionTagViewModel> tempFilterTagModel = Rxn();

  RxList<MissionViewModel> missions = <MissionViewModel>[].obs;
  List<int> allTagIds = [];
  RxList<MissionTagViewModel> allUsedTags = <MissionTagViewModel>[].obs;

  // dialog

  double minPrice = 0;
  double maxPrice = 0;

  RxDouble minSelectedPrice = 0.0.obs;
  RxDouble maxSelectedPrice = 0.0.obs;
  RxBool isExpired = false.obs;
  RxBool isInProgress = false.obs;
  RxBool isDone = false.obs;
  Rxn<DateEnum> sortDate = Rxn();

  RxDouble tempMinPrice = 0.0.obs;
  RxDouble tempMaxPrice = 0.0.obs;
  RxBool tempIsExpired = false.obs;
  RxBool tempIsInProgress = false.obs;
  RxBool tempIsDone = false.obs;
  Rxn<DateEnum> tempSortDate = Rxn();

  @override
  void onInit() async {
    await initial();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
  }

  bool isInProgressWithLoggedInUser(MissionViewModel mission) {
    return AppController().currentUser!.id == mission.assignedTo;
  }

  void onSearch(String value) async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      await getMissions();
    });
  }

  Future<void> initial() async {
    isLoading(true);

    await getMissions();

    if (missions.isNotEmpty) {
      minPrice = missions.map((e) => e.price).reduce((a, b) => a < b ? a : b);
      maxPrice = missions.map((e) => e.price).reduce((a, b) => a > b ? a : b);

      minSelectedPrice.value = minPrice;
      maxSelectedPrice.value = maxPrice;

      tempMinPrice.value = minPrice;
      tempMaxPrice.value = maxPrice;

      allTagIds = missions.expand((e) => e.tags).toSet().toList();
      await getTagsByUserIdAndTagIds();
    }

    isLoading(false);
  }

  List<MissionTagViewModel> fetchTagsByMission(List<int> tagIds) {
    List<MissionTagViewModel> currentMissionTags = allUsedTags
        .where((tag) => tagIds.contains(tag.id))
        .toList();

    return currentMissionTags;
  }

  Future<void> getMissions() async {
    missions.clear();
    isLoading(true);
    isRetry(false);
    final resultOrException = await _repository.getMissions(query: _query());

    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
        isLoading(false);
        isRetry(true);
      },
      ifRight: (data) {
        isLoading(false);
        missions.addAll(data);
      },
    );
  }

  Future<void> getTagsByUserIdAndTagIds() async {
    allUsedTags.clear();
    isLoading(true);
    isRetry(false);

    final resultOrException = await _repository.getTag(
      query: {'id': allTagIds},
    );

    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
        isRetry(true);
        isLoading(false);
      },
      ifRight: (data) {
        allUsedTags.addAll(data);
        isLoading(false);
      },
    );
  }

  Map<String, dynamic> _query() {
    final query = <String, dynamic>{};

    final nowIso = DateTime.now().toIso8601String();

    if (minSelectedPrice.value > 0) {
      query['price_gte'] = minSelectedPrice.value.toInt().toString();
    }
    if (maxSelectedPrice.value > 0) {
      query['price_lte'] = maxSelectedPrice.value.toString();
    }
    if (isExpired.value) {
      query['deadLine_lt'] = nowIso;
    }
    if (isInProgress.value) {
      query['status'] = MissionStatusEnum.inProgress.id.toString();
    }
    if (isDone.value) {
      query['status'] = MissionStatusEnum.done.id.toString();
    }
    if (sortDate.value != null) {
      query['_sort'] = 'deadLine';
      query['_order'] = sortDate.value == DateEnum.newest ? 'desc' : 'asc';
    }
    if (filterTagModel.value != null) {
      query['tags_like'] = filterTagModel.value!.id;
    }

    if (searchController.text.isNotEmpty) {
      query['q'] = searchController.text.trim();
    }
    return query;
  }

  void openFilterDialog() async {
    initialDialogData();
    final result = await Get.dialog(HunterFilterDialog());
    if (result != null) {
      getMissions();
    }
  }

  void applyFilters() {
    minSelectedPrice.value = tempMinPrice.value;
    maxSelectedPrice.value = tempMaxPrice.value;
    filterTagModel.value = tempFilterTagModel.value;
    isExpired.value = tempIsExpired.value;
    isInProgress.value = tempIsInProgress.value;
    isDone.value = tempIsDone.value;
    sortDate.value = tempSortDate.value;
    Get.back(result: true);
  }

  void deleteFilter() {
    minSelectedPrice.value = 0;
    maxSelectedPrice.value = 0;
    filterTagModel.value = null;
    isExpired.value = false;
    isInProgress.value = false;
    isDone.value = false;
    sortDate.value = null;
    Get.back();
    initial();
  }

  void initialDialogData() {
    tempMinPrice.value = minSelectedPrice.value == 0
        ? minPrice
        : minSelectedPrice.value;

    tempMaxPrice.value = maxSelectedPrice.value == 0
        ? maxPrice
        : maxSelectedPrice.value;

    tempFilterTagModel.value = filterTagModel.value;
    tempIsExpired.value = isExpired.value;
    tempIsInProgress.value = isInProgress.value;
    tempIsDone.value = isDone.value;
    tempSortDate.value = sortDate.value;
  }

  void onTagSelected(MissionTagViewModel tag) {
    tempFilterTagModel.value = tag;
  }

  RxBool isTagSelected(MissionTagViewModel tag) {
    return (tempFilterTagModel.value?.id == tag.id).obs;
  }

  Future<void> goToHunterRequestPage(int missionId) async {
    final result = await Get.toNamed(
      RouteName.hunterMissionDetail,
      parameters: {'missionId': '$missionId'},
    );
    if (result != null) {
      initial();
    }
  }
}
