import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../../infrastructure/routes/route_name.dart';
import '../../shared/enums/date_enum.dart';
import '../../shared/enums/mission_status_enum.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import '../repository/admin_home_repository.dart';
import '../views/widgets/filter_dialog.dart';

class AdminHomeController extends GetxController {
  final String title = 'admin mission app bar';

  final AdminHomeRepository _repository = AdminHomeRepository();

  final String searchText = '';
  final String filterDate = '';

  RxBool isLoading = false.obs;
  RxBool isRetry = false.obs;

  RxList<MissionViewModel> missions = <MissionViewModel>[].obs;

  // dialog

  double minPrice = 0;
  double maxPrice = 1000;

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
  void onInit() {
    getMissions();
    super.onInit();
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

  Map<String, dynamic> _query() {
    final query = <String, dynamic>{};

    query['createdBy'] = AppController().currentUser!.id.toString();

    final nowIso = DateTime.now().toIso8601String();

    if (minSelectedPrice.value > 0) {
      query['price_gte'] = minSelectedPrice.value.toInt().toString();
    }
    if (maxSelectedPrice.value > 0) {
      query['price_lte'] = maxSelectedPrice.value.toInt().toString();
    }
    if (isExpired.value && !isInProgress.value) {
      query['deadLine_lt'] = nowIso;
    }
    if (!isExpired.value && isInProgress.value) {
      query['deadLine_gte'] = nowIso;
    }
    if (isDone.value) {
      query['status'] = MissionStatusEnum.done.id.toString();
    }
    if (sortDate.value != null) {
      query['_sort'] = 'deadLine';
      query['_order'] = sortDate.value == DateEnum.newest ? 'desc' : 'asc';
    }

    return query;
  }

  Future<void> goToAddMissionPage() async {
    final result = await Get.toNamed(RouteName.addMission);
    if (result != null) {
      getMissions();
    }
  }

  Future<void> goToEditMissionPage(int id) async {
    final result = await Get.toNamed(
      RouteName.editMission,
      parameters: {'id': '$id'},
    );
    if (result != null) {
      getMissions();
    }
  }

  void openFilterDialog() async {
    initialDialogDate();
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

  void initialDialogDate() {
    tempMinPrice.value = minPrice;
    tempMaxPrice.value = maxPrice;
    tempIsExpired.value = isExpired.value;
    tempIsInProgress.value = isInProgress.value;
    tempIsDone.value = isDone.value;
    tempSortDate.value = sortDate.value;
  }
}
