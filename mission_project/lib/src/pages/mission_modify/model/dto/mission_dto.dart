

import '../../../shared/enums/mission_status_enum.dart';

class MissionDto {
  final String title;
  final String description;
  final double price;
  final DateTime deadLine;
  final List<int> tags;
  final MissionStatusEnum status;
  final int? createdBy; // nullable
  final int? assignedTo; // nullable

  MissionDto({
    required this.title,
    required this.description,
    required this.price,
    required this.deadLine,
    required this.tags,
    required this.status,
    this.createdBy,
    this.assignedTo,
  });

  factory MissionDto.fromJson(Map<String, dynamic> json) {
    return MissionDto(
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      deadLine: DateTime.parse(json['deadLine'] as String),
      tags: [],
      // todo : complete tag
      status: MissionStatusEnum.values.firstWhere(
        (x) => x.toString() == 'MissionStatusEnum.${json['status']}',
      ),
      createdBy: json['createdBy'] != null ? json['createdBy'] as int : null,
      assignedTo: json['assignedTo'] != null ? json['assignedTo'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'deadLine': deadLine.toIso8601String(),
      'tags': tags.map((e) => e.toString().split('.').last).toList(),
      'status': status.toString().split('.').last,
      'createdBy': createdBy,
      'assignedTo': assignedTo,
    };
  }
}
