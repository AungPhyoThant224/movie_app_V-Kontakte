import 'package:movie/models/post_model.dart';

class DataResponseModel{
  int currentPage;
  List<PostResponseModel> data;
  int lastPage;
  List adsSlider;
  List adsGrid;

  DataResponseModel({this.currentPage, this.data, this.lastPage, this.adsSlider, this.adsGrid});
}