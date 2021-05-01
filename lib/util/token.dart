import 'package:hackathon_panel/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Utils? _instance;
  static Utils get instance => _instance ??= Utils();

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    AppConstants.instance.token = token;
    await prefs.setString('token', token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    AppConstants.instance.token = token;
    return token;
  }
}
