import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/utils/providers.dart';
import 'package:movie/utils/shared_preference.dart';
import 'package:movie/utils/theme_data.dart';
import 'package:movie/views/home/home_screen.dart';
import 'package:movie/views/policy/policy.dart';
import 'package:provider/provider.dart';

void main() async{

  runZonedGuarded<Future<void>>(() async{
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    await SharedPreference.init();
    runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => Providers())
      ],
      child: App(),
      )
    );
  }, (error, stack) {
    print(error);
  }, zoneSpecification: new ZoneSpecification(
    print: (Zone self, ZoneDelegate parent, Zone zone, String message){
    if (kDebugMode) {
      parent.print(zone, message);
    }
  }));

}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    int themeMode = context.watch<Providers>().theme ?? 3;
    bool firstTime = context.watch<Providers>().firstTime ?? true;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode == 1 ? ThemeMode.light : themeMode == 2 ? ThemeMode.dark : ThemeMode.system,
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      home: firstTime == true ? Policy() : HomeScreen(),
    );
  }
}