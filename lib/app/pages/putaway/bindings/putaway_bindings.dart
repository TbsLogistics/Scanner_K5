import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/pages/putaway/controller/putaway_controller.dart';

class PutaWayBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PutawayController>(() => PutawayController());
  }
}
