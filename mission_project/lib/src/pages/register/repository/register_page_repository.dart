import 'package:dart_either/dart_either.dart';

import '../../../infrastructure/commons/api_client.dart';
import '../../../infrastructure/commons/repository_url.dart';
import '../../shared/model/view_model/user_view_model.dart';
import '../model/user_dto.dart';

class RegisterPageRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Either<String, int>> addNewUser(UserDto user) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      RepositoryUrls.postUser,
      user.toJson(),
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) {
        return Right((UserViewModel.fromJson(data)).id);
      },
    );
  }

  Future<Either<String, List<UserViewModel>>> getUser(String username) async {
    final response = await _apiClient.get<List<dynamic>>(
      RepositoryUrls.getUser,
      query: {'username': username},
    );

    return response.fold(
      ifLeft: Left.new,
      ifRight: (data) =>
          Right(data.map((e) => UserViewModel.fromJson(e)).toList()),
    );
  }
}
