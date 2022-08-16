import 'dart:convert';

import 'package:http/http.dart'as http;


import 'package:get/get.dart';
import 'package:shop_udeny/api/api_settings.dart';
import 'package:shop_udeny/main.dart';
import 'package:shop_udeny/models/logout_models.dart';
import 'package:shop_udeny/storage/shared_pref_controller.dart';

class LogoutController extends GetxController{
  LogoutModels? logoutModels;
  int? logoutId;
  @override
  onInit() async {
    super.onInit();
    logout(logoutId!);
  }

  logout(int logoutId) async{
    var url=Uri.parse(ApiSettings.getlogout);
    var response=await http.post(url,headers: {
      "Content-Type": "application/json",
      "authorization": prefController.getValueFor<String>(key: PrefKeys.token.name)!,
    },body: jsonEncode({"id": logoutId}));

    if(response.statusCode==200){
      await SharedPrefController().clear();
      logoutModels=LogoutModels.fromJson(json.decode(response.body));
      update();

    }
  }


}