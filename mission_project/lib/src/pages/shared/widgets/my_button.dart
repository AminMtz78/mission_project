import 'package:flutter/material.dart';

import '../../../infrastructure/utils/utils.dart';

class MyButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String title;

  const MyButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(96, 48),

        shape: RoundedRectangleBorder(borderRadius: Utils.roundedRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
          const SizedBox(width: 8),
          if (isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
