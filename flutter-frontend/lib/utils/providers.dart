import 'package:flutter/material.dart';
import 'package:movie/utils/shared_preference.dart';

class Providers with ChangeNotifier{
  String get uuid => SharedPreference.getString('uuid');
  int get theme => SharedPreference.getInt('theme');
  String get recentSearch => SharedPreference.getString('recentSearch');
  bool get firstTime => SharedPreference.getBool('firstTime');

  int get count => SharedPreference.getInt('count');

  Future<void> setUuid(_uuid) async{
    await SharedPreference.setString('uuid', _uuid);
    notifyListeners();
  }

  Future<void> setTheme(_theme) async{
    await SharedPreference.setInt('theme', _theme);
    notifyListeners();
  }

  Future<void> setRecentSearch(_recentSearch) async{
    await SharedPreference.setString('recentSearch', _recentSearch);
    notifyListeners();
  }

  Future<void> setCount(_count) async{
    await SharedPreference.setInt('count', _count);
    notifyListeners();
  }

  Future<void> setFirstTime(_firstTime) async{
    await SharedPreference.setBool('firstTime', _firstTime);
    notifyListeners();
  }

}