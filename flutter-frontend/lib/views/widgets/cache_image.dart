import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cacheImage(context ,imageUrl, {double height, double width, double borderRadius, BoxFit boxfit}){
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) => Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        color: Colors.black12,
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ),
    ),
    errorWidget: (context, url, error) => Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        color: Colors.black12,
      ),
      child: Icon(Icons.error_outline, color: Theme.of(context).errorColor,),
    ),
    imageBuilder: (context, imageProvider) => Card(
      elevation: 0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
      ),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
          color: Colors.black12,
          image: DecorationImage(
            image: imageProvider,
            fit: boxfit ?? BoxFit.cover
          ),
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
        ),
      ),
    ),
  );
}