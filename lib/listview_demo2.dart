import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  @override
  ListViewDemoState createState() => ListViewDemoState();
}

class ListViewDemoState extends State<ListViewDemo> {
  List<String> CITIES_NAMES = [
    '北京',
    '上海',
    '广州',
    '深圳',
    '杭州',
    '武汉',
    '南京',
    '重庆',
    '长沙',
    '乌鲁木齐',
    '西安'
  ];

  // 上拉加载更多需要的控制器
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMore();
      }
    });

    super.initState();
  }

  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  // 上拉加载更多
  Future<Null> _loadMore() async {
    await Future.delayed(Duration(microseconds: 200));

    setState(() {
      List<String> list = List<String>.from(CITIES_NAMES);

      // 重新再增加一份
      list.addAll(CITIES_NAMES);

      CITIES_NAMES = list;
    });

    return null;
  }

  // 下拉刷新
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));

    // 重新赋值
    setState(() {
      CITIES_NAMES = CITIES_NAMES.reversed.toList();
    });

    return null;
  }

  List<Widget> _buildList() {
    return CITIES_NAMES.map((city) => _item(city)).toList();
  }

  // 生成每一个item
  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('下拉与上拉Demo')),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView(
            controller: _controller,
            children: _buildList(),
          ),
        ));
  }
}
