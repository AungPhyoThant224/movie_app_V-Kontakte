import 'dart:io';
import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/response_model.dart';
import 'package:movie/presenter/service.dart';
import 'package:movie/views/home/home_screen.dart';
import 'package:movie/views/widgets/loading.dart';

class Policy extends StatefulWidget {

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {

  Service service = Service();
  ResponseModel resData;
  String policy;
  bool _clickAgree = true;
  var deviceId;

  @override
  void initState() {
    super.initState();
    getPolicy();
    getDeviceId();
  }

  getPolicy() async{
    resData = await service.getPolicy();
    if(resData.status == 200){
      policy = resData.data['policy'];
      setState(() { });
    }else{
      loading(context, 1, 'Terms & Privacy Policy', 'Something went wrong. Please try again.');
    }
  }

  
  getDeviceId() async{
    deviceId = await DeviceId.getID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: resData != null ? AppBar(
        centerTitle: false,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Terms & Privacy Policy',
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontFamily: 'FiraSans',
            fontWeight: FontWeight.bold
          ),
        ),
      ): null,
      body: resData != null ?SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Column(
              children: [
                Text(
                  policy,
                  style: TextStyle(
                    fontFamily: 'FiraSans',
                  ),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ),
      ): Loading(0, null, null),
      bottomNavigationBar: resData != null ? Container(
        height: 120,
        alignment: Platform.isIOS ? Alignment.topCenter : Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.1),
              style: BorderStyle.solid
            )
          )
        ),
        padding: EdgeInsets.fromLTRB(11, 8, 11, 8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value: _clickAgree,
                    activeColor: Theme.of(context).primaryColor,
                    checkColor: Theme.of(context).backgroundColor,
                    onChanged: (bool value) {
                      setState(() {
                        _clickAgree = value;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _clickAgree = !_clickAgree;
                        });
                      },
                      child: Container(
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'I have read and agree to the ',
                                style: Theme.of(context).textTheme.body1.copyWith(
                                  fontFamily: 'FiraSans'
                                ),
                              ),
                              TextSpan(
                                text: 'Terms and Privacy Policy of Dark Moon.',
                                style: Theme.of(context).textTheme.body1.copyWith(
                                  fontFamily: 'FiraSans',
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: () async {
                  loading(context, 0, null, null);
                  if(_clickAgree == true && deviceId != null){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                      return HomeScreen();
                    }));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: _clickAgree == false ? Colors.grey.shade500 : Theme.of(context).primaryColor
                  ),
                  child: Center(
                    child: Text(
                      "Accept",
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        color: Theme.of(context).brightness == Brightness.dark ? Color(0xFF2C3333) : Color(0xFFFFFFFF)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ): null,
    );
  }
}