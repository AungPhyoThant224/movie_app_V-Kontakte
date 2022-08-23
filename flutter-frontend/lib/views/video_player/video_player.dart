import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:movie/views/widgets/loading.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {

  final String videoUrl;
  final String posterUrl;
  VideoPlayer(this.videoUrl, this.posterUrl);

  @override
  VideoPlayerState createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {

  WebViewPlusController webcontroller;
  int loadCount = 1;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  void loadLocalHtml() async{

    String html = ''' 
    <html> 
      <body style="background-color: #000000;"> 

      <video width='100%' height='100%' autoplay controls controlsList="nodownload" poster="https://legendsdigitaltv.com/images/LDTV-Show-Pics/04-Movies/3-Animated-CGI/Big-Buck-Bunny.jpg">
        <source src="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" type="video/mp4">
        Your browser does not support HTML video.
      </video>

      </body> 
    </html>
    ''';

    final url = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8')
    );
    
    webcontroller.loadUrl(url.toString());
  }

  @override
  dispose(){
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: WebViewPlus(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (_controller){
                this.webcontroller = _controller;
                loadLocalHtml();
              },
              onProgress: (int progress) {
                if(loadCount == 1){
                  loading(context, 0, null, null);
                  loadCount = 2;
                }
                if(progress == 100 && loadCount == 2){
                  Navigator.pop(context);
                  loadCount = 3;
                }
                print("WebView is loading (progress : $progress%)");
              },
              onPageStarted: (String url) async {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
              gestureNavigationEnabled: true,
            ),
        ),
      )
    );
  }
}