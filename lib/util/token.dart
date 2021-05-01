import 'package:hackathon_panel/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Constants.token = token;
    prefs.setString('token', token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    Constants.token = token;
    return token;
  }
}
