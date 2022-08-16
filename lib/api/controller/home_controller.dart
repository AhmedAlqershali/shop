import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shop_udeny/api/api_settings.dart';
import 'package:shop_udeny/models/home_models.dart';
import 'package:shop_udeny/storage/shared_pref_controller.dart';
import 'package:shop_udeny/utils/api_helper.dart';

import '../../main.dart';

class HomeController extends GetxController with ApiHelper {
  HomeModels? homeModels;

  // Map<int, bool> fav = {};

  @override
  onInit() async {
    super.onInit();
    setData();
  }

  setData() async {
    var url = Uri.parse(ApiSettings.getHome);

    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "authorization": prefController.getValueFor<String>(key: PrefKeys.token.name)!,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      homeModels = HomeModels.fromJson(json.decode(response.body));
      update();
    }
    // homeModels!.data!.products!.forEach((element) {
    //   fav.addAll({element.id!: element.inFavorites!});
    //   print(fav.toString());
    // });
  }
}
