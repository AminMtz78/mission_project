import 'package:dart_either/dart_either.dart';

import '../../../infrastructure/commons/api_client.dart';
import '../../../infrastructure/commons/repository_url.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/model/view_model/mission_view_model.dart';
import '../model/dto/mission_dto.dart';
import '../model/dto/mission_tag_dto.dart';

class ModifyMissionRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Either<String, MissionTagViewModel>> addTag(MissionTagDto tag) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      RepositoryUrls.addTag,
      tag.toJson(),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) => Right(MissionTagViewModel.fromJson(data)),
    );
  }

  Future<Either<String, List<MissionTagViewModel>>> getTag(int id) async {
    final response = await _apiClient.get<List<dynamic>>(
      RepositoryUrls.getTagsByUserId(id),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) =>
          Right(data.map((e) => MissionTagViewModel.fromJson(e)).toList()),
    );
  }

  Future<Either<String, List<MissionTagViewModel>>> getTagsByIds(
    List<int> ids,
  ) async {
    final Map<String, String> queryParams = {};
    for (var i = 0; i < ids.length; i++) {
      queryParams['id[$i]'] = '${ids[i]}}';
    }

    final response = await _apiClient.get<List<dynamic>>(
      RepositoryUrls.getTags,
      query: queryParams,
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) =>
          Right(data.map((e) => MissionTagViewModel.fromJson(e)).toList()),
    );
  }

  Future<Either<String, MissionViewModel>> addMission(
    MissionDto mission,
  ) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      RepositoryUrls.addMission,
      mission.toJson(),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) => Right(MissionViewModel.fromJson(data)),
    );
  }

  Future<Either<String, MissionViewModel>> editMission({
    required int id,
    required MissionDto mission,
  }) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      RepositoryUrls.editMissionsById(id),
      mission.toJson(),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) => Right(MissionViewModel.fromJson(data)),
    );
  }

  Future<Either<String, MissionViewModel>> getMissionById(int id) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      RepositoryUrls.getMissionsById(id),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) => Right(MissionViewModel.fromJson(data)),
    );
  }
}
