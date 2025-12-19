import 'package:dart_either/dart_either.dart';

import '../../../infrastructure/commons/api_client.dart';
import '../../../infrastructure/commons/repository_url.dart';
import '../../mission_modify/model/dto/mission_dto.dart';
import '../../shared/model/view_model/mission_request_view_model.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import '../../shared/model/view_model/user_view_model.dart';

class AdminRequestRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Either<String, MissionViewModel>> getMissionById(int id) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      RepositoryUrls.getMissionsById(id),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) {
        return Right(MissionViewModel.fromJson(data));
      },
    );
  }

  Future<Either<String, List<MissionTagViewModel>>> getTagsByIds(
    List<int> ids,
  ) async {
    final response = await _apiClient.get<List<dynamic>>(
      RepositoryUrls.getTags,
      query: {'id': ids},
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) =>
          Right(data.map((e) => MissionTagViewModel.fromJson(e)).toList()),
    );
  }

  Future<Either<String, List<MissionRequestViewModel>>> getRequestByMissionId(
    int id,
  ) async {
    final response = await _apiClient.get<List<dynamic>>(
      RepositoryUrls.getRequestByMissionId(id),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) =>
          Right(data.map((e) => MissionRequestViewModel.fromJson(e)).toList()),
    );
  }

  Future<Either<String, MissionViewModel>> acceptUserRequestForMission({
    required int missionId,
    required MissionDto mission,
  }) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      RepositoryUrls.editMissionsById(missionId),
      mission.toJson(),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) => Right(MissionViewModel.fromJson(data)),
    );
  }

  Future<Either<String, List<UserViewModel>>> getUser({
    required List<int> userIds,
  }) async {
    final response = await _apiClient.get<List<dynamic>>(
      RepositoryUrls.getUser,
      query: {'id': userIds},
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) =>
          Right(data.map((e) => UserViewModel.fromJson(e)).toList()),
    );
  }
}
