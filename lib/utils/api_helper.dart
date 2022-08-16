import 'dart:io';

import 'package:get/get.dart';
import 'package:shop_udeny/storage/shared_pref_controller.dart';

import '../api/controller/home_controller.dart';
import '../main.dart';

mixin ApiHelper {
  Map<String, String> get headers {
    return {
      HttpHeaders.authorizationHeader:
          prefController.getValueFor<String>(key: PrefKeys.token.name)!,
      HttpHeaders.acceptHeader: "application/json", "Content-Type": "application/json"

    };
  }
}
