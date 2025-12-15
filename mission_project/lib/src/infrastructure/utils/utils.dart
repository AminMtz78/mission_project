import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';

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

  static final dateInputFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^\d{0,4}-?\d{0,2}-?\d{0,2}$'),
  );

  static final doubleInputFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^\d*\.?\d*$'),
  );

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required / تاریخ الزامی است';
    }

    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value)) {
      return 'Invalid format (yyyy-MM-dd) / فرمت نادرست';
    }

    try {
      final parts = value.split('-');
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      final date = DateTime(year, month, day);

      if (date.year != year || date.month != month || date.day != day) {
        return 'Invalid date / تاریخ نامعتبر';
      }
    } catch (_) {
      return LocaleKeys.shared_required_field.tr;
    }

    return null;
  }

  static String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.shared_required_field.tr;
    }
    return null;
  }
}
