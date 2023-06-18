import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/config/constants/constants.dart';
import 'package:scaner_tbslogistics/app/config/routes/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePerApi {
  Future<dynamic> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppConstants.KEY_ACCESS_TOKEN);

    print(token);

    return token;
  }

  //HRM

  Future<void> postLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(AppConstants.KEY_ACCESS_TOKEN);

    Get.offAllNamed(Routes.LOGIN_PAGE);
  }
}
