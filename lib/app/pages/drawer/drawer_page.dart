// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/config/share_prefenreences/share_prefenrences.dart';
import 'package:scaner_tbslogistics/app/pages/home/home_controller/home_controller.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var now = DateTime.now();
    // var a = DateFormat("a");
    // var hour = DateFormat("HH");
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Container(
                  height: size.height * 0.25,
                  width: size.width,
                  color: Colors.orangeAccent.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                              width: size.height * 0.1,
                              child: const CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/images/avatar_private.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Họ và tên :  ${controller.userInfo.value.tennv}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Mã nhân viên :  ${controller.userInfo.value.manv}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    onTap: () async {
                      await SharePerApi().postLogout();
                    },
                    title: const Text(
                      "Đăng xuất",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: const Icon(
                      Icons.logout_outlined,
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     Get.toNamed(
                  //       Routes.CHANGE_PASSWORD__FULL_SCREEN,
                  //       arguments: controller.user.value.userName,
                  //     );
                  //   },
                  //   title: const Text(
                  //     "Đổi mật khẩu",
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   leading: const Icon(
                  //     Icons.lock_outlined,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
