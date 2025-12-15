import 'package:flutter/material.dart';

import '../../../shared/model/view_model/mission_view_model.dart';

class MissionItem extends StatelessWidget {
  const MissionItem({super.key, required this.item});

  final MissionViewModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.description),
      onTap: () {},
    );
  }
}
