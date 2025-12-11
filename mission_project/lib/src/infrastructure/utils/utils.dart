import 'package:flutter/material.dart';

class Utils {
  static const double tinySpace = 4;
  static const double xSmallSpace = 6;
  static const double smallSpace = 8;
  static const double mSmallSpace = 12;
  static const double mediumSpace = 16;
  static const double xMediumSpace = 20;
  static const double largeSpace = 24;
  static const double giantSpace = 32;

  static const EdgeInsetsDirectional tinyPadding = EdgeInsetsDirectional.all(
    tinySpace,
  );
  static const EdgeInsetsDirectional smallPadding = EdgeInsetsDirectional.all(
    smallSpace,
  );
  static const EdgeInsetsDirectional mSmallPadding = EdgeInsetsDirectional.all(
    mSmallSpace,
  );
  static const EdgeInsetsDirectional mediumPadding = EdgeInsetsDirectional.all(
    mediumSpace,
  );
  static const EdgeInsetsDirectional largePadding = EdgeInsetsDirectional.all(
    largeSpace,
  );
  static const EdgeInsetsDirectional giantPadding = EdgeInsetsDirectional.all(
    giantSpace,
  );

  static const SizedBox tinyVerticalSpacer = SizedBox(height: tinySpace);
  static const SizedBox xSmallVerticalSpacer = SizedBox(height: xSmallSpace);
  static const SizedBox smallVerticalSpacer = SizedBox(height: smallSpace);
  static const SizedBox mSmallVerticalSpacer = SizedBox(height: mSmallSpace);
  static const SizedBox mediumVerticalSpacer = SizedBox(height: mediumSpace);
  static const SizedBox xMediumVerticalSpacer = SizedBox(height: xMediumSpace);
  static const SizedBox largeVerticalSpacer = SizedBox(height: largeSpace);
  static const SizedBox giantVerticalSpacer = SizedBox(height: giantSpace);

  static const SizedBox tinyHorizontalSpacer = SizedBox(width: tinySpace);
  static const SizedBox xSmallHorizontalSpacer = SizedBox(width: xSmallSpace);
  static const SizedBox smallHorizontalSpacer = SizedBox(width: smallSpace);
  static const SizedBox mSmallHorizontalSpacer = SizedBox(width: mSmallSpace);
  static const SizedBox mediumHorizontalSpacer = SizedBox(width: mediumSpace);
  static const SizedBox xMediumHorizontalSpacer = SizedBox(width: xMediumSpace);
  static const SizedBox largeHorizontalSpacer = SizedBox(width: largeSpace);
  static const SizedBox giantHorizontalSpacer = SizedBox(width: giantSpace);
}
