import 'package:flutter/material.dart';
import 'package:flutter_ctrip/model/common_model.dart';
import 'package:flutter_ctrip/model/grid_nav_model.dart';
import 'package:flutter_ctrip/widgets/webview.dart';

class GridNav extends StatelessWidget{
  final GridNavModel gridNavModel;

  const GridNav({Key key,@required this.gridNavModel}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PhysicalModel( // 可以设置圆角
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias, // 设置裁剪
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  // 根据数据生成 酒店、机票、旅游等【生成三行数据】
  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.hotel != null) {
      // 生成酒店相关的Widget
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      // 生成机票相关的Widget
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      // 生成旅游相关的Widget
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  // 生成每一行数据
  _gridNavItem(BuildContext context,GridNavItem gridNavItem,bool isFirst){
    List<Widget> items = [];

    // 添加左边(_mainItem)
    items.add(_mainItem(context, gridNavItem.mainItem));

    // 添加中间
    items.add(_doubItem(context,gridNavItem.item1,gridNavItem.item2));

    // 添加右边
    items.add(_doubItem(context,gridNavItem.item3,gridNavItem.item4));

    // 让左边、中间、右边平分
    List<Widget> expandItems = [];
    items.forEach((item) => {
      expandItems.add(Expanded(child: item,flex: 1))
    });

    Color startColor = Color(int.parse('0xff'+gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff'+gridNavItem.endColor));
    // 合成一个Container，里面有一行Row
    return Container(
      margin: isFirst ? null : EdgeInsets.only(top:3),
      decoration: BoxDecoration(
        // 设置背景渐变色
        gradient: LinearGradient(colors:[startColor,endColor])
      ),
      height: 88,
      child: Row(
          children: expandItems
      )
    );
  }

  _mainItem(BuildContext context,CommonModel mainItem){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => WebView(
          url: mainItem.url,
          title: mainItem.title,
          statusBarColor: mainItem.statusBarColor,
          hideAppBar: mainItem.hideAppBar
        )));
      },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
            Image.network(
              mainItem.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top:11),
              child: Text(
                  mainItem.title,
                  style: TextStyle(fontSize: 14,color: Colors.white)
              ),
            )
        ]
      ),
    );
  }

  // 构建每一行的中间和右边
  _doubItem(BuildContext context,CommonModel topItem,CommonModel bottomItem){
    return Column(
      children: <Widget>[
        // 两个item中上面的那个
        Expanded(
          child: _item(context,topItem,true),
        ),
        // 两个item中下面的那个
        Expanded(
          child: _item(context,bottomItem,false),
        )
      ],
    );
  }

  // 构建每一个item
  _item(BuildContext context,CommonModel item,bool isFirst){
    BorderSide borderSide = BorderSide(width: 0.8,color: Colors.white);
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => WebView(
          url: item.url,
          title: item.title,
          statusBarColor: item.statusBarColor,
          hideAppBar: item.hideAppBar
        )));
      },
      child: FractionallySizedBox(
        // 撑满父布局的宽度
        widthFactor: 1,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  left: borderSide,
                  bottom: isFirst ? borderSide : BorderSide.none
              )
          ),
          child: Center(
            child: Text(item.title,textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.white)),
          ),
        ),
      )
    );
  }
}