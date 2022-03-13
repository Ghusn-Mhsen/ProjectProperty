class Post{
  int userId;
  int id;
  String title;
  String body;
  Post({this.id,this.userId,this.title,this.body});
  Post.fromjson(Map<String,dynamic> json);

}