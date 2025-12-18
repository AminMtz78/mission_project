import 'package:dart_either/dart_either.dart';
import 'package:mission_project/src/infrastructure/commons/api_client.dart';

import '../../../infrastructure/commons/repository_url.dart';
import '../../shared/model/view_model/mission_tag_view_model.dart';
import '../../shared/model/view_model/mission_view_model.dart';

class HunterMissionListRepository {


  final ApiClient _apiClient = ApiClient();

  Future<Either<String, List<MissionViewModel>>> getMissions({
    required Map<String, dynamic> query,
  }) async {
    final response = await _apiClient.get<List<dynamic>>(
      RepositoryUrls.getMissions,
      query: query,
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) =>
          Right(data.map((e) => MissionViewModel.fromJson(e)).toList()),
    );
  }
  Future<Either<String, List<MissionTagViewModel>>> getTag({
    required Map<String,dynamic> query,
  }) async {
    final response = await _apiClient.get<List<dynamic>>(
        RepositoryUrls.getTags,
        query: query
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) =>
          Right(data.map((e) => MissionTagViewModel.fromJson(e)).toList()),
    );
  }


}