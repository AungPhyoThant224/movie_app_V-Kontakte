import 'package:flutter/material.dart';
import 'package:movie/models/about_model.dart';
import 'package:movie/models/response_model.dart';
import 'package:movie/presenter/service.dart';
import 'package:movie/views/widgets/app_bar.dart';
import 'package:movie/views/widgets/cache_image.dart';
import 'package:movie/views/widgets/loading.dart';
import 'package:movie/views/widgets/url_launch.dart';
import 'package:share_plus/share.dart';

class About extends StatefulWidget {

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

  Service service = Service();
  ResponseModel resData;
  AboutResponseModel aboutData;

  @override
  void initState() {
    super.initState();
    getAbout();
  }

  getAbout() async{
    resData = await service.getAbout();
    if(resData.status == 200){
      aboutData = resData.data;
      setState(() { });
    }
    else{
      loading(context, 1, 'About', 'Something went wrong. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(context, 'About Us'),
      body: resData != null ? SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Column(
              children: [
                Text(
                  aboutData.name,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    fontFamily: 'FiraSans',
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  height: 100,
                  width: 100,
                  child: cacheImage(context, aboutData.logo, borderRadius: 100, boxfit: BoxFit.cover),
                ),
                Text(
                  aboutData.about,
                  style: TextStyle(
                    fontFamily: 'FiraSans',
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 50,
                        // width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: (){
                            customLaunch(aboutData.contact, '5');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: Theme.of(context).primaryColor
                            ),
                            child: Center(
                              child: Text(
                                "Contact Us",
                                style: TextStyle(
                                  fontFamily: 'FiraSans',
                                  color: Theme.of(context).brightness == Brightness.dark ? Color(0xFF2C3333) : Color(0xFFFFFFFF)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 50,
                        // width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () async{
                            await Share.share(aboutData.downloadLink);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: Theme.of(context).primaryColor
                            ),
                            child: Center(
                              child: Text(
                                "Shared Download Link",
                                style: TextStyle(
                                  fontFamily: 'FiraSans',
                                  color: Theme.of(context).brightness == Brightness.dark ? Color(0xFF2C3333) : Color(0xFFFFFFFF)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ): Loading(0, null, null),
    );
  }
}