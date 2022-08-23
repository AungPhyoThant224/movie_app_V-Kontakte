import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie/models/post_model.dart';
import 'package:movie/models/response_model.dart';
import 'package:movie/presenter/service.dart';
import 'package:movie/views/widgets/app_bar.dart';
import 'package:movie/views/detail/detail_screen.dart';
import 'package:movie/views/widgets/cache_image.dart';
import 'package:movie/views/widgets/image_slider.dart';
import 'package:movie/views/widgets/loading.dart';
import 'package:movie/views/widgets/url_launch.dart';

class MoreList extends StatefulWidget {
  final String type;
  final dynamic url;
  MoreList({this.type, this.url});
  @override
  State<MoreList> createState() => _MoreListState();
}

class _MoreListState extends State<MoreList> {

  String _type;
  dynamic _url;
  Service service = Service();
  ResponseModel resData;
  int oldListPosterLength;
  int nextPage = 1;
  int lastPage;
  int count = 0;

  List listPoster = [];
  List adsSlider = [];
  List adsGrid = [];

  ScrollController _scrollController = ScrollController();
  
  int loadCount = 0;
  double maxScroll = 0.0;

  @override
  void initState() {
    super.initState();
    _type = widget.type;
    _url = widget.url;
    getPosts();
    getNextPost();
  }

  Future getNextPost() async {
    _scrollController.addListener(() async {
      if(nextPage <= lastPage){
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent / 2 && !_scrollController.position.outOfRange) {
          loadCount++;
          if (loadCount == 1) {
            maxScroll = _scrollController.position.maxScrollExtent;
            getPosts();
          } else if (_scrollController.position.pixels >= maxScroll) {
            loadCount = 0;
          }
        }
      }
    });
  }

  getPosts()async{
    
    if(_type == 'Category'){
      print('cat');
      resData = await service.getCategory(_url, nextPage);
    }
    else if(_type == 'Search'){
      print('sec');
      resData = await service.getSearch(_url, nextPage);
    }
    else if(_type == 'Recent'){
      print('rec');
      resData = await service.getPopular(nextPage);
    }
    else if(_type == 'Newest'){
      print('new');
      resData = await service.getNewest(nextPage);
    }
    else if(_type == 'Popular'){
      print('pop');
      resData = await service.getPopular(nextPage);
    }
    
    if(resData.status == 200){
      if(nextPage == 1){
        listPoster = resData.data.data;
        for(int i = 0; i < listPoster.length; i++){
          if((i+1) % 5 == 0 && i != 0){
            listPoster.insert( i, listPoster[i]);
          }
        }
      }else{
        resData.data.data.forEach((_data){
          listPoster.add(_data);
        });
        for(int i = (oldListPosterLength-1); i < listPoster.length; i ++){
          if((i+1) % 5 == 0 && i != 0){
            listPoster.insert( i, listPoster[i]);
          }
        }
        count = 0;
      }
      adsGrid = resData.data.adsGrid;
      adsSlider = resData.data.adsSlider;
      nextPage = resData.data.currentPage + 1;
      lastPage = resData.data.lastPage;
      oldListPosterLength = listPoster.length;
      setState(() {});
    }
    else{
      loading(context, 1, '$_type', 'Something went wrong. Please try again.');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(context, _type),
      body: resData == null ? Loading( 0, null, null)
      : Container(
        child: resData.status == 200 && listPoster.length != 0 ? Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  imageSlider(context, adsSlider),
                  SizedBox(height: 16,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: widgetListPoster(),
                  ),
                  nextPage - 1 != lastPage ? Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: SpinKitThreeBounce(
                        color: Theme.of(context).primaryColor,
                        size: 28.0,
                      ),
                    ),
                  ): Container()
                ],
              ),
            )
          ),
        ):Center(
          child: Text(
            'No posts available.',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'FiraSans'
            ),
          ),
        ),
      )
    );
  }

  Widget widgetListPoster(){
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (_index) => StaggeredTile.count(1, 1.51),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: listPoster.length,
      itemBuilder: (context, index) {

        return index % 5 == 0 && index != 0 
        ? gridAds()
        :GestureDetector(
          onTap: () async{
            var returnData = await Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DetailScreen(
                  {
                    'id': listPoster[index].id,
                    'title': listPoster[index].title,
                    'url': listPoster[index].url,
                    'image': listPoster[index].image,
                    'duration': listPoster[index].duration,
                    'total_view': listPoster[index].totalView,
                    'description': listPoster[index].description,
                    'created_at': listPoster[index].createdAt,
                    'category' : listPoster[index].category,
                  },
                  'more'
                );
              },
            ));
            if(returnData != null){
              PostResponseModel newData = PostResponseModel(
                id: returnData['id'],
                title: returnData['title'],
                url: returnData['url'],
                image: returnData['image'],
                duration: returnData['duration'],
                totalView: int.parse(returnData['total_view']),
                description: returnData['description'],
                createdAt: returnData['created_at'],
                category: returnData['category'][0]['name'],
              );
              listPoster[index] = newData;
              setState(() {});
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  child: cacheImage(
                    context, listPoster[index].image, 
                    height: 230, borderRadius: 8.0
                  )
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Text(
                  listPoster[index].title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'FiraSans',
                    height: 1
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget gridAds(){

    int index = count;
    if(count < adsGrid.length){
      count = count + 1;
    }else{
      count = 0;
      index = count;
    }

    return adsGrid.length != 0 ? GestureDetector(
      onTap: (){
        customLaunch(adsGrid[index]['contact'], adsGrid[index]['ctype']);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
              child: cacheImage(
                context, 
                adsGrid[index]['info'], 
                height: 230, 
                boxfit: BoxFit.cover, 
                borderRadius: 8.0
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Text(
              "Ads : ${adsGrid[index]['title']}",
              style: TextStyle(
                fontFamily: 'FiraSans',
                height: 1
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ):ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        color: Theme.of(context).brightness == Brightness.dark ? Color(0xFF1C1C1C): Color(0xFFEEEEEE),
        child: Center(
          child: Text(
            'Advertise your business here. \n Contact us now.',
            style: TextStyle(
              fontFamily: 'FiraSans'
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

}

