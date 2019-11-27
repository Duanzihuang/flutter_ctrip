import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(ImageApp());
}

class ImageApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
            appBar: AppBar(
                title:Text('Cached Images')
            ),
            body: Center(
                child: CachedNetworkImage(
                    placeholder: (context, url) => new CircularProgressIndicator(),
                    imageUrl: 'https://picsum.photos/250?image=9'
                )
            )
        )
    );
  }
}
