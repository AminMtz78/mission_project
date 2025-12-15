import '../../../shared/enums/mission_status_enum.dart';

class MissionDto {
  final String title;
  final String description;
  final double price;
  final DateTime deadLine;
  final List<int> tags;
  final MissionStatusEnum status;
  final int createdBy;
  final int? assignedTo;

  MissionDto({
    required this.title,
    required this.description,
    required this.price,
    required this.deadLine,
    required this.tags,
    required this.status,
    required this.createdBy,
    this.assignedTo,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'deadLine': deadLine.toIso8601String(),
      'tags': tags,
      'status': status.id,
      'createdBy': createdBy,
      'assignedTo': assignedTo,
    };
  }
}
