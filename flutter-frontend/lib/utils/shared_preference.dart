import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
  static SharedPreferences _preference;

  static Future init() async{
    _preference = await SharedPreferences.getInstance();
  }

  static Future setString(key , value) async {
    await _preference.setString(key, value);
  }

  static String getString(key) {
    return _preference.getString(key);
  }

  static Future setBool(key , value) async {
    await _preference.setBool(key, value);
  }

  static bool getBool(key) {
    return _preference.getBool(key);
  }

  static Future setInt(key , value) async {
    await _preference.setInt(key, value);
  }

  static int getInt(key) {
    return _preference.getInt(key);
  }

  static dynamic clearData(){
    return _preference.clear();
  }
  
  static dynamic allData(){
    return _preference.getKeys();
  }

  static Future removeData(key){
    return _preference.remove(key);
  }
}