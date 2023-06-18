import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/pages/splash/splash_controller.dart/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
