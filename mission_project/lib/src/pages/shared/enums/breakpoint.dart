import 'package:flutter/cupertino.dart';

enum Breakpoint {
  phone._(720),
  tablet._(960),
  desktop._(1320);

  final double maxWidth;

  const Breakpoint._(this.maxWidth);

  static T either<T>(
    BuildContext context, {
    required Breakpoint breakpoint,
    required T Function() before,
    required T Function() after,
  }) => MediaQuery.sizeOf(context).width < breakpoint.maxWidth
      ? before()
      : after();
}
