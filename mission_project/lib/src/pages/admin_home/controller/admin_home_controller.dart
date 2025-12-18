import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../../infrastructure/routes/route_name.dart';
import '../../shared/enums/date_enum.dart';
import '../../shared/enums/mission_status_enum.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import '../repository/admin_home_repository.dart';
import '../views/widgets/filter_dialog.dart';

class AdminHomeController extends GetxController {
  final String title = 'admin mission app bar';

  final AdminHomeRepository _repository = AdminHomeRepository();

  final TextEditingController searchController = TextEditingController();
  final String searchText = '';

  RxBool isLoading = false.obs;
  RxBool isRetry = false.obs;

  RxList<MissionViewModel> missions = <MissionViewModel>[].obs;
  List<int> allTagIds = [];
  List<MissionTagViewModel> allTags = [];

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
    List<MissionTagViewModel> currentMissionTags = allTags
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
    allTags.clear();
    isLoading(true);
    isRetry(false);
    final int? userId = AppController().currentUser?.id;
    if (userId == null) {
      return;
    }
    final resultOrException = await _repository.getTag(
      query: {'id': allTagIds, 'createdBy': userId},
    );
    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
        isRetry(true);
        isLoading(false);
      },
      ifRight: (data) {
        allTags.addAll(data);
        isLoading(false);
      },
    );
  }

  Map<String, dynamic> _query() {
    final query = <String, dynamic>{};

    query['createdBy'] = AppController().currentUser!.id.toString();

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

    if (searchController.text.isNotEmpty) {
      query['q'] = searchController.text.trim();
    }
    return query;
  }

  Future<void> goToAddMissionPage() async {
    final result = await Get.toNamed(RouteName.addMission);
    if (result != null) {
      deleteFilter();
    }
  }

  Future<void> goToEditMissionPage(int id) async {
    final result = await Get.toNamed(
      RouteName.editMission,
      parameters: {'id': '$id'},
    );
    if (result != null) {
      deleteFilter();
    }
  }

  void openFilterDialog() async {
    initialDialogData();
    final result = await Get.dialog(FilterDialog());
    if (result != null) {
      getMissions();
    }
  }

  void applyFilters() {
    minSelectedPrice.value = tempMinPrice.value;
    maxSelectedPrice.value = tempMaxPrice.value;
    isExpired.value = tempIsExpired.value;
    isInProgress.value = tempIsInProgress.value;
    isDone.value = tempIsDone.value;
    sortDate.value = tempSortDate.value;
    Get.back(result: true);
  }

  void deleteFilter() {
    minSelectedPrice.value = 0;
    maxSelectedPrice.value = 0;
    tempMinPrice.value = minPrice;
    tempMaxPrice.value = maxPrice;
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

    tempIsExpired.value = isExpired.value;
    tempIsInProgress.value = isInProgress.value;
    tempIsDone.value = isDone.value;
    tempSortDate.value = sortDate.value;
  }
}
