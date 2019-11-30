import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5'];

class WebView extends StatefulWidget{
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid; // 返回禁止，不能加载其它页面

  WebView({
    this.url, this.statusBarColor, this.title, this.hideAppBar,
    this.backForbid = false
  });

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  // 是否已经进行过返回首页了
  bool exiting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebviewPlugin.close();
    // 处理各种监听
    // 监听url改变
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url){});
    // 监听webview状态改变
    _onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state){
      switch (state.type) {
        case WebViewState.startLoad:
//          print(state.url);
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid){
              flutterWebviewPlugin.launch(state.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    
    // 监听加载url失败
    _onHttpError = flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error){print(error);});
  }

  _isToMain(String url){
    bool contain = false;

    for(final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }

    return contain;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff'){
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff'+statusBarColorStr)),backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('加载中...'),
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _appBar(Color backgroundColor,Color backButtonColor){
    if (widget.hideAppBar ?? false) { // 如果隐藏AppBar
      return Container(
        height: 30,
        color: backgroundColor
//        color: Colors.red,
      );
    }

    // 没有隐藏AppBar
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1, // 宽度占满整个屏幕
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(Icons.close,size: 26,color: backButtonColor),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                  child: Text(widget.title ?? '',style: TextStyle(fontSize: 20))
              ),
            )
          ],
        ),
      ),
    );
  }
}