import 'package:flutter/material.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/model/view_model/mission_tag_view_model.dart';

class TagItem extends StatelessWidget {
  const TagItem({
    required this.item,
    required this.selected,
    this.onTap,
    super.key,
  });

  final MissionTagViewModel item;
  final void Function()? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.smallPadding,
      child: ChoiceChip(
        onSelected: (_) => onTap?.call(),
        label: Text(item.title),
        selected: selected,
        backgroundColor: selected
            ? Colors.deepPurpleAccent.withValues(alpha: 0.3)
            : Colors.transparent,
      ),
    );
  }
}
