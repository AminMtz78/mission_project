import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/enums/mission_status_enum.dart';
import '../../../shared/model/view_model/mission_tag_view_model.dart';
import '../../../shared/model/view_model/mission_view_model.dart';

class MissionItem extends StatelessWidget {
  const MissionItem({
    super.key,
    required this.onTap,
    required this.item,
    required this.tags,
    required this.isInProgressWithLoggedInUser,
    required this.isExpired,
  });

  final VoidCallback onTap;
  final MissionViewModel item;
  final List<MissionTagViewModel> tags;
  final bool isInProgressWithLoggedInUser;
  final bool isExpired;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: Utils.smallPadding,
      shape: RoundedRectangleBorder(borderRadius: Utils.roundedRadius),
      child: InkWell(
        borderRadius: Utils.roundedRadius,
        onTap: onTap,
        child: Padding(
          padding: Utils.mediumPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleAndStatus(),
              Utils.smallVerticalSpacer,
              _description(),
              if (tags.isNotEmpty) ...[Utils.smallVerticalSpacer, _tags()],
              Utils.mediumVerticalSpacer,
              _priceAndDate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleAndStatus() {
    return Row(
      children: [
        Expanded(
          child: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        if (isExpired) _expiredChip(),
        Utils.smallHorizontalSpacer,
        _statusChip(item.status),
      ],
    );
  }

  Widget _description() {
    return Text(
      item.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.4),
    );
  }

  Widget _tags() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: tags.length,
        separatorBuilder: (_, _) => Utils.xSmallHorizontalSpacer,
        itemBuilder: (context, index) {
          final tag = tags[index];
          return Chip(
            label: Text(tag.title, style: const TextStyle(fontSize: 11)),
            backgroundColor: Colors.deepPurpleAccent.withValues(alpha: 0.08),
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }

  Widget _priceAndDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.payments_outlined, size: 16),
            Utils.smallVerticalSpacer,
            Text(
              item.price.toStringAsFixed(0),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.schedule, size: 14),
            Utils.smallVerticalSpacer,
            Text(
              Utils.formatDate(item.deadLine),
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statusChip(MissionStatusEnum status) {
    return Chip(
      label: Text(
        (isInProgressWithLoggedInUser &&
                item.status == MissionStatusEnum.inProgress)
            ? LocaleKeys.mission_in_progress_by_logged_in_user.tr
            : status.title.tr,
        style: const TextStyle(fontSize: 11),
      ),
      backgroundColor: status.color(),
      visualDensity: VisualDensity.compact,
      side: BorderSide(color: status.color()),
    );
  }

  Widget _expiredChip() {
    return Chip(
      label: Text(
        LocaleKeys.shared_expired.tr,
        style: const TextStyle(fontSize: 11),
      ),
      backgroundColor: Colors.red.shade100,
      visualDensity: VisualDensity.compact,
    );
  }
}
