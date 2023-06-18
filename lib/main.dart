import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scaner_tbslogistics/app/config/constants/constants.dart';
import 'package:scaner_tbslogistics/app/config/core/theme/theme_provider.dart';
import 'package:scaner_tbslogistics/app/config/routes/pages.dart';
import 'package:scaner_tbslogistics/app/pages/splash/splash_bindings.dart/splash_bindings.dart';
import 'package:scaner_tbslogistics/app/pages/splash/splash_page.dart';

void main() async {
  // HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init('MyStorage');
  final box = GetStorage('MyStorage');
  bool? mode = box.read(AppConstants.THEME_KEY);
  bool isLightMode = (mode != null && mode == "light");
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.light,
    theme: MyThemes.lightTheme,
    darkTheme: MyThemes.lightTheme,
    defaultTransition: Transition.fade,
    initialBinding: SplashBindings(),
    initialRoute: Routes.SPLASH,
    getPages: AppPages.pages,
    home: const SplashScreen(),
  ));
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
