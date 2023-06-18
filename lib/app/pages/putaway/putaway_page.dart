import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/config/routes/pages.dart';
import 'package:scaner_tbslogistics/app/config/widgets/custom_text_form_field.dart';
import 'package:scaner_tbslogistics/app/config/widgets/text_button_cofirm.dart';
import 'package:scaner_tbslogistics/app/pages/putaway/controller/putaway_controller.dart';

class PutawayPage extends GetView<PutawayController> {
  const PutawayPage({super.key});

  final String routes = "/PUTAWAY_PAGE";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "PutAway",
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
      body: GetBuilder<PutawayController>(
        init: PutawayController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFormFiels(
                keyboardType: TextInputType.text,
                controller: controller.bkController,
                hintText: "",
                iconRight: Icons.qr_code_2_outlined,
                color: Colors.green,
                onPressedIcon: () {
                  controller.scanQr(idCode: "BK");
                },
                title: 'Booking',
              ),
              CustomFormFiels(
                keyboardType: TextInputType.text,
                controller: controller.lwhController,
                hintText: "",
                iconRight: Icons.qr_code_2_outlined,
                color: Colors.green,
                onPressedIcon: () {
                  controller.scanQr(idCode: "lwh");
                },
                title: 'Location',
              ),
              const SizedBox(height: 15),
              ButtonFormSubmit(
                  onPressed: () {
                    _postCheck(context, controller);
                  },
                  text: "Confirm")
            ],
          ),
        ),
      ),
    );
  }

  void _postCheck(BuildContext context, PutawayController controller) {
    print([controller.bkController.text, controller.lwhController.text]);
    if (controller.bkController.text.isEmpty ||
        controller.lwhController.text.isEmpty) {
      controller.getSnack(messageText: "Nhập thiếu thông tin !");
    } else {
      controller.postTeamCheck(
        bk: controller.bkController.text,
        lwh: controller.lwhController.text,
      );
    }
  }
}
