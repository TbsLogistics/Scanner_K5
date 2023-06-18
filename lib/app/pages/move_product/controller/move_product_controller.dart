import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:scaner_tbslogistics/app/config/constants/constants.dart';
import 'package:scaner_tbslogistics/app/config/share_prefenreences/share_prefenrences.dart';
import 'package:scaner_tbslogistics/app/pages/move_product/model/move_product_model.dart';

class MoveProductController extends GetxController {
  TextEditingController bkController = TextEditingController();
  TextEditingController lwhFromController = TextEditingController();
  TextEditingController lwhToController = TextEditingController();
  RxString listLocationFrom = "".obs;
  String scannerQrCode = "";
  RxList<DropdownMenuItem<String>> listLocation =
      <DropdownMenuItem<String>>[].obs;
  String? titleDropbutton;
  // Rx<String?>? titleDropbuttonSelected;

  RxBool isLoadList = false.obs;
  @override
  void getBk({required String bk}) async {
    var dio = Dio();
    Response response;
    // var tokens = SharePerApi().getToken();
    // Map<String, dynamic> headers = {
    //   HttpHeaders.authorizationHeader: "Bearer $tokens",
    // };
    var url = "${AppConstants.urlBase}/team-make-goods/local-booking/$bk";

    isLoadList(false);
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        var data = response.data;

        if (data["status_code"] == 200) {
          List listData = response.data["data"];
          listLocation.value = [];

          listLocationFrom.value = listData.toString();
          for (var i = 0; i < listData.toList().length; i++) {
            var items = listData.toList()[i];
            listLocation.value.add(
              DropdownMenuItem(
                value: "$items",
                child: Text("$items"),
              ),
            );
          }

          if (listLocation.value.isEmpty) {
            getSnack(messageText: "Không tồn tại vị trí của Booking !");
          } else {
            getSnack(messageText: "Lấy thông tin booking thành công !");
          }
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        getSnack(messageText: "Lỗi !");
      } else if (e.response!.statusCode == 500) {
        getSnack(messageText: "Lỗi !");
      }
      print([e.response!.statusCode, e.response!.statusMessage]);
    } finally {
      Future.delayed(Duration(seconds: 1), () {
        isLoadList(true);
      });
    }
  }

  void postTeamCheck({
    required String bk,
    required String lwhfrom,
    required String lwhto,
    required int type,
  }) async {
    var dio = Dio();
    Response response;

    var listCheck = MoveProductModel(
      bk: bk,
      form: lwhfrom,
      to: lwhto,
      type: type,
    );
    var jsonData = listCheck.toJson();

    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens",
    };
    var url = "${AppConstants.urlBase}/team-make-goods/move-goods";

    try {
      response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonData,
      );
      if (response.statusCode == 200) {
        var data = response.data;

        if (data["status_code"] == 200) {
          listLocation.value = [];
          bkController.text = "";
          lwhFromController.text = "";
          lwhToController.text = "";
          titleDropbutton = null;
          getSnack(messageText: data["detail"]);
        } else {
          getSnack(messageText: data["detail"]);
        }
      }
    } on DioError catch (e) {
      print(e.response!.statusCode);
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
          listLocation.value;
          getBk(bk: bkController.text);

          break;
        case "lwhF":
          lwhFromController.text = scannerQrCode;
          break;
        case "lwhT":
          lwhToController.text = scannerQrCode;
          break;

        default:
      }
    } on PlatformException catch (e) {
      print("Lỗi :  ${e.message}");
    }
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
