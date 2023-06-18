import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/config/routes/pages.dart';
import 'package:scaner_tbslogistics/app/config/share_prefenreences/share_prefenrences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () => checkUserStatus());
  }

  checkUserStatus() async {
    // Get.toNamed(Routes.LOGIN_PAGE);
    var token = await SharePerApi().getToken();

    if (token != null) {
      Get.toNamed(Routes.HOME_PAGE);
    } else {
      Get.toNamed(Routes.LOGIN_PAGE);
    }
  }
}
