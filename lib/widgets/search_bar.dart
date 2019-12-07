import 'package:flutter/material.dart';

enum SearchBarType{home,normal,homeHighlight}

class SearchBar extends StatefulWidget{
  final bool enabled; // 是否启用
  final bool hideLeft; // 是否隐藏左边的
  final SearchBarType searchBarType; // 搜索条的类型
  final String hint; // 输入的内容
  final String defaultText; // 默认文字
  final void Function() leftButtonClick; // 左边按钮点击
  final void Function() rightButtonClick; // 右边按钮点击
  final void Function() speakClick; // 语音按钮点击
  final void Function() inputBoxClick; // 首页输入框点击
  final ValueChanged<String> onChanged; // 搜索框中文字发生了改变的事件


  SearchBar({Key key,this.enabled, this.hideLeft, this.searchBarType = SearchBarType.normal, this.hint,
      this.defaultText, this.leftButtonClick, this.rightButtonClick,
      this.speakClick, this.inputBoxClick, this.onChanged});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //TextField 的搜索控制器
  TextEditingController _controller = TextEditingController();

  bool showClear = false; // 是否显示清除图标

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.searchBarType == SearchBarType.normal ? _genNormalSearch() : _genHomeSearch();
  }

  // 生成普通的搜索条
  _genNormalSearch(){
    return Container(
      child: Row(
        children: <Widget>[
          // 左边的返回按钮
          _wrapTap(Container(
            child: widget?.hideLeft ?? false ? null : Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 26
            ),
          ), widget.leftButtonClick),
          // 中间的输入框
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          // 右边搜索按钮
          _wrapTap(Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              '搜索',
              style: TextStyle(color:Colors.blue,fontSize: 17)
            ),
          ), widget.rightButtonClick)
        ],
      ),
    );
  }

  // 生成首页搜索条
  _genHomeSearch(){
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(Container(
            padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
            child: Row(
              children: <Widget>[
                Text('上海',style:TextStyle(color:_homeFontColor(),fontSize: 14)),
                Icon(
                  Icons.expand_more,
                  color: _homeFontColor(),
                  size: 22
                )
              ],
            ),
          ), widget.leftButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox()
          ),
          _wrapTap(Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Icon(
              Icons.comment,
              color: _homeFontColor(),
              size: 26
            ),
          ), widget.rightButtonClick)
        ],
      ),
    );
  }

  // 搜索条中间的input
  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }

    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normal ? 5 : 15)
      ),
      child: Row(
        children: <Widget>[
          // 中间搜索框左边的搜索图标
          Icon(Icons.search,size: 20,color: widget.searchBarType == SearchBarType.normal ? Color(0xffA9A9A9) : Colors.blue),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal ? TextField( // 非首页
              controller: _controller,
              onChanged: _onChanged,
              autofocus: true,
              // TextField本身的样式
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w300
              ),
              // 输入文本的样式
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                border: InputBorder.none,
                hintText: widget.hint ?? '',
                hintStyle: TextStyle(fontSize: 15)
              ),
            ) : _wrapTap(Container( // 首页
              child: Text(
                widget.defaultText,
                style: TextStyle(fontSize: 13,color: Colors.grey)
              ),
            ), widget.inputBoxClick),
          ),
          !showClear ? _wrapTap(Icon(
            Icons.mic,
            size: 22,
            color: widget.searchBarType == SearchBarType.normal ? Colors.blue : Colors.grey,
          ), widget.speakClick) : _wrapTap(Icon(
            Icons.clear,
            size: 22,
            color: Colors.grey,
          ), (){
            _controller.clear();
            _onChanged('');
          })

        ],
      ),
    );
  }

  // 封装的处理点击事件的方法
  _wrapTap(Widget child,void Function() callback){
    return GestureDetector(
      child: child,
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
    );
  }

  // 文字输入改变的事件
  _onChanged(String text){
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }

    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

  // 设置首页的字体颜色
  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeHighlight ? Colors.black54 : Colors.white;
  }
}