import 'package:get/get.dart';
import 'package:mission_project/src/pages/mission_modify/model/dto/mission_tag_dto.dart';

import '../repository/modify_mission_repository.dart';
import 'modify_mission_controller.dart';

class AddMissionController extends ModifyMissionController {
  @override
  String get title => 'add mission app bar';

  Future<void> addTag() async {
    isLoading(true);

    // final resultOrException = await repository.addTag(
    //   MissionTagDto(title: 'title', createdBy: 0),
    //   //todo : complete api
    // );
  }
}
