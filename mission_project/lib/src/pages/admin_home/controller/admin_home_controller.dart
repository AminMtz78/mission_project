import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/commons/app_controller.dart';
import '../../../infrastructure/routes/route_name.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import '../repository/admin_home_repository.dart';

class AdminHomeController extends GetxController {
  final String title = 'admin mission app bar';

  final AdminHomeRepository _repository = AdminHomeRepository();

  final String searchText = '';
  final String filterDate = '';

  RxBool isLoading = false.obs;
  RxBool isRetry = false.obs;

  RxList<MissionViewModel> missions = <MissionViewModel>[].obs;

  @override
  void onInit() {
    getMissions();
    super.onInit();
  }

  Future<void> getMissions() async {
    missions.clear();
    isLoading(true);
    isRetry(false);
    final resultOrException = await _repository.getUser(query: _query());

    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('err', LocaleKeys.shared_server_communication_error.tr);
        isLoading(false);
        isRetry(true);
      },
      ifRight: (data) {
        isLoading(false);
        missions.addAll(data);
      },
    );
  }

  Map<String, String> _query() => {
    'createdBy': AppController().currentUser!.id.toString(),
  };

  Future<void> goToAddMissionPage() async {
    final result = await Get.toNamed(RouteName.addMission);
    if (result != null) {}
  }
}
