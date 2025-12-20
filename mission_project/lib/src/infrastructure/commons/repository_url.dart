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

  static String getTagsByUserIdAndTitle(int userId, String title) =>
      '$baseUrl/tags?createdBy=$userId&title=$title';

  // missions
  static const String addMission = '$baseUrl/missions';
  static String getMissions = '$baseUrl/missions';

  static String getMissionsById(int id) => '$baseUrl/missions/$id';

  static String editMissionsById(int id) => '$baseUrl/missions/$id';

  static String deleteMission(int id) => '$baseUrl/missions/$id';

  static String getMissionByAssignedUserId(int assignedUserId) =>
      '$baseUrl/missions/?assignedTo=$assignedUserId';

  // request
  static const String addRequest = '$baseUrl/requests';
  static const String getRequest = '$baseUrl/requests';

  static String getRequestByMissionId(int missionId) =>
      '$baseUrl/requests?missionId=$missionId';
}
