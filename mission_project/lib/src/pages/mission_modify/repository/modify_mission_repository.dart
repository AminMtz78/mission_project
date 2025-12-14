import 'package:dart_either/dart_either.dart';
import 'package:mission_project/src/infrastructure/commons/api_client.dart';

import '../../../infrastructure/commons/repository_url.dart';
import '../model/dto/mission_tag_dto.dart';

class ModifyMissionRepository {
  final ApiClient _apiClient = ApiClient();
  //
  // Future<Either<String, int>> addTag(MissionTagDto tag) async {
  //   final response = await _apiClient.post<Map<String, dynamic>>(
  //     RepositoryUrls.addTag,
  //     tag.toJson(),
  //   );

    // return response.fold(
    //   ifLeft: Left.new,
    //   ifRight: (data) {
    //
    //     //todo: add mission tag view model and complete api
    //   },
    // );
  // }
}
