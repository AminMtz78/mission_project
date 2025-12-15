import 'package:dart_either/dart_either.dart';

import '../../../infrastructure/commons/api_client.dart';
import '../../../infrastructure/commons/repository_url.dart';
import '../../shared/model/view_model/mission_view_model.dart';

class AdminHomeRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Either<String, List<MissionViewModel>>> getUser({
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
}
