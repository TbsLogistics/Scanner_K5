// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/config/widgets/custom_text_form_field.dart';
import 'package:scaner_tbslogistics/app/config/widgets/text_button_cofirm.dart';
import 'package:scaner_tbslogistics/app/pages/move_product/controller/move_product_controller.dart';

class MoveProductPage extends GetView<MoveProductController> {
  const MoveProductPage({super.key});

  final String routes = "/MOVE_PRODUCT_PAGE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Move Product",
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
      body: GetBuilder<MoveProductController>(
        init: MoveProductController(),
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFormFiels(
                  title: "Booking",
                  keyboardType: TextInputType.text,
                  controller: controller.bkController,
                  hintText: "",
                  iconRight: Icons.qr_code_2_outlined,
                  color: Colors.green,
                  onPressedIcon: () {
                    controller.scanQr(idCode: "BK");
                  },
                  onFieldSubmitted: (value) {
                    controller.getBk(bk: value);
                  },
                  textInputAction: TextInputAction.done,
                ),

                // DropdownButton(
                //   value: controller.selectedValue,
                //   onChanged: (items) {},
                //   items: controller.dropdownItems,
                // ),
                CustomFormFiels(
                  title: "Từ vị trí",
                  keyboardType: TextInputType.text,
                  controller: controller.lwhFromController,
                  hintText: "",
                  iconRight: Icons.qr_code_2_outlined,
                  color: Colors.green,
                  onPressedIcon: () {
                    controller.scanQr(idCode: "lwhF");
                  },
                  titleRight: Obx(() {
                    return controller.isLoadList.value
                        ? controller.listLocation.value == null ||
                                controller.listLocation.value.isEmpty
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.orangeAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 30,
                                width: 70,
                                padding: const EdgeInsets.only(left: 5),
                                child: DropdownButtonHideUnderline(
                                  child: Obx(() {
                                    return DropdownButton(
                                      hint: const Text(
                                        "Vị trí",
                                        style: TextStyle(
                                          color: Colors.orangeAccent,
                                        ),
                                      ),
                                      value: controller.titleDropbutton,
                                      onChanged: (String? items) {
                                        controller.titleDropbutton = items;
                                        controller.lwhFromController.text =
                                            items!;
                                        controller.update();
                                      },
                                      items: controller.listLocation.value,
                                    );
                                  }),
                                ),
                              )
                        : Container();
                  }),
                ),
                CustomFormFiels(
                  title: "Đến vị trí",
                  keyboardType: TextInputType.text,
                  controller: controller.lwhToController,
                  hintText: "",
                  iconRight: Icons.qr_code_2_outlined,
                  color: Colors.green,
                  onPressedIcon: () {
                    controller.scanQr(idCode: "lwhT");
                  },
                ),
                const SizedBox(height: 15),
                ButtonFormSubmit(
                  onPressed: () {
                    _postCheckOne(context, controller);
                  },
                  text: "Move one",
                ),
                const SizedBox(height: 15),
                ButtonFormSubmit(
                  onPressed: () {
                    _postCheckAll(context, controller);
                  },
                  text: "Move all",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _postCheckOne(BuildContext context, MoveProductController controller) {
    if (controller.bkController.text.isEmpty ||
        controller.lwhFromController.text.isEmpty ||
        controller.lwhToController.text.isEmpty) {
      controller.getSnack(messageText: "Nhập thiếu thông tin !");
    } else {
      controller.postTeamCheck(
        bk: controller.bkController.text,
        lwhfrom: controller.lwhFromController.text,
        lwhto: controller.lwhToController.text,
        type: 0,
      );
    }
  }

  void _postCheckAll(BuildContext context, MoveProductController controller) {
    if (controller.bkController.text.isEmpty ||
        controller.lwhFromController.text.isEmpty ||
        controller.lwhToController.text.isEmpty) {
      controller.getSnack(messageText: "Nhập thiếu thông tin !");
    } else {
      controller.postTeamCheck(
        bk: controller.bkController.text,
        lwhfrom: controller.lwhFromController.text,
        lwhto: controller.lwhToController.text,
        type: 1,
      );
    }
  }
}
