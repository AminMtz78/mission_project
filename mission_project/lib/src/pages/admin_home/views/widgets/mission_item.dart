import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/enums/mission_status_enum.dart';
import '../../../shared/model/view_model/mission_tag_view_model.dart';
import '../../../shared/model/view_model/mission_view_model.dart';
import '../../controller/admin_home_controller.dart';

class MissionItem extends GetView<AdminHomeController> {
  const MissionItem({
    super.key,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.item,
    required this.tags,
  });

  final VoidCallback onEdit;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final MissionViewModel item;
  final List<MissionTagViewModel> tags;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
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
              Utils.mediumVerticalSpacer,
              _tags(),
              Utils.mediumVerticalSpacer,
              _footer(),
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
        _statusChip(item.status),
      ],
    );
  }

  Widget _description() {
    return Text(
      item.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
    );
  }

  Widget _tags() {
    if (tags.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        separatorBuilder: (_, _) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final tag = tags[index];
          return Chip(
            label: Text(tag.title, style: const TextStyle(fontSize: 11)),
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }

  Widget _footer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💰 ${item.price.toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Utils.smallVerticalSpacer,
            Text(
              '${LocaleKeys.shared_deadLine.tr}: ${Utils.formatDate(item.deadLine)}',
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
        if (item.status == MissionStatusEnum.free && item.assignedTo == null)
          _actionButtons(),
      ],
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        IconButton(
          color: Colors.lightBlue,
          tooltip: LocaleKeys.shared_edit.tr,
          onPressed: onEdit,
          icon: const Icon(Icons.edit, size: 20),
        ),
        Utils.giantHorizontalSpacer,
        SizedBox(
          child: Obx(
            () => controller.isDeleteLoadingMap[item.id] ?? false
                ? Transform.scale(
                    scale: 0.5,
                    child: CircularProgressIndicator(),
                  )
                : IconButton(
                    color: Colors.red.shade200,
                    tooltip: LocaleKeys.shared_delete.tr,
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, size: 20),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _statusChip(MissionStatusEnum status) {
    return Chip(
      label: Text(status.title.tr, style: const TextStyle(fontSize: 11)),
      backgroundColor: status.color(),
      avatar: Icon(Icons.circle, size: 10, color: status.color()),
      visualDensity: VisualDensity.compact,
    );
  }
}
