import 'package:flutter/material.dart';
import 'package:myapp/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Agregasi Berita',
      theme: new ThemeData(
        //Berupa tema pada aplikasi
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.blueAccent
      ),
      home: new MyHomePage(title: 'Agregasi Berita'),
    );
  }

}
