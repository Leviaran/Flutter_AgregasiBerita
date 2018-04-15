import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home_page.dart';

class PostDetails extends StatefulWidget {

  PostDetails(this.post);
  final Post post;

  @override
  State<StatefulWidget> createState() => new _PostDetailsState(post);
}

class _PostDetailsState extends State<PostDetails> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Post post;

  _PostDetailsState(this.post);

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text(
        post.title,
        style: new TextStyle(fontSize: 16.0),
        overflow: TextOverflow.fade,
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState.showSnackBar(
              const SnackBar(
                content: const Text("Implementasi fungsi Share"),
              )
            );
          },
        )
      ],
    ),
    body: new Scaffold(
      key: _scaffoldKey,
      body: _postCardView(),
    ),
  );

  Widget _postCardView(){
    return new Container(
      margin: new EdgeInsets.all(10.0),
      child: new Column(
        children: <Widget>[
          new Text(post.title,
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
          ),
          new Padding(
            padding: new EdgeInsets.symmetric(vertical: 10.0),
            child: new Divider(
              height: 1.0,
              color: Colors.black,
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.access_time,
                color: Colors.grey,
              ),
              new Padding(
                padding: new EdgeInsets.symmetric(horizontal: 10.0),
                child: new Text(getFormattedTime()),
              )
            ],
          ),
          new Container(
            width: double.infinity,
            height: 150.0,
            margin: new EdgeInsets.all(10.0),
            child: new Image.network(
              post.thumbUrl,
              fit: BoxFit.cover,
            ),
          ),
          new Text(
            post.summary,
            style: new TextStyle(
              fontSize: 16.0,
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 20.0),
            child: new RaisedButton(
              onPressed: _launchUrl,
              child: new Text(
                "Read More",
                style: new TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
              splashColor: Colors.deepOrangeAccent,
            ),
          )
        ],
      ),
    );
  }

  String getFormattedTime() {
    var timeStamp = new DateTime.fromMicrosecondsSinceEpoch(post.timeStamp);
    var formatter = new DateFormat('dd MMMm yyyy. HH:mm');
    return formatter.format(timeStamp);
  }

  void _launchUrl() async {
    String url = post.url;
  }
}