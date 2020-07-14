import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences{
  SharedPreferences sharedPreferences;

  setUserId(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', value);
  }

  getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
  }

  clearUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("userId");
  }
}