import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart' hide Response;
import 'package:scaner_tbslogistics/app/config/constants/constants.dart';
import 'package:scaner_tbslogistics/app/config/share_prefenreences/share_prefenrences.dart';
import 'package:scaner_tbslogistics/app/pages/cargo_team/model/list_check_model.dart';

class CargoTeamController extends GetxController {
  TextEditingController typeCar = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController typeCarClient = TextEditingController();
  TextEditingController CN1 = TextEditingController();
  TextEditingController CN2 = TextEditingController();

  Rx<ListCheckModel> checkTeam = ListCheckModel().obs;

  String scannerQrCode = "";
  RxString scanner = "".obs;

  RxString pages = "".obs;
  @override
  void onInit() {
    var items = Get.arguments;
    pages.value = items;
    super.onInit();
  }

  void postTeamCheck({
    // required String typeCar,
    required String job,
    required String typeCarClient,
    required String CN1,
    required String CN2,
  }) async {
    var dio = Dio();
    Response response;

    var listCheck = ListCheckModel(
      // contnhap: typeCar,
      recscanner: job,
      xn1: typeCarClient,
      cn1: CN1,
      cn2: CN2,
    );
    var jsonData = listCheck.toJson();

    var tokens = SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    var url = "${AppConstants.urlBase}/team-make-goods/check-team-goods";

    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonData,
      );
      if (response.statusCode == 200) {
        var data = response.data;

        if (data["status_code"] == 200) {
          checkTeam.value = ListCheckModel.fromJson(data["data"]);

          // getDialog();
          getSnack(messageText: data["detail"]);

          Get.toNamed(pages.value, arguments: [
            checkTeam.value,
            pages.value,
          ]);
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
        case "CONTNHAP":
          typeCar.text = scannerQrCode;
          break;
        case "RESCANNER":
          job.text = scannerQrCode;
          break;
        case "XN1":
          typeCarClient.text = scannerQrCode;
          break;
        case "CN1":
          CN1.text = scannerQrCode;
          break;
        case "CN2":
          CN2.text = scannerQrCode;
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
    Future.delayed(Duration(seconds: 1), () {
      Get.back();
    });
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
