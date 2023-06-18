import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/config/routes/pages.dart';
import 'package:scaner_tbslogistics/app/pages/drawer/drawer_page.dart';
import 'package:scaner_tbslogistics/app/pages/home/home_controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  final String routes = "/HOME_PAGE";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Obx(() {
            print(controller.isLoad.value);
            return controller.isLoad.value
                ? Text(
                    controller.userInfo.value.tennv!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )
                : Container(
                    height: 20,
                    width: 120,
                    color: Colors.grey,
                  );
          }),
          centerTitle: true,

          // leading: IconButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   icon: const Icon(
          //     Icons.arrow_back_ios_new_outlined,
          //   ),
          // ),
        ),
        drawer: const Drawer(
          child: DrawerScreen(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              mainAxisExtent: 170,
            ),
            itemCount: controller.listMenu.length,
            itemBuilder: (_, i) {
              return Card(
                shadowColor: Colors.grey,
                elevation: 10,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: controller.listMenu[i].link != ""
                        ? Colors.white
                        : Colors.orangeAccent,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: controller.listMenu[i].link != ""
                    ? InkWell(
                        onTap: () {
                          if (controller.listMenu[i].link ==
                              "/MOVE_PRODUCT_PAGE") {
                            Get.toNamed(Routes.MOVE_PRODUCT_PAGE);
                          } else {
                            Get.toNamed(
                              Routes.CARGO_TEAM_PAGE,
                              arguments: controller.listMenu[i].link,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "${controller.listMenu[i].name}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    // :Container()
                    : InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "${controller.listMenu[i].name}",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
