import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_udeny/api/api_settings.dart';
import 'package:shop_udeny/main.dart';
import 'package:shop_udeny/models/favorite_models.dart';
import 'package:shop_udeny/storage/shared_pref_controller.dart';
import 'package:shop_udeny/utils/api_helper.dart';

class FavoritesController extends GetxController with ApiHelper {
  FavoritesModels? favoritesModels;
  @override
  onInit() async {
    super.onInit();
    getFavourite();

  }

  setfavoriteOn(int productId) async {
    var url = Uri.parse(ApiSettings.getFavorites);
    var response = await http.post(url,
        headers: headers, body: json.encode({"product_id": productId}));
    if (response.statusCode == 200) {
      printInfo(info: "Add to favourite done successfuly");
      printInfo(info: "body is : ${response.body} + productID: $productId");
    }
  }

  setFavouriteOf(int id) async {
    var url = Uri.parse(ApiSettings.getFavorites + "/$id");
    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      printInfo(info: "Delete to favourite done successfuly");
    }
  }



  getFavourite()async{
    var url = Uri.parse(ApiSettings.getFavorites);
    var response = await http.get(url,headers: {
      "Content-Type": "application/json",
      "authorization": prefController.getValueFor<String>(key: PrefKeys.token.name)!,
    });
    if(response.statusCode ==200){
      var jsonResponse = jsonDecode(response.body);
      favoritesModels=FavoritesModels.fromJson(json.decode(response.body));
      update();
    }


  }
}
