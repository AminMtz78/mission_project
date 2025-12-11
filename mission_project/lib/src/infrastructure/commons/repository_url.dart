class RepositoryUrls {
  static const String baseUrl = 'http://localhost:3000';
  static const String postUser = '$baseUrl/users';

  static const String getUser = '$baseUrl/users';

  static String getUserById(int userId) => '$baseUrl/users/$userId';
}
