import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/src/pages/shared/enums/mission_status_enum.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/enums/breakpoint.dart';
import '../../../shared/model/view_model/mission_tag_view_model.dart';
import '../../../shared/model/view_model/mission_view_model.dart';

class MissionDetailsCard extends StatelessWidget {
  const MissionDetailsCard({
    super.key,
    required this.item,
    required this.tags,
    required this.isInProgressWithLoggedInUser,
  });

  final MissionViewModel item;
  final List<MissionTagViewModel> tags;
  final bool isInProgressWithLoggedInUser;

  @override
  Widget build(BuildContext context) => Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: Utils.roundedRadius),
    child: Padding(
      padding: Utils.mediumPadding,
      child: Breakpoint.either(
        context,
        breakpoint: Breakpoint.phone,
        before: () => _forSmallSc(context),
        after: () => _forLargeSc(context),
      ),
    ),
  );

  Widget _forSmallSc(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        Utils.smallVerticalSpacer,
        _description(),
        Utils.mediumVerticalSpacer,
        _infoRow(),
        const SizedBox(height: Utils.mSmallSpace),
        _tags(),
      ],
    ),
  );

  Widget _forLargeSc(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            Utils.smallVerticalSpacer,
            _description(),
            Utils.smallVerticalSpacer,
            _tags(),
          ],
        ),
      ),
      Utils.giantVerticalSpacer,
      Expanded(flex: 1, child: _infoColumn()),
    ],
  );

  Widget _title() => Text(
    item.title,
    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  );

  Widget _description() => Text(
    item.description,
    style: TextStyle(color: Colors.grey.shade700, height: 1.4),
  );

  Widget _infoRow() => Wrap(
    spacing: Utils.smallSpace,
    runSpacing: Utils.smallSpace,
    children: [_priceChip(), _deadlineChip(), _statusChip()],
  );

  Widget _infoColumn() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _priceChip(),
      Utils.smallVerticalSpacer,
      _deadlineChip(),
      Utils.smallVerticalSpacer,
      _statusChip(),
    ],
  );

  Widget _priceChip() => Chip(
    avatar: const Icon(Icons.attach_money, size: Utils.xMediumSpace),
    label: Text(item.price.toStringAsFixed(2)),
  );

  Widget _deadlineChip() => Chip(
    avatar: const Icon(Icons.timer, size: Utils.xMediumSpace),
    label: Text(
      '${item.deadLine.year}/${item.deadLine.month}/${item.deadLine.day}',
    ),
  );

  Widget _statusChip() => Chip(
    backgroundColor: item.status.color(),
    avatar: Icon(
      Icons.circle,
      size: Utils.mSmallSpace,
      color: item.status.color(),
    ),
    label: Text(
      isInProgressWithLoggedInUser &&
              item.status == MissionStatusEnum.inProgress
          ? LocaleKeys.mission_in_progress_by_logged_in_user.tr
          : item.status.title.tr,
    ),
  );

  Widget _tags() => Wrap(
    spacing: Utils.smallSpace,
    runSpacing: Utils.tinySpace,
    children: tags
        .map(
          (tag) => Chip(
            label: Text(tag.title),
            backgroundColor: Colors.blue.shade50,
          ),
        )
        .toList(),
  );
}
