import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../infrastructure/utils/utils.dart';
import '../../../shared/model/view_model/mission_request_view_model.dart';
import '../../../shared/model/view_model/user_view_model.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({
    required this.item,
    required this.user,
    required this.onAccept,
    required this.onUserProfile,
    super.key,
  });

  final MissionRequestViewModel item;
  final UserViewModel user;
  final VoidCallback onAccept;
  final VoidCallback onUserProfile;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: Utils.mediumPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// user row
            Row(
              children: [
                Tooltip(
                  message: LocaleKeys.mission_user_profile.tr,
                  child: InkWell(
                    onTap: onUserProfile,
                    borderRadius: BorderRadius.circular(20),
                    child: CircleAvatar( child: const FlutterLogo()),
                  ),
                ),
                Utils.mediumHorizontalSpacer,
                Expanded(
                  child: Text(
                    user.username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            Utils.mediumVerticalSpacer,

            Row(
              children: [
                const Icon(Icons.attach_money, size: 18),
                Utils.smallHorizontalSpacer,
                Text(
                  '${LocaleKeys.mission_offer_price.tr}: '
                  '${item.price.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ],
            ),

            Utils.mediumVerticalSpacer,

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAccept,
                icon: const Icon(Icons.check),
                label: Text(LocaleKeys.shared_accept.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
