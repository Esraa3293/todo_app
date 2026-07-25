// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefs {
//   static late SharedPreferences prefs;
//
//   static Future<void> init() async {
//     prefs = await SharedPreferences.getInstance();
//   }
//
//   static Future<void> setLogin(String logged) async {
//     await prefs.setString("logged", logged);
//   }
//
//   static String getLogin() {
//     return prefs.getString("logged") ?? "logout";
//   }
// }
