//底部卡片入口
import 'package:flutter/material.dart';
import 'package:flutter_ctrip/model/common_model.dart';
import 'package:flutter_ctrip/model/sales_box_model.dart';
import 'package:flutter_ctrip/widgets/webview.dart';

class SalesBox extends StatelessWidget{
  final SalesBoxModel salesBox;

  const SalesBox({Key key,@required this.salesBox}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: _items(context)
    );
  }

  _items(BuildContext context){
    if (salesBox == null) return null;

    List<Widget> items = [];
    // 添加一个大行
    items.add(_doubleItems(context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    // 添加两个小行
    items.add(_doubleItems(context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItems(context, salesBox.smallCard3, salesBox.smallCard4, false, true));

    return Column(
      children: <Widget>[
        // 图片及标题
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1,color:Color(0xfff2f2f2)))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(salesBox.icon,
                height: 15,fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Color(0xffff4e63),Color(0xffff6cc9)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                  )
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return WebView(url: salesBox.moreUrl,title: '更多活动');
                    }));
                  },
                  child: Text('获取更多福利 >',style: TextStyle(color: Colors.white,fontSize: 12)),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0,1)
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(1,2)
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(2,3)
        )
      ],
    );
  }

  // 构建每一行的两个
  Widget _doubleItems(BuildContext context,CommonModel leftCard,CommonModel rightCard,bool big,bool last){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // 左边卡片
        _item(context,leftCard,true,big,last),
        // 右边卡片
        _item(context,rightCard,false,big,last)
      ],
    );
  }

  // 构建每一个item
  /**
   * left 是否是左边
   * big 是否是大的
   * last 是否是最后一个
   */
  Widget _item(BuildContext context,CommonModel model,bool left,bool big,bool last){
    BorderSide borderSide = BorderSide(width: 0.8,color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => WebView(
            url: model.url,
            statusBarColor: model.statusBarColor,
            hideAppBar: model.hideAppBar
          )
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: left ? borderSide : BorderSide.none,
            bottom: last ? BorderSide.none : borderSide
          )
        ),
        child: Image.network(
          model.icon,
          fit: BoxFit.fill,
          // MediaQuery.of(context).size.width 获取屏幕的宽度
          width: MediaQuery.of(context).size.width / 2 - 10,
          height: big ? 129 : 80
        ),
      ),
    );
  }
}