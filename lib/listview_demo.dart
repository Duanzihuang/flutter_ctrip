import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SampleAppPageState();
  }
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  // 是否展示进度条
  showLoadingDialog() {
    return widgets.length == 0;
  }

  /*
  * 展示内容
  * */
  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      print('show ListView');
      return getListView();
    }
  }

  getProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  Widget getRow(i) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text("Row ${widgets[i]["title"]}"),
    );
  }

  /**
   * 获取ListView，并且渲染
   */
  ListView getListView() {
    return ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        });
  }

  // 加载数据
  loadData() async {
    String dataURL = 'https://jsonplaceholder.typicode.com/posts';

    http.Response response = await http.get(dataURL);

    // 赋值给模型
    setState(() {
      widgets = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView 展示'),
      ),
      body: getBody(),
    );
  }
}
