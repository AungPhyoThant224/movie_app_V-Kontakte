import 'package:flutter/services.dart';
import 'package:movie/models/about_model.dart';
import 'package:movie/models/data_model.dart';
import 'package:movie/models/index_model.dart';
import 'package:movie/models/post_model.dart';
import 'dart:convert';
import 'package:movie/models/response_model.dart';

class Service{

  String error = "Error.";
  String success = 'Success.';
  int statusCode = 200;

  Future<ResponseModel> getIndex(version) async{
    
    var response = await rootBundle.loadString('assets/json/index.json');
    if(statusCode == 200){
      var jsonData = jsonDecode(response);
      IndexResponseModel resData = IndexResponseModel(
        popular: jsonData['popular'],
        newest: jsonData['new'],
        category: jsonData['categories'],
        ads: jsonData['slider_images'],
        notification: jsonData['notification']
      );
      return ResponseModel(status: statusCode, data: resData, message: success);
    }
    else{
      return ResponseModel(status: statusCode, message: error);
    }

  }

  Future<ResponseModel> getPopular(int nextPage) async{
    
    List<PostResponseModel> posts = [];
    var response = await rootBundle.loadString('assets/json/popular.json');
    
    if(statusCode == 200){
      var jsonData = jsonDecode(response);
      jsonData['data'].forEach((_data){
        PostResponseModel data = PostResponseModel(
          id: _data['id'],
          title: _data['title'],
          url: _data['url'],
          image: _data['image'],
          duration: _data['duration'],
          totalView: _data['total_view'],
          description: _data['description'],
          screenshots: _data['screenshots'],
          createdAt: _data['created_at'],
          category: _data['category'][0]['name'],
        );
        posts.add(data);
      });
      DataResponseModel resData = DataResponseModel(
        currentPage: jsonData['current_page'],
        data: posts,
        lastPage: jsonData['last_page'],
        adsSlider: jsonData['slider_images'],
        adsGrid: jsonData['card_images'],
      );
      return ResponseModel(status: statusCode, data: resData, message: success);
    }
    else{
      return ResponseModel(status: statusCode, message: error);
    }

  }

  Future<ResponseModel> getNewest(int nextPage) async{
    
    List<PostResponseModel> posts = [];
    var response = await rootBundle.loadString('assets/json/newest.json');
    if(statusCode == 200){
      var jsonData = jsonDecode(response);
      jsonData['data'].forEach((_data){
        PostResponseModel data = PostResponseModel(
          id: _data['id'],
          title: _data['title'],
          url: _data['url'],
          image: _data['image'],
          duration: _data['duration'],
          totalView: _data['total_view'],
          description: _data['description'],
          screenshots: _data['screenshots'],
          createdAt: _data['created_at'],
          category: _data['category'][0]['name'],
        );
        posts.add(data);
      });
      DataResponseModel resData = DataResponseModel(
        currentPage: jsonData['current_page'],
        data: posts,
        lastPage: jsonData['last_page'],
        adsSlider: jsonData['slider_images'],
        adsGrid: jsonData['card_images'],
      );
      return ResponseModel(status: statusCode, data: resData, message: success);
    }
    else{
      return ResponseModel(status: statusCode, message: error);
    }

  }

  Future<ResponseModel> getSearch(String _title, int nextPage) async{
    
    List<PostResponseModel> posts =[];
    var response = await rootBundle.loadString('assets/json/search.json');

    if(statusCode == 200){
      var jsonData = jsonDecode(response);
      jsonData['data'].forEach((_data){
        PostResponseModel data = PostResponseModel(
          id: _data['id'],
          title: _data['title'],
          url: _data['url'],
          image: _data['image'],
          duration: _data['duration'],
          totalView: _data['total_view'],
          description: _data['description'],
          screenshots: _data['screenshots'],
          createdAt: _data['created_at'],
        );
        posts.add(data);
      });
      DataResponseModel resData = DataResponseModel(
        currentPage: jsonData['current_page'],
        data: posts,
        lastPage: jsonData['last_page'],
        adsSlider: jsonData['slider_images'],
        adsGrid: jsonData['card_images'],
      );
      return ResponseModel(status: statusCode, data: resData, message: success);
    }
    else{
      return ResponseModel(status: statusCode, message: error);
    }

  }

  Future<ResponseModel> getCategory(int _categroy, int nextPage) async{

    List<PostResponseModel> posts =[];
    var response = await rootBundle.loadString('assets/json/category.json');

    if(statusCode == 200){
      var jsonData = jsonDecode(response);
      jsonData['posts']['data'].forEach((_data){
        PostResponseModel data = PostResponseModel(
          id: _data['id'],
          title: _data['title'],
          url: _data['url'],
          image: _data['image'],
          duration: _data['duration'],
          totalView: _data['total_view'],
          description: _data['description'],
          screenshots: _data['screenshots'],
          createdAt: _data['created_at'],
          category: _data['category'][0]['name']
        );
        posts.add(data);
      });
      DataResponseModel resData = DataResponseModel(
        currentPage: jsonData['posts']['current_page'],
        data: posts,
        lastPage: jsonData['posts']['last_page'],
        adsSlider: jsonData['posts']['slider_images'],
        adsGrid: jsonData['posts']['card_images'],
      );
      return ResponseModel(status: statusCode, data: resData, message: success);
    }
    else{
      return ResponseModel(status: statusCode, message: error);
    }

  }

  Future<ResponseModel> getPolicy() async{
    
    var response = await rootBundle.loadString('assets/json/policy.json');
    if(statusCode == 200){
      var jsonData = jsonDecode(response);
      var resData = jsonData;
      return ResponseModel(status: statusCode, data: resData, message: success);
    }
    else{
      return ResponseModel(status: statusCode, message: error);
    }

  }

  Future<ResponseModel> getAbout() async{
    
    var response = await rootBundle.loadString('assets/json/about.json');
    if(statusCode == 200){
      var jsonData = jsonDecode(response);
      AboutResponseModel resData = AboutResponseModel(
        name: jsonData['name'],
        logo: jsonData['logo'],
        about: jsonData['about'],
        contact: jsonData['contact'],
        downloadLink: jsonData['dlink']
      );
      return ResponseModel(status: statusCode, data: resData, message: success);
    }
    else{
      return ResponseModel(status: statusCode, message: error);
    }

  }

}