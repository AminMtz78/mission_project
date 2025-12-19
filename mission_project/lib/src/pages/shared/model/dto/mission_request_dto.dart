class MissionRequestDto {
  final int missionId;
  final int userId;
  final double price;

  const MissionRequestDto({
    required this.missionId,
    required this.userId,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'missionId': missionId,
      'userId': userId,
      'price': price,
    };
  }
}
