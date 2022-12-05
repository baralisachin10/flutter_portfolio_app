import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  storeInformation(String data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("PersonalInfo", data);
  }

  Future<String> getInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("PersonalInfo") ?? "";
  }

  static Future clearInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
