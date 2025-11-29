import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/app/modules/aboutscreenpage/controllers/aboutscreenpage_controller.dart';
import 'package:foodapp/app/modules/addcartpageviews/controllers/addcartpageviews_controller.dart';
import 'package:foodapp/app/modules/drawerpage/controllers/drawerpage_controller.dart';
import 'package:foodapp/app/modules/favouritepageview/controllers/favouritepageview_controller.dart';
import 'package:foodapp/app/modules/googlepageview/controllers/googlepageview_controller.dart';
import 'package:foodapp/app/modules/helpsupportpage/controllers/helpsupportpage_controller.dart';
import 'package:foodapp/app/modules/myorderpage/controllers/myorderpage_controller.dart';
import 'package:foodapp/app/modules/notificationspage/controllers/notificationspage_controller.dart';
import 'package:foodapp/app/modules/onboardingscreen/controllers/onboardingscreen_controller.dart';
import 'package:foodapp/app/modules/orderconfrompageview/controllers/orderconfrompageview_controller.dart';
import 'package:foodapp/app/modules/profilescreenpage/controllers/profilescreenpage_controller.dart';
import 'package:foodapp/themes/ThemeController%20.dart';
import 'package:foodapp/themes/app_theme.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/orderhistorypage/controllers/orderhistorypage_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => MyorderpageController(), fenix: true);
  Get.lazyPut(() => ProfilescreenpageController(), fenix: true);
  Get.lazyPut(() => ThemeController(), fenix: true);
  Get.lazyPut(() => DrawerpageController(), fenix: true);
  Get.lazyPut(() => AddcartpageviewsController(), fenix: true);
  Get.lazyPut(() => FavouritepageviewController(), fenix: true);
  Get.lazyPut(() => AboutpageController(), fenix: true);
  Get.lazyPut(() => GooglepageviewController(), fenix: true);
  Get.lazyPut(() => OrderconfrompageviewController(), fenix: true);
  Get.lazyPut(() => NotificationspageController(), fenix: true);
  Get.lazyPut(() => OnboardingscreenController(), fenix: true);
  Get.lazyPut(() => GooglepageviewController(), fenix: true);
  Get.lazyPut(() => HelpsupportpageController(), fenix: true);
  Get.lazyPut(() => OrderhistorypageController(), fenix: true);
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        navigatorObservers: [GetObserver()],

        debugShowCheckedModeBanner: false,
        title: "Food App",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.theme,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
