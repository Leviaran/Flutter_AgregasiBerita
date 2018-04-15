import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //network call
import 'dart:convert';
import 'package:myapp/post_details.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();

  final String title;

  MyHomePage({Key key, this.title}) : super(key : key);

}

class _MyHomePageState extends State<MyHomePage> {

  bool _isRequestSent = false;
  List<Post> postList = [];

  @override
  Widget build(BuildContext context){

    if(!_isRequestSent){
      _sendRequest();
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        alignment: Alignment.center,
        child: !_isRequestSent ? new CircularProgressIndicator() : new Container(
          child: new ListView.builder(
            itemCount: postList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index){
              return _getPostWidgets(index);
            },
          ),
        ),
      ),

    );
  }

  void _sendRequest() async {
  String url = "https://api.nytimes.com/svc/topstories/v2/technology"
      ".json?api-key=7efbc619b54e44af9e1f68b7d87a1a02";
  http.Response response = await http.get(url);
  Map decode = json.decode(response.body);
  List results = decode["results"];
  for(var jsonObject in results){
    var post = Post.getPostFromJSONPost(jsonObject);
    postList.add(post);
    print(post);
  }
  setState(() => _isRequestSent = true);
}

Widget _getPostWidgets(int index){
  var post = postList[index];
  return new GestureDetector(
    onTap: () {
      openDetailsUI(post);
    },
    child: new Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
      child: new Card(
        elevation: 3.0,
        child: new Row(
          children: <Widget>[
            new Container(
              width: 150.0,
              child: new Image.network(
                post.thumbUrl,
                fit: BoxFit.cover,
              ),
            ),
            new Expanded(
              child: new Container(
                margin: new EdgeInsets.all(10.0),
                child: new Text(
                  post.title,
                  style: new TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

openDetailsUI(Post post) {
  Navigator.push(context, new MaterialPageRoute(
    builder: (BuildContext context) => new PostDetails(post)));

}

}

class Post {
  String title;
  String summary;
  String thumbUrl;
  int timeStamp;
  String url;

  Post(this.title, this.summary, this.thumbUrl, this.timeStamp, this.url);

  static Post getPostFromJSONPost(dynamic jsonObject){
    String title = jsonObject['title'];
    String url = jsonObject['url'];
    String summary = jsonObject['abstract'];
    List multiMediaList = jsonObject['multimedia'];

    String thumbUrl = multiMediaList.length > 4 ? multiMediaList[3]['url'] : "";

    int timeStamp = DateTime.parse(jsonObject['created_date']).millisecondsSinceEpoch;

    return new Post(title, summary, thumbUrl, timeStamp, url);

  }

  @override
  String toString(){
    return "title = $title; summary = $summary; thumbUrl = $thumbUrl; "
    "timeStamp = $timeStamp; url = $url";
  }
}

