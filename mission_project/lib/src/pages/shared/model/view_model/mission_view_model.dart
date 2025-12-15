import '../../enums/mission_status_enum.dart';

class MissionViewModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final DateTime deadLine;
  final List<int> tags;
  final MissionStatusEnum status;
  final int createdBy;
  final int? assignedTo;

  MissionViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.deadLine,
    required this.tags,
    required this.status,
    required this.createdBy,
    this.assignedTo,
  });

  factory MissionViewModel.fromJson(Map<String, dynamic> json) {
    return MissionViewModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      deadLine: DateTime.parse(json['deadLine']),
      tags: List<int>.from(json['tags']),
      status: MissionStatusEnum.fromId(json['status']),
      createdBy: json['createdBy'] as int,
      assignedTo: json['assignedTo'],
    );
  }
}
