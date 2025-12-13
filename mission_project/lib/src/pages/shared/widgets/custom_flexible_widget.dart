import 'package:flutter/material.dart';

class CustomFlexibleWidget extends StatelessWidget {
  const CustomFlexibleWidget({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(fit: FlexFit.tight, child: SizedBox()),
        Flexible(child: widget),
        Flexible(fit: FlexFit.tight, child: SizedBox()),
      ],
    );
  }
}
