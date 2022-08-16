import 'dart:convert' as c;
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_udeny/api/api_settings.dart';
import 'package:shop_udeny/api/controller/home_controller.dart';
import 'package:shop_udeny/models/api_response.dart';
import 'package:shop_udeny/models/users_model.dart';

import '../../main.dart';

class UsersController {
  Future<ApiResponse> login(
      {required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.login);
    printInfo(info: "email: $email, password: $password");
    var response = await http.post(url,
        headers: {"Accept": "*/*", 'Content-Type': 'application/json'},
        body: c.json.encode({'email': email, 'password': password}));
    if (response.statusCode == 200) {
      printInfo(info: "body is : ${response.body}");
      var jsonResponse = c.jsonDecode(response.body);
      var jsonObject = jsonResponse['data'];
      // UsersModel.fromJson(jsonObject);

      await prefController.save(
          usersModel: UsersModel.fromJson(jsonResponse["data"]));

      return ApiResponse(
          status: jsonResponse['status'], message: jsonResponse['message']);
    } else {
      return ApiResponse(
          status: false, message: 'Something went wrong , try again');
    }
  }




}
