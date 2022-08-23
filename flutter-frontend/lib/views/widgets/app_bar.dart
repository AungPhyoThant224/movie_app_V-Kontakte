import 'package:flutter/material.dart';

Widget appBar(context , String title){
  return AppBar(
    centerTitle: true,
    backgroundColor: Theme.of(context).backgroundColor,
    leading: Builder(builder: (BuildContext context) {
      return IconTheme(
        data: Theme.of(context).iconTheme,
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      );
    }),
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline6.copyWith(
        fontFamily: 'FiraSans',
        fontWeight: FontWeight.bold
      ),
    ),
  );
}