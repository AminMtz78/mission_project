import '../../shared/enums/user_type_enum.dart';

class UserDto {
  final String username;
  final String password;
  final UserTypeEnum userType;

  UserDto({
    required this.username,
    required this.password,
    required this.userType,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'userType': userType.id,
    };
  }

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      username: json['username'],
      password: json['password'],
      userType: UserTypeEnum.fromId(json['userType']),
    );
  }
}
