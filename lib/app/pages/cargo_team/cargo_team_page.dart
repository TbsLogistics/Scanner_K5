import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/config/data/validate.dart';
import 'package:scaner_tbslogistics/app/config/widgets/custom_text_form_field.dart';
import 'package:scaner_tbslogistics/app/config/widgets/text_button_cofirm.dart';
import 'package:scaner_tbslogistics/app/pages/cargo_team/controller/cargo_team_controller.dart';

class CargoTeamPage extends GetView<CargoTeamController> {
  const CargoTeamPage({super.key});

  final String routes = "/CARGO_TEAM_PAGE";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Team làm hàng",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
      ),
      body: GetBuilder<CargoTeamController>(
        init: CargoTeamController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CustomFormFiels(
                //   keyboardType: TextInputType.text,
                //   controller: controller.typeCar,
                //   hintText: "XE TẢI/CONT",
                //   iconRight: Icons.qr_code_2_outlined,
                //   color: Colors.green,
                //   onPressedIcon: () {
                //     controller.scanQr(idCode: "CONTNHAP");
                //   },
                //   title: 'Nhập XE TẢI/CONT',
                //   // validator: (value) => Validate().check(value),
                // ),
                CustomFormFiels(
                  keyboardType: TextInputType.text,
                  controller: controller.job,
                  hintText: "Nhập tallyman",
                  iconRight: Icons.qr_code_2_outlined,
                  color: Colors.green,
                  onPressedIcon: () {
                    controller.scanQr(idCode: "RESCANNER");
                  },
                  title: "Tallyman",
                  // validator: (value) => Validate().check(value),
                ),
                CustomFormFiels(
                  keyboardType: TextInputType.text,
                  controller: controller.typeCarClient,
                  hintText: "Nhập xe nâng",
                  iconRight: Icons.qr_code_2_outlined,
                  color: Colors.green,
                  onPressedIcon: () {
                    controller.scanQr(idCode: "XN1");
                  },
                  title: "Xe nâng",
                  // validator: (value) => Validate().check(value),
                ),
                CustomFormFiels(
                  keyboardType: TextInputType.text,
                  controller: controller.CN1,
                  hintText: "Nhập công nhân",
                  iconRight: Icons.qr_code_2_outlined,
                  color: Colors.green,
                  onPressedIcon: () {
                    controller.scanQr(idCode: "CN1");
                  },
                  title: "Công nhân 1",
                  // validator: (value) => Validate().check(value),
                ),
                CustomFormFiels(
                  keyboardType: TextInputType.text,
                  controller: controller.CN2,
                  hintText: "Nhập công nhân",
                  iconRight: Icons.qr_code_2_outlined,
                  color: Colors.green,

                  onPressedIcon: () {
                    controller.scanQr(idCode: "CN2");
                  },
                  title: "Công nhân 2",
                  // validator: (value) =>
                  // Validate().checkCN2(controller.CN1.text, value),
                ),
                const SizedBox(height: 15),
                ButtonFormSubmit(
                  onPressed: () {
                    _postCheck(context, controller);
                  },
                  text: "Confirm",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _postCheck(BuildContext context, CargoTeamController controller) {
    if (
        // controller.typeCar.text.isEmpty ||
        controller.job.text.isEmpty ||
            controller.typeCarClient.text.isEmpty ||
            controller.CN1.text.isEmpty ||
            controller.CN2.text.isEmpty) {
      controller.getSnack(messageText: "Nhập thiếu thông tin !");
    } else {
      if (controller.CN1.text == controller.CN2.text) {
        controller.getSnack(messageText: "Trùng tên công nhân 1, 2");
      } else {
        controller.postTeamCheck(
          // typeCar: controller.typeCar.text,
          job: controller.job.text,
          typeCarClient: controller.typeCarClient.text,
          CN1: controller.CN1.text,
          CN2: controller.CN2.text,
        );
      }
    }
  }
}
