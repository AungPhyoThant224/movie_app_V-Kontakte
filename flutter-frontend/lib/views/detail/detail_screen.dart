import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/models/response_model.dart';
import 'package:movie/presenter/service.dart';
import 'package:movie/views/video_player/video_player.dart';
import 'package:movie/views/widgets/cache_image.dart';

class DetailScreen extends StatefulWidget {
  final Map movieDetails;
  final String fromPage;
  DetailScreen(this.movieDetails, this.fromPage);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  Service service = Service();
  ResponseModel resData;
  String videoUrl;
  String posterUrl;
  String view;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: (){
        if(resData != null){
          Navigator.pop(context, resData.data);
        }
        else{
          Navigator.pop(context);
        }
        return ;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar : AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          leading: Builder(builder: (BuildContext context) {
            return IconTheme(
              data: Theme.of(context).iconTheme,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  if(resData != null){
                    Navigator.pop(context, resData.data);
                  }
                  else{
                    Navigator.pop(context);
                  }
                },
              )
            );
          }),
          title: Text(
            widget.movieDetails['title'],
            style: Theme.of(context).textTheme.headline6.copyWith(
              fontFamily: 'FiraSans',
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  BackdropImage(widget.movieDetails['image']),
                  _buildWidgetFloatingActionButton(mediaQuery),
                ],
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildWidgetTitleMovie(context),
                    SizedBox(height: 16.0),
                    _buildWidgetShortDescriptionMovie(context),
                    SizedBox(height: 16.0),
                    _buildWidgetSynopsisMovie(context),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetFloatingActionButton(MediaQueryData mediaQuery) {
    return Column(
      children: <Widget>[
        SizedBox(height: mediaQuery.size.height / 3.0 - 60),
        Center(
          child: FloatingActionButton(
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return VideoPlayer(videoUrl, posterUrl);
              }));
            },
            child: Icon(
              Icons.play_arrow,
              color: Theme.of(context).brightness == Brightness.light  ? Colors.white : Colors.black,
              size: 32.0,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetTitleMovie(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Center(
        child: Text(
          widget.movieDetails['title'],
          style: Theme.of(context).textTheme.title.copyWith(
            fontFamily: 'FiraSans'
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _buildWidgetShortDescriptionMovie(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Category\n',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontFamily: 'FiraSans'
                  ),
                ),
                TextSpan(
                  text: widget.fromPage == 'home' ? widget.movieDetails['category'][0]['name'] : widget.movieDetails['category'],
                  style: Theme.of(context).textTheme.subtitle.merge(
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      fontFamily: 'FiraSans'
                    ),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Views\n',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontFamily: 'FiraSans'
                  ),
                ),
                TextSpan(
                  text: view ?? widget.movieDetails['total_view'].toString(),
                  style: Theme.of(context).textTheme.subtitle.merge(
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FiraSans',
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Duration\n',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontFamily: 'FiraSans'
                  ),
                ),
                TextSpan(
                  text: widget.movieDetails['duration'] + ' mins',
                  style: Theme.of(context).textTheme.subtitle.merge(
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      fontFamily: 'FiraSans'
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetSynopsisMovie(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Text(
          widget.movieDetails['description'],
          style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontFamily: 'FiraSans'
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

class BackdropImage extends StatelessWidget {
  final String backdropPath;

  BackdropImage(this.backdropPath);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return ClipPath(
      child: cacheImage(
        context, 
        backdropPath,
        height: mediaQuery.size.height / 3,
        width: mediaQuery.size.width,
      ),
      clipper: BottomWaveClipper(),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 70.0);

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 70.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, size.height - 70.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
