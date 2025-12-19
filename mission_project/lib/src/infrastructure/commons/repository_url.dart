class RepositoryUrls {
  static const String baseUrl = 'http://localhost:3000';

  //users
  static const String postUser = '$baseUrl/users';
  static const String getUser = '$baseUrl/users';

  static String getUserById(int userId) => '$baseUrl/users/$userId';

  // tag
  static const String addTag = '$baseUrl/tags';
  static const String getTags = '$baseUrl/tags';

  static String getTagsByUserId(int userId) =>
      '$baseUrl/tags?createdBy=$userId';

  // missions
  static const String addMission = '$baseUrl/missions';
  static String getMissions = '$baseUrl/missions';

  static String getMissionsById(int id) => '$baseUrl/missions/$id';

  static String editMissionsById(int id) => '$baseUrl/missions/$id';

  // request
  static const String addRequest = '$baseUrl/requests';
  static const String getRequest = '$baseUrl/requests';

}
