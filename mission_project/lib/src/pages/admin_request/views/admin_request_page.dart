import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_request_controller.dart';

class AdminRequestPage extends GetView<AdminRequestController> {
  const AdminRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(controller.title)));
  }
}
