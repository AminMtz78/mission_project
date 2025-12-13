import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mission_project/src/pages/shared/widgets/custom_flexible_widget.dart';

import '../../../infrastructure/utils/utils.dart';
import '../controller/admin_home_controller.dart';

class AdminHomePage extends GetView<AdminHomeController> {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.title)),
      body: SingleChildScrollView(child: _body()),
    );
  }

  Widget _body() => Padding(
    padding: Utils.smallPadding,
    child: Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
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
        ),
        Utils.mediumVerticalSpacer,
        CustomFlexibleWidget(
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
                    'add',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
