import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_udeny/models/users_model.dart';

enum PrefKeys { id, name, image, email, token,phone,points,credit}

class SharedPrefController {
  static final SharedPrefController _instance = SharedPrefController._();
  late SharedPreferences _sharedPreferences;

  SharedPrefController._();

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required UsersModel usersModel}) async {
    await _sharedPreferences.setInt(PrefKeys.id.name, usersModel.id!);
    await _sharedPreferences.setString(PrefKeys.name.name, usersModel.name!);
    await _sharedPreferences.setString(PrefKeys.image.name, usersModel.image!);
    await _sharedPreferences.setString(PrefKeys.email.name, usersModel.email!);
    await _sharedPreferences.setString(PrefKeys.phone.name, usersModel.phone!);
    await _sharedPreferences.setInt(PrefKeys.points.name, usersModel.points!);
    await _sharedPreferences.setInt(PrefKeys.credit.name, usersModel.credit!);
    await _sharedPreferences.setString(PrefKeys.token.name,  usersModel.token!);
  }

  T? getValueFor<T>({required String key}) {
    return _sharedPreferences.get(key) as T?;
  }

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}