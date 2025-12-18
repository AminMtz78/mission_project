import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/routes/route_name.dart';
import '../../../infrastructure/utils/utils.dart';
import '../../shared/widgets/empty_widget.dart';
import '../../shared/widgets/retry_widget.dart';
import '../controller/hunter_mission_list_controller.dart';
import 'widgets/hunter_mission_list.dart';

class HunterMissionListPage extends GetView<HunterMissionListController> {
  const HunterMissionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        leading: IconButton(
          onPressed: () => Get.offNamed(RouteName.loginPage),
          icon: Icon(Icons.logout),
        ),
      ),
      body: Obx(
        () => controller.isRetry.value
            ? RetryWidget(
                onRetry: controller.getMissions,
                isRetry: controller.isRetry.value,
              )
            : controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : _body(),
      ),
    );
  }

  Widget _body() => Padding(
    padding: Utils.smallPadding,
    child: Column(
      children: [
        _searchAndFilter(),
        Utils.mediumVerticalSpacer,
        Expanded(
          child: Obx(
            () => controller.missions.isEmpty
                ? EmptyWidget()
                : HunterMissionList(),
          ),
        ),
      ],
    ),
  );

  Widget _searchAndFilter() {
    return Row(
      children: [
        IconButton(
          onPressed: controller.openFilterDialog,
          icon: Icon(Icons.tune),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Utils.smallSpace),
            child: TextFormField(
              controller: controller.searchController,
              autofocus: true,
              onChanged: controller.onSearch,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: LocaleKeys.shared_search.tr,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
