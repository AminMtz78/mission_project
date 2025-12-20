import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import '../repository/hunter_history_repository.dart';

class HunterHistoryController extends GetxController {
  HunterHistoryController({required this.hunterId});

  final int hunterId;


  final HunterHistoryRepository _repository = HunterHistoryRepository();

  RxBool isLoading = false.obs;
  RxBool isRetry = false.obs;

  final List<MissionViewModel> missions = [];
  RxList<MissionTagViewModel> allUsedTags = <MissionTagViewModel>[].obs;

  @override
  void onInit() {
    getMissions();
    super.onInit();
  }

  Future<void> getMissions() async {
    missions.clear();
    isLoading(true);
    isRetry(false);
    final resultOrException = await _repository.getMissionsByAssignedId(
      assignedToUserId: hunterId,
    );

    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
        isLoading(false);
        isRetry(true);
      },
      ifRight: (data) async {
        missions.addAll(data);
        await getTagsByTagIds();
      },
    );
  }

  Future<void> getTagsByTagIds() async {
    allUsedTags.clear();
    isLoading(true);
    isRetry(false);

    final resultOrException = await _repository.getTag(
      query: {'id': missions.expand((e) => e.tags).toSet().toList()},
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
  List<MissionTagViewModel> fetchTagsByMission(List<int> tagIds) {
    List<MissionTagViewModel> currentMissionTags = allUsedTags
        .where((tag) => tagIds.contains(tag.id))
        .toList();

    return currentMissionTags;
  }

}
