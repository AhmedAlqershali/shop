
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_udeny/api/api_settings.dart';
import 'package:shop_udeny/models/categories_models.dart';

import '../../utils/api_helper.dart';
import 'dart:convert';

class CategoriesController extends GetxController with ApiHelper{
 Rx <CategoriesModels>? categoriesModels;


  @override
  onInit() async {
    super.onInit();
    setCategory();
  }
  setCategory()async{
var url=Uri.parse(ApiSettings.getCategories);

var response= await http.get(url);

if(response.statusCode==200){
  categoriesModels = CategoriesModels.fromJson(json.decode(response.body)).obs;

}

  }





}


