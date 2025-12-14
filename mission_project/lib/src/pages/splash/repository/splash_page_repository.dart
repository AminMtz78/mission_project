import 'package:dart_either/dart_either.dart';

import '../../../infrastructure/commons/api_client.dart';
import '../../../infrastructure/commons/repository_url.dart';
import '../../shared/model/view_model/user_view_model.dart';

class SplashPageRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Either<String, UserViewModel>> getUser(int id) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      RepositoryUrls.getUserById(id),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) => Right(UserViewModel.fromJson(data)),
    );
  }
}
