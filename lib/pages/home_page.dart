import 'package:flutter/material.dart';
import 'package:flutter_ctrip/dao/home_dao.dart';
import 'package:flutter_ctrip/model/common_model.dart';
import 'package:flutter_ctrip/model/home_model.dart';
import 'package:flutter_ctrip/widgets/local_nav.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// 计算appBar透明度，滚动出去的最大距离
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播图页面
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];

  // 自定义appBar的透明度
  double appBarAlpha = 0.0;

  // 本地Nav列表
  List<CommonModel> localNavList = null;

  @override
  void initState(){
    super.initState();

    loadData();
  }

  loadData() async{
    try {
      HomeModel model = await HomeDao.fetch();

      setState(() {
        localNavList = model.localNavList;
      });
    } catch(e) {
      setState(() {
        print(e);
      });
    }
  }

  _onScroll(offset){
    // offset 滚出去的距离
    var alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0.0;
    } else if (alpha > 1) {
      alpha = 1.0;
    }

    setState(() {
      appBarAlpha = alpha;
    });

    print(alpha);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      // 可以移除iPhoneX上面刘海上面的间距
      body:Stack(
       children: <Widget>[
         MediaQuery.removePadding(
             context: context,
             removeTop: true, // 移除顶部的间距
             child: NotificationListener(
               onNotification: (scrollNotification){
                 if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                   // 滚动，并且只有 ListView滚动的时候 ，scrollNotification.depth == 0 代表第一级子元素(ListView)滚动
                   _onScroll(scrollNotification.metrics.pixels);
                 }
               },
               child: ListView(
                 children: <Widget>[
                   Container(
                     height: 200,
                     child: Swiper(
                         itemCount: _imageUrls.length,
                         itemBuilder: (BuildContext context, int i) {
                           return Image.network(_imageUrls[i], fit: BoxFit.fill);
                         },
                         autoplay: true,
                         pagination: SwiperPagination()),
                   ),
                   Padding(
                     padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                     child: LocalNav(localNavList: localNavList),
                   ),
                   Container(
                       height: 800,
                       child: ListTile(
                         title: Text('哈哈'),
                       )
                   )

                 ],
               ),
             )
         ),
         Opacity(
           opacity: appBarAlpha,
           child: Container(
             height: 80,
             decoration: BoxDecoration(color: Colors.white),
             child: Center(
               child: Padding(padding: EdgeInsets.only(top: 30),child: Text('首页'))
             ),
           ),
         )
       ],
      )
    );
  }
}