import 'package:dart_either/dart_either.dart';

import '../../../infrastructure/commons/api_client.dart';
import '../../../infrastructure/commons/repository_url.dart';
import '../../shared/model/dto/mission_request_dto.dart';
import '../../shared/model/view_model/mission_request_view_model.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/model/view_model/mission_view_model.dart';

class HunterMissionRepository {
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

  Future<Either<String, int>> addRequest(MissionRequestDto request) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      RepositoryUrls.addRequest,
      request.toJson(),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) {
        return Right((MissionRequestViewModel.fromJson(data)).id);
      },
    );
  }

  Future<Either<String, List<MissionRequestViewModel>>>
  getRequestByMissionIdAndUserId({required Map<String, dynamic> query}) async {
    final response = await _apiClient.get<List<dynamic>>(
      RepositoryUrls.getRequest,
      query: query,
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) =>
          Right(data.map((e) => MissionRequestViewModel.fromJson(e)).toList()),
    );
  }
}
