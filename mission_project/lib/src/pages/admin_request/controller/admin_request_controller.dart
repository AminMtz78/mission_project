import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../mission_modify/model/dto/mission_dto.dart';
import '../../shared/enums/mission_status_enum.dart';
import '../../shared/model/view_model/mission_request_view_model.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import '../../shared/model/view_model/user_view_model.dart';
import '../repository/admin_request_repository.dart';

class AdminRequestController extends GetxController {
  AdminRequestController({required this.missionId});

  final int missionId;
  var title = 'admin request page';

  final AdminRequestRepository _repository = AdminRequestRepository();

  MissionViewModel? model;
  final List<MissionTagViewModel> tagList = [];
  final RxList<MissionRequestViewModel> requests = <MissionRequestViewModel>[].obs;
  final List<int> userIds = [];
  List<UserViewModel> users = [];

  final RxBool isLoading = false.obs;
  final RxBool isRetry = false.obs;
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
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
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
        getRequestByMissionId();
      },
    );
  }

  Future<void> getRequestByMissionId() async {
    isLoading(true);
    final resultOrException = await _repository.getRequestByMissionId(
      missionId,
    );

    resultOrException.fold(
      ifLeft: (err) {
        isLoading(false);
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
      },
      ifRight: (data) {
        requests.addAll(data);
        userIds.addAll(requests.map((e) => e.userId).toList());
        getUsers();
      },
    );
  }

  Future<void> getUsers() async {
    isLoading(true);
    final resultOrException = await _repository.getUser(userIds: userIds);
    resultOrException.fold(
      ifLeft: (err) {
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
        isLoading(false);
      },
      ifRight: (data) {
        users = data;
        isLoading(false);
      },
    );
  }

  Future<void> acceptUserRequestForMission(
    MissionRequestViewModel request,
  ) async {
    isLoading(true);
    final resultOrException = await _repository.acceptUserRequestForMission(
      missionId: request.missionId,
      mission: MissionDto(
        title: model!.title,
        description: model!.description,
        price: model!.price,
        deadLine: model!.deadLine,
        tags: model!.tags,
        status: MissionStatusEnum.inProgress,
        createdBy: model!.createdBy,
        assignedTo: request.userId,
      ),
    );

    resultOrException.fold(
      ifLeft: (err) {
        isLoading(false);
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
      },
      ifRight: (data) {
        isLoading(false);
      },
    );
  }

  UserViewModel findUserForRequest(MissionRequestViewModel request) {
    final item = users.firstWhere((e) => e.id == request.userId);
    return item;
  }
}
