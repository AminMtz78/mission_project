import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';

class RetryWidget extends StatelessWidget {
  final bool isRetry;
  final VoidCallback onRetry;
  final String message;

  const RetryWidget({
    super.key,
    required this.isRetry,
    required this.onRetry,
    this.message = LocaleKeys.shared_Something_went_wrong_Please_try_again,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRetry) return const SizedBox.shrink();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(LocaleKeys.shared_retry.tr),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
