import 'package:mission_project/generated/locales.g.dart';

enum UserTypeEnum {
  admin(1, LocaleKeys.shared_admin),
  hunter(2, LocaleKeys.shared_hunter);

  final int id;
  final String title;

  const UserTypeEnum(this.id, this.title);

  static UserTypeEnum fromId(int id) {
    return UserTypeEnum.values.firstWhere(
      (e) => e.id == id,
      orElse: () => UserTypeEnum.admin,
    );
  }
}
