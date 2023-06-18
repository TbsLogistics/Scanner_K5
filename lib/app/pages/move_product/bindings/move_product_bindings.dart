import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/pages/move_product/controller/move_product_controller.dart';

class MoveProductBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoveProductController>(() => MoveProductController());
  }
}
