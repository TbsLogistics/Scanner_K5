import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/pages/cargo_team/controller/cargo_team_controller.dart';

class CargoTeamBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CargoTeamController>(() => CargoTeamController());
  }
}
