import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static String valueSharedPrefrences = '';

// Write DATA
  static Future<bool> saveUserData(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(valueSharedPrefrences, value);
  }

// Read Data
  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(valueSharedPrefrences);
  }
}
