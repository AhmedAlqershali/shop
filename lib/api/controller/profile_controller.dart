import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shop_udeny/api/api_settings.dart';
import 'package:shop_udeny/main.dart';
import 'package:shop_udeny/models/profile_models.dart';
import 'package:shop_udeny/models/users_model.dart';
import 'package:shop_udeny/storage/shared_pref_controller.dart';

class ProfileController extends GetxController{
  ProfileModels? profileModels;

  onInit() async {
    super.onInit();
    getProfile();

  }


  getProfile()async{
    var url=Uri.parse(ApiSettings.getProfile);
    var response=await http.get(url,headers: {
      "Content-Type": "application/json",
      "authorization": prefController.getValueFor<String>(key: PrefKeys.token.name)!,
    });

    if(response.statusCode==200){
      profileModels=ProfileModels.fromJson(json.decode(response.body));
      update();
    }

  }
  
  
  
}