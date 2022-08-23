import 'package:flutter/material.dart';
import 'package:movie/app_config/app_config.dart';
import 'package:movie/views/settings/settings.dart';

Widget sidebar(context){
  return Drawer(
    child: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.grey
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/movie_3_popular_backdrop_path.jpeg'),
                              fit: BoxFit.cover
                            )
                          ),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Text(
                          'Example',
                          style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Text(
                          'example@gmail.com',
                          style: TextStyle(
                            fontFamily: 'FiraSans',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.settings_outlined,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                      return Settings();
                    }));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.mail_outlined,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                    ),
                  ),
                  onTap: (){},
                ),
                Divider(),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'Version : $version',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontWeight: FontWeight.bold,
                    ),
                  )
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}