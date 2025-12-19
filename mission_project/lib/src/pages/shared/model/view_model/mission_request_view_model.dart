class MissionRequestViewModel {
  final int id;
  final int missionId;
  final int userId;
  final double price;

  const MissionRequestViewModel({
    required this.id,
    required this.missionId,
    required this.userId,
    required this.price,
  });

  factory MissionRequestViewModel.fromJson(Map<String, dynamic> json) {
    return MissionRequestViewModel(
      id: json['id'],
      missionId: json['missionId'],
      userId: json['userId'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
