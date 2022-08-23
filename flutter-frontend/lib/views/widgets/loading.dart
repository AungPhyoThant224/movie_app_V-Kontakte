import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie/views/widgets/url_launch.dart';

class Loading extends StatefulWidget {
  final int state;
  final String title;
  final String message;
  Loading(this.state, this. title, this.message);

  @override
  _LoadingState createState() => _LoadingState(this.state, this.title, this.message);
}

class _LoadingState extends State<Loading> {

  final int state;
  final String title;
  final String message;
  _LoadingState(this.state, this.title, this.message);

  @override
  Widget build(BuildContext context) {
    return state == 0 ? AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Theme.of(context).cardColor,
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
            ]
          ),
          height: 100,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitThreeBounce(
                color: Theme.of(context).primaryColor,
                size: 28.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Loading',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'FiraSans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ): AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'FiraSans',
          fontSize: 20
        ),
      ),
      content: Container(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          message,
          style: TextStyle(
            fontFamily: 'FiraSans',
            fontSize: 15,
          ),
        ),
      ),
      actions: [
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(
            'Continue',
            style: TextStyle(
              fontFamily: 'FiraSans',
              fontSize: 16,
              color: Theme.of(context).primaryColor
            ),
          ),
        )
      ],
    );
  }
}

Future<Widget> loading(context, int state, String title, String message, {Map notification}){
  return showDialog(
    context: context, 
    barrierDismissible: false,
    builder :(context){
      return state == 0 ? AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Theme.of(context).backgroundColor,
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
              ]
            ),
            height: 100,
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                  size: 28.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Loading',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 15
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ): state == 1 ? AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'FiraSans',
            fontSize: 20
          ),
        ),
        content: Container(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            message,
            style: TextStyle(
              fontFamily: 'FiraSans',
              fontSize: 15,
            ),
          ),
        ),
        actions: [
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              'Continue',
              style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 16,
                color: Theme.of(context).primaryColor
              ),
            ),
          )
        ],
      ):AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          notification['title'],
          style: TextStyle(
            fontFamily: 'FiraSans',
            fontSize: 20
          ),
        ),
        content: Container(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            notification['description'],
            style: TextStyle(
              fontFamily: 'FiraSans',
              fontSize: 15,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              notification['type'] == '2' ? FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 16,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ): Container(),
              notification['type'] == '1' || notification['type'] == '3' ? FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 16,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ): Container(),
              notification['type'] == '1' || notification['type'] == '3' ? FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () async{
                  customLaunch(notification['note'], 1);
                  Navigator.pop(context);
                },
                child: Text(
                  notification['type'] == '1' ? 'Update' : 'Visit',
                  style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark ? Color(0xFF2C3333) : Color(0xFFFFFFFF)
                  ),
                ),
              ): Container(),
            ],
          )
        ],
      );
    }
  );
}