import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_udeny/api/controller/categories_controller.dart';
import 'package:shop_udeny/api/controller/favorites_controller.dart';
import 'package:shop_udeny/api/controller/profile_controller.dart';
import 'package:shop_udeny/screens/bn_screen.dart';
import 'package:shop_udeny/screens/login.dart';
import 'package:shop_udeny/screens/rigeter_screen.dart';
import 'package:shop_udeny/storage/shared_pref_controller.dart';

import 'api/controller/home_controller.dart';

SharedPrefController prefController = SharedPrefController();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await prefController.initPref();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.put(HomeController()); /*---*/
    /* هدول الشغلات ضروري تعملهم عشان تعرف تستخدمهم */
    Get.put(CategoriesController()); /*---*/
    Get.put(FavoritesController()); /*---*/
    Get.put(ProfileController()); /*---*/

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/loginScreen': (context) => LoginScreen(),
        '/rigesterScreen': (context) => RigesterScreen(),
        '/bnScreen': (context) => BnScreen(),
      },
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}
