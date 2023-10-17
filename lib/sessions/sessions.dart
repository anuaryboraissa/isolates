import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SharedPreferences? sharedPreferences;

  Future<String?> get getAccessToken async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString("accessToken");
  }

  setAccessToken(String token) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString("accessToken", token);
  }

  Future<String?> get getRefreshToken async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString("refreshToken");
  }

  setRefreshToken(String token) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString("refreshToken", token);
  }

  Future<String?> get getLoginUsername async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString("username");
  }

  setLoginUserName(String username) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString("username", username);
  }
}
