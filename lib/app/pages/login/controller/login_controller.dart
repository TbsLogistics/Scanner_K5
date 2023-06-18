import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:scaner_tbslogistics/app/config/constants/constants.dart';
import 'package:scaner_tbslogistics/app/config/routes/pages.dart';
import 'package:scaner_tbslogistics/app/pages/login/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  late Response response;
  var dio = Dio();

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool obcureText = true.obs;

  void updateObcureText() {
    obcureText.value = !obcureText.value;
    update();
  }

  Future<void> postLoginTms(
      {required String account, required String password}) async {
    var login = LoginModel(
      username: account,
      password: password,
    );
    var jsonData = login.toJson();
    const url = "${AppConstants.urlBase}/login";
    print(url);

    try {
      response = await dio.post(
        url,
        data: jsonData,
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var data = response.data;

        if (data["status_code"] == 204) {
          // ignore: unused_local_variable
          getSnack(messageText: data["detail"]);
        } else {
          var access_token_tms = await prefs.setString(
            AppConstants.KEY_ACCESS_TOKEN,
            data["access_token"],
          );

          Map<String, dynamic> decodedToken =
              JwtDecoder.decode(data["access_token"]);
          getDialog();
          getSnack(messageText: "Đăng nhập thành công !");
          Future.delayed(const Duration(seconds: 1), () {
            Get.toNamed(Routes.HOME_PAGE);
          });
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(messageText: "Lỗi !");
      } else if (e.response!.statusCode == 500) {
        getSnack(messageText: "Lỗi !");
      }
    }
  }

  void getDialog() {
    Get.defaultDialog(
      title: "Loading",
      titleStyle: const TextStyle(
        color: Colors.orangeAccent,
      ),
      confirm: CircularProgressIndicator(
        color: Colors.orangeAccent.withOpacity(0.7),
      ),
      middleText: "",
      textConfirm: null,
      confirmTextColor: Colors.orangeAccent,
      backgroundColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
      buttonColor: Colors.orangeAccent.withOpacity(0.4),
    );
  }

  void getSnack({required String messageText}) {
    Get.snackbar(
      "",
      "",
      titleText: const Text(
        "Thông báo",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        messageText,
        style: const TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    accountController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
