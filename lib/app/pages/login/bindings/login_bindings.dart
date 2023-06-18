import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/pages/login/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
