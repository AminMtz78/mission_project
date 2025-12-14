class MissionTagDto {
  final String title;
  final int createdBy;

  const MissionTagDto({required this.title, required this.createdBy});

  Map<String, dynamic> toJson() => {'title': title, 'createdBy': createdBy};
}
