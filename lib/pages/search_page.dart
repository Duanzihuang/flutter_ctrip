import 'package:flutter/material.dart';
import 'package:flutter_ctrip/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: false,
            hint: '网红打卡地 景点 酒店 美食',
            leftButtonClick: (){
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          )
        ],
      ),
    );
  }

  _onTextChange(text){
    print(text);
  }
}
