import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/routes/route_name.dart';
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
  var title = LocaleKeys.mission_requests.tr;

  final AdminRequestRepository _repository = AdminRequestRepository();

  MissionViewModel? model;

  final List<MissionTagViewModel> tagList = [];
  final RxList<MissionRequestViewModel> requests =
      <MissionRequestViewModel>[].obs;
  final List<int> userIds = [];
  List<UserViewModel> users = [];

  final RxBool isLoading = false.obs;
  final RxBool isRetry = false.obs;
  final RxBool isButtonLoading = false.obs;

  @override
  void onInit() async {
    await getMissionById();
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
      ifRight: (data) async {
        tagList.addAll(data);
        if (model!.status == MissionStatusEnum.free) {
          await getRequestByMissionId();
        } else {
          isLoading(false);
        }
      },
    );
  }

  Future<void> getRequestByMissionId() async {
    requests.clear();
    isLoading(true);
    final resultOrException = await _repository.getRequestByMissionId(
      missionId,
    );

    resultOrException.fold(
      ifLeft: (err) {
        isLoading(false);
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
      },
      ifRight: (data) async {
        await getUsers();
        requests.addAll(data);
        userIds.addAll(requests.map((e) => e.userId).toList());
      },
    );
  }

  Future<void> getUsers() async {
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
        Get.back(result: true);
      },
    );
  }

  Future<void> submitMissionCompletion() async {
    isButtonLoading(true);
    final resultOrException = await _repository.editMissionStatusDone(
      missionId: model!.id,
      mission: MissionDto(
        title: model!.title,
        description: model!.description,
        price: model!.price,
        deadLine: model!.deadLine,
        tags: model!.tags,
        status: MissionStatusEnum.done,
        createdBy: model!.createdBy,
        assignedTo: model!.assignedTo,
      ),
    );

    resultOrException.fold(
      ifLeft: (err) {
        isButtonLoading(false);
        Get.snackbar('', LocaleKeys.shared_server_communication_error.tr);
      },
      ifRight: (data) {
        Get.back(result: true);
        isButtonLoading(false);
      },
    );
  }

  void goToHunterHistoryPage(int userId) =>
      Get.toNamed(RouteName.hunterHistory, parameters: {'id': '$userId'});

  UserViewModel fetchUserToRequest(MissionRequestViewModel request) {
    final item = users.firstWhere((e) => e.id == request.userId);
    return item;
  }
}
