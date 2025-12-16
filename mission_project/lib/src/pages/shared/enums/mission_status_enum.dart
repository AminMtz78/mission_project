import 'package:flutter/material.dart';
import '../../../../generated/locales.g.dart';

enum MissionStatusEnum {
  free(1, LocaleKeys.shared_free),
  pendingDoneApproval(2, LocaleKeys.shared_Pending_Approval),
  inProgress(3, LocaleKeys.shared_In_progress),
  failed(4, LocaleKeys.shared_Failed),
  done(5, LocaleKeys.shared_Done);

  final int id;
  final String title;

  const MissionStatusEnum(this.id, this.title);

  static MissionStatusEnum fromId(int id) => MissionStatusEnum.values
      .firstWhere((e) => e.id == id, orElse: () => MissionStatusEnum.free);

  Color color() {
    switch (this) {
      case MissionStatusEnum.free:
        return Colors.green.withValues(alpha: 0.4);
      case MissionStatusEnum.pendingDoneApproval:
        return Colors.orange.withValues(alpha: 0.4);
      case MissionStatusEnum.inProgress:
        return Colors.blue.withValues(alpha: 0.4);
      case MissionStatusEnum.failed:
        return Colors.red.withValues(alpha: 0.4);
      case MissionStatusEnum.done:
        return Colors.green.withValues(alpha: 0.4);
    }
  }
}
