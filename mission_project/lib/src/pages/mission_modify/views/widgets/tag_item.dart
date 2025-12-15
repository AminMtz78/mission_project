import 'package:flutter/material.dart';

import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/model/view_model/mission_tag_view_model.dart';

class TagItem extends StatelessWidget {
  const TagItem({
    required this.item,
    required this.isSelected,
     this.onTap,
    super.key,
  });

  final MissionTagViewModel item;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.smallPadding,
      child: ChoiceChip(
        selected: isSelected,
        onSelected: (_) => onTap?.call(),
        label: Text(item.title),
        selectedColor: Colors.deepPurpleAccent.withValues(alpha: 0.3),
        backgroundColor: Colors.transparent,
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
      ),
    );
  }
}
