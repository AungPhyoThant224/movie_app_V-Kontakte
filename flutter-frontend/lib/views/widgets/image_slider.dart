import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie/views/widgets/cache_image.dart';
import 'package:movie/views/widgets/url_launch.dart';

Widget imageSlider(context, List ads) {
  var listAds = ads ?? [];
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 160.0,
    child: listAds.length != 0 ? CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(seconds: 1),
      ),
      items: listAds.map((result) => 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0 ,vertical: 8),
          child: GestureDetector(
            onTap: () {
              customLaunch(result['contact'], result['ctype']);
            },
            child: Container(
              child: Container(
                child: cacheImage(
                  context, 
                  result['info'],
                  borderRadius: 16.0,
                  boxfit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
      ).toList(),
    ): Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        color: Theme.of(context).brightness == Brightness.dark ? Color(0xFF1C1C1C): Color(0xFFEEEEEE),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Advertise your business here.',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  fontFamily: 'FiraSans',
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Contact us now.',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  fontFamily: 'FiraSans',
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}