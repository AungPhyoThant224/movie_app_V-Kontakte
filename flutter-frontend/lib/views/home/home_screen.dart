import 'package:flutter/material.dart';
import 'package:movie/models/response_model.dart';
import 'package:movie/presenter/service.dart';
import 'package:movie/views/about/about.dart';
import 'package:movie/views/widgets/cache_image.dart';
import 'package:movie/views/widgets/loading.dart';
import 'package:movie/views/detail/detail_screen.dart';
import 'package:movie/views/more_lists/more_lists.dart';
import 'package:movie/views/search/search.dart';
import 'package:movie/views/widgets/image_slider.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Service service = Service();
  List popular;
  List newest;
  List categroy;
  List ads;
  bool firstTime = true;

  @override
  void initState() {
    super.initState();
    getIndex();
  }

  getIndex() async{
    ResponseModel resData = await service.getIndex("1.0.1");
    if(resData.status == 200){
      if(resData.data.notification == null || resData.data.notification == {} || resData.data.notification == ''){
        popular = resData.data.popular;
        newest = resData.data.newest;
        categroy = resData.data.category;
        ads = resData.data.ads;
      }
      else{
        if(firstTime == true){
          loading(context, 3, null, null, notification: resData.data.notification);
          firstTime = false;
        }
        popular = resData.data.popular;
        newest = resData.data.newest;
        categroy = resData.data.category;
        ads = resData.data.ads;
      }
    }
    else{
      loading(context, 1, 'Home', 'Something went wrong. Please try again.');
    }
    setState(() {});
  }

  Future getIndexOnRefresh() async{
    await getIndex();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon : Icon(Icons.info_outline),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return About();
            }));
          }
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Movie',
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontFamily: 'FiraSans',
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
            Container(
              child: IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return Search();
                }));
              },
            ),
            )
          ],
      ),
      body: popular == null && newest == null && categroy == null
      ? SafeArea(
        child: Loading( 0, null, null)
      )
      :SafeArea(
        child: RefreshIndicator(
          onRefresh: getIndexOnRefresh,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 16.0,),
                    imageSlider(context, ads),
                    SizedBox(height: 24.0),
                    _buildWidgetCategories(mediaQuery, categroy),
                    SizedBox(height: 24.0),
                    _buildWidgetList(mediaQuery, context, newest, 'Newest'),
                    SizedBox(height: 16.0),
                    _buildWidgetList(mediaQuery, context, popular, 'Popular'),
                    SizedBox(height: 24.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetCategories(MediaQueryData mediaQuery, List listCategories) {

    return Container(
      width: mediaQuery.size.width,
      height: 60.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: index == listCategories.length - 1 ? 16.0 : 0.0,
            ),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context){
                    return MoreList(
                      type: 'Category',
                      url: listCategories[index]['id'],
                    );
                  }
                ));
              },
              child: Container(
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: const Offset(
                        2.0,
                        2.0,
                      ),
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.black45 : Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                      listCategories[index]['image'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Color(0xFF787878)
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        listCategories[index]['name'],
                        style: Theme.of(context).textTheme.body1.merge(
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'FiraSans'
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: listCategories.length,
      ),
    );
  }

  Widget _buildWidgetList(MediaQueryData mediaQuery, BuildContext context, List posterList, String title) {

    return Container(
      width: mediaQuery.size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MoreList(
                      type: title,
                    );
                  }
                ));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: 'FiraSans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 230.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async{
                    var returnData = await Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DetailScreen(
                          posterList[index],
                          'home'
                        );
                      },
                    ));
                    if(returnData != null){
                      posterList[index] = returnData;
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5.0,
                      right: index == posterList.length - 1 ? 5.0 : 0.0,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            child: cacheImage(
                              context, 
                              posterList[index]['image'],
                              height: 230,
                              width: 130,
                              borderRadius: 8.0
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: posterList.length,
            ),
          ),
        ],
      ),
    );
  }
}
