import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/enums/mission_status_enum.dart';
import '../../../shared/model/view_model/mission_view_model.dart';

class MissionItem extends StatelessWidget {
  const MissionItem({
    super.key,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.item,
  });

  final VoidCallback onEdit;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final MissionViewModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: Utils.smallPadding,
      decoration: BoxDecoration(
        borderRadius: Utils.roundedRadius,
        color: Colors.deepPurpleAccent.withValues(alpha: 0.05),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: Utils.smallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleAndStatus(),
              Utils.smallVerticalSpacer,
              _description(),
              Utils.smallVerticalSpacer,
              _tags(),
              Utils.smallVerticalSpacer,
              _priceAndDate(),
              Utils.smallVerticalSpacer,
              if (item.status == MissionStatusEnum.free) _deleteAndEditButton(),
            ],
          ),
        ),
      ),
    );
  }

  Row _deleteAndEditButton() {
    return Row(
      children: [
        IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, size: 20)),
        IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete, size: 20),
        ),
      ],
    );
  }

  Row _priceAndDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Price + Deadline
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
      ],
    );
  }

  SizedBox _tags() {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: item.tags.length,
        separatorBuilder: (_, _) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final tag = item.tags[index];
          return Chip(
            label: Text('tag.title', style: const TextStyle(fontSize: 12)),
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }

  Text _description() {
    return Text(
      item.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 13),
    );
  }

  Row _titleAndStatus() {
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

  Widget _statusChip(MissionStatusEnum status) {
    return Chip(
      label: Text(status.title.tr, style: const TextStyle(fontSize: 11)),
      backgroundColor: status.color(),
      visualDensity: VisualDensity.compact,
    );
  }
}
