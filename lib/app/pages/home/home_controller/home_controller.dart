import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:scaner_tbslogistics/app/config/constants/constants.dart';
import 'package:scaner_tbslogistics/app/config/routes/pages.dart';
import 'package:scaner_tbslogistics/app/config/share_prefenreences/share_prefenrences.dart';
import 'package:scaner_tbslogistics/app/pages/home/model/list_menu_feature_model.dart';
import 'package:scaner_tbslogistics/app/pages/home/model/user_model.dart';

class HomeController extends GetxController {
  var dio = Dio();
  late Response response;
  Rx<UserModel> userInfo = UserModel().obs;

  RxBool isLoad = false.obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  void getUser() async {
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    print(tokens);
    var url = "${AppConstants.urlBase}/convert-token";
    isLoad(false);
    try {
      response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        var data = response.data;

        print("data : $data");

        if (data["status_code"] == 200) {
          userInfo.value = UserModel.fromJson(data["data"]);
          print("userInfo : $userInfo");
        }
      }
    } on DioError catch (e) {
      print([e.response!.statusCode, e.response!.statusMessage]);
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoad(true);
      });
    }
  }

  List<ListMenuFeature> listMenu = [
    // ListMenuFeature(id: 0, name: "Nhận hàng có FF", link: ""),
    // ListMenuFeature(id: 1, name: "Nhận hàng FF", link: ""),
    ListMenuFeature(id: 2, name: "Putaway", link: Routes.PUTAWAY_PAGE),
    ListMenuFeature(
        id: 3, name: "Move Product", link: Routes.MOVE_PRODUCT_PAGE),
    // ListMenuFeature(id: 4, name: "Xuất hàng có FF", link: ""),
    // ListMenuFeature(id: 5, name: "Xuất hàng không FF", link: ""),
  ];
}
