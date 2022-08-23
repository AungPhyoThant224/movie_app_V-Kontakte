class PostResponseModel{

  int id;
  String title;
  String url;
  String image;
  String duration;
  int totalView;
  String description;
  List screenshots;
  String createdAt;
  String category;

  PostResponseModel({
    this.id,
    this.title,
    this.url,
    this.image,
    this.duration,
    this.totalView,
    this.description,
    this.screenshots,
    this.createdAt,
    this.category
  });

}