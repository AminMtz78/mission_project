import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/mission_project.dart';

import '../../../../generated/locales.g.dart';
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
        actions: [
          IconButton(
            onPressed: AppController().changeLanguage,
            icon: Icon(Icons.language),
          ),
        ],
        title: Text(LocaleKeys.shared_admin_mission_page_title.tr),
        leading: Tooltip(
          message: LocaleKeys.shared_Logout.tr,
          child: IconButton(
            onPressed: AppController().logOut,
            icon: Icon(Icons.logout),
          ),
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
              child: Text(
                style: TextStyle(fontWeight: FontWeight.bold),
                LocaleKeys.shared_add.tr,
              ),
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
