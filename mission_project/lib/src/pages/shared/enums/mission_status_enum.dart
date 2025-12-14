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
}
