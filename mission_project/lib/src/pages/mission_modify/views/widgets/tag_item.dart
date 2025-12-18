import 'package:flutter/material.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/model/view_model/mission_tag_view_model.dart';

class TagItem extends StatelessWidget {
  const TagItem({required this.item, this.onTap, super.key});

  final MissionTagViewModel item;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.smallPadding,
      child: ActionChip.elevated(
        label: Text(item.title),
        onPressed: onTap,
        backgroundColor: Colors.deepPurpleAccent.withValues(alpha: 0.3),
      ),
    );
  }
}
