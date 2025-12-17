import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/mission_project.dart';

import '../../../infrastructure/utils/utils.dart';
import '../../shared/widgets/custom_flexible_widget.dart';
import '../../shared/widgets/empty_widget.dart';
import '../../shared/widgets/retry_widget.dart';
import '../controller/admin_home_controller.dart';
import 'widgets/mission_list.dart';

class AdminHomePage extends GetView<AdminHomeController> {
  const AdminHomePage({super.key});

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
        _addMissionButton(),
        Utils.mediumVerticalSpacer,

        Expanded(
          child: Obx(
            () => controller.missions.isEmpty ? EmptyWidget() : MissionList(),
          ),
        ),
      ],
    ),
  );

  Widget _addMissionButton() {
    return CustomFlexibleWidget(
      widget: ElevatedButton(
        onPressed: controller.goToAddMissionPage,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            Padding(
              padding: Utils.mediumPadding,
              child: Text(style: TextStyle(fontWeight: FontWeight.bold), 'add'),
            ),
          ],
        ),
      ),
    );
  }

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
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
      ],
    );
  }
}
