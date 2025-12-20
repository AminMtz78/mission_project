import '../../enums/user_type_enum.dart';

class UserViewModel {
  final int id;
  final String username;
  final String password;
  final UserTypeEnum userType;

  UserViewModel({
    required this.id,
    required this.username,
    required this.password,
    required this.userType,
  });

  factory UserViewModel.fromJson(Map<String, dynamic> json) {
    return UserViewModel(
      id: json['id'],
      username: json["username"],
      password: json["password"],
      userType: UserTypeEnum.fromId(json['userType']),
    );
  }
}
