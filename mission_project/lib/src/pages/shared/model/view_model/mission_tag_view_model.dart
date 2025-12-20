class MissionTagViewModel {
  final int id;
  final String title;
  final int createdBy;

  const MissionTagViewModel({
    required this.id,
    required this.title,
    required this.createdBy,
  });

  factory MissionTagViewModel.fromJson(Map<String, dynamic> json) =>
      MissionTagViewModel(
        id: json['id'],
        title: json['title'],
        createdBy: json['createdBy'],
      );
}
