import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scaner_tbslogistics/app/config/constants/constants.dart';
import 'package:scaner_tbslogistics/app/config/share_prefenreences/share_prefenrences.dart';
import 'package:scaner_tbslogistics/app/pages/cargo_team/model/list_check_model.dart';

class PutawayController extends GetxController {
  TextEditingController bkController = TextEditingController();
  TextEditingController lwhController = TextEditingController();

  Rx<ListCheckModel> checkTeam = ListCheckModel().obs;
  RxString pages = "".obs;

  String scannerQrCode = "";

  @override
  void onInit() {
    var items = Get.arguments[0] as ListCheckModel;
    checkTeam.value = items;
    var items1 = Get.arguments[1];
    pages.value = items1;

    super.onInit();
  }

  void postTeamCheck({
    required String bk,
    required String lwh,
  }) async {
    var dio = Dio();
    Response response;

    var listCheck = ListCheckModel(
      contnhap: checkTeam.value.contnhap,
      recscanner: checkTeam.value.recscanner,
      xn1: checkTeam.value.xn1,
      cn1: checkTeam.value.cn1,
      cn2: checkTeam.value.cn2,
      bk: bk,
      lwh: lwh,
    );
    var jsonData = listCheck.toJson();

    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    var url = "${AppConstants.urlBase}/team-make-goods/update-putaway";

    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonData,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        if (data["status_code"] == 200) {
          lwhController.text = "";
          getSnack(messageText: data["detail"]);
        } else {
          getSnack(messageText: data["detail"]);
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(messageText: "Lỗi dữ liệu !");
      } else if (e.response!.statusCode == 500) {
        getSnack(messageText: "Lỗi server, thử lại trong giây lát !");
      }
    }
  }

  Future<void> scanQr({required String idCode}) async {
    try {
      scannerQrCode = await FlutterBarcodeScanner.scanBarcode(
        "#FF6666",
        "Cancel",
        false,
        ScanMode.BARCODE,
      );
      switch (idCode) {
        case "BK":
          bkController.text = scannerQrCode;
          break;
        case "lwh":
          lwhController.text = scannerQrCode;
          break;

        default:
      }
    } on PlatformException catch (e) {
      print("Lỗi :  ${e.message}");
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
}
