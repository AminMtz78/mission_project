import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../shared/model/view_model/mission_view_model.dart';

class HunterHistoryController extends GetxController {
  HunterHistoryController({required this.hunterId});

  final int hunterId;
  final String appBarTitle = LocaleKeys.shared_hunterHistoryPageTittle.tr;
  final List<MissionViewModel> missions = [];
}
