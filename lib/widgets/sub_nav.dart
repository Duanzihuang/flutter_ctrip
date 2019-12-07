import 'package:flutter/material.dart';
import 'package:flutter_ctrip/model/common_model.dart';
import 'package:flutter_ctrip/widgets/webview.dart';

class SubNav extends StatelessWidget{
  final List<CommonModel> subNavList;

  const SubNav({Key key,@required this.subNavList}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    if (subNavList == null) return null;
    // TODO: implement build
    // 计算每一行显示的个数
    int separate = (subNavList.length / 2 + 0.5).toInt();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6)
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context)
      )
    );
  }

  // 生成一行视图
  _items(BuildContext context){
    if (subNavList == null) return null;
    List<Widget> items = [];

    // 遍历数组，生成一个一个的widget
    subNavList.forEach((model){
      items.add(_item(context,model));
    });

    int separate = (subNavList.length / 2 + 0.5).toInt();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0,separate)
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate,subNavList.length)
          ),
        )
      ],
    );
  }

  // 生成每一个item
  _item(BuildContext context,CommonModel model){
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => WebView(
                    url: model.url,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar
                )
            ));
          },
          child: Column(
            children: <Widget>[
              Image.network(model.icon,width: 18,height: 18),
              Padding(
                  padding: EdgeInsets.only(top:3),
                  child: Text(model.title,style:TextStyle(fontSize: 12)))
            ],
          ),
        )
      );
  }
}