import 'package:get/get.dart';
import 'package:scaner_tbslogistics/app/pages/cargo_team/cargo_team_page.dart';
import 'package:scaner_tbslogistics/app/pages/home/home_page.dart';
import 'package:scaner_tbslogistics/app/pages/login/login_page.dart';
import 'package:scaner_tbslogistics/app/pages/move_product/move_product_page.dart';
import 'package:scaner_tbslogistics/app/pages/putaway/putaway_page.dart';
import 'package:scaner_tbslogistics/app/pages/splash/splash_page.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.HOME_PAGE,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.PUTAWAY_PAGE,
      page: () => PutawayPage(),
    ),
    GetPage(
      name: Routes.MOVE_PRODUCT_PAGE,
      page: () => MoveProductPage(),
    ),
    GetPage(
      name: Routes.CARGO_TEAM_PAGE,
      page: () => CargoTeamPage(),
    ),
  ];
}
