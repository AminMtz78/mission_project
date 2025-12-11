enum UserTypeEnum {
  admin(1, "admin"),
  hunter(2, "hunter");

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
