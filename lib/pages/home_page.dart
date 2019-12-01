import 'package:flutter/material.dart';
import 'package:flutter_ctrip/dao/home_dao.dart';
import 'package:flutter_ctrip/model/common_model.dart';
import 'package:flutter_ctrip/model/grid_nav_model.dart';
import 'package:flutter_ctrip/model/home_model.dart';
import 'package:flutter_ctrip/model/sales_box_model.dart';
import 'package:flutter_ctrip/widgets/grid_nav.dart';
import 'package:flutter_ctrip/widgets/loading_container.dart';
import 'package:flutter_ctrip/widgets/local_nav.dart';
import 'package:flutter_ctrip/widgets/sales_box.dart';
import 'package:flutter_ctrip/widgets/sub_nav.dart';
import 'package:flutter_ctrip/widgets/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// 计算appBar透明度，滚动出去的最大距离
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播图页面
//  List _imageUrls = [
//    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
//    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
//    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
//  ];

  // 自定义appBar的透明度
  double appBarAlpha = 0.0;

  // 是否正在加载中
  bool _loading = true;

  // 轮播图数据
  List<CommonModel> bannerList = [];
  // 本地Nav列表
  List<CommonModel> localNavList = [];
  // 网格布局，所需要的数据
  GridNavModel gridNavModel;
  // 活动数据列表
  List<CommonModel> subNavList = [];
  // 底部卡片数据
  SalesBoxModel saleBoxModel;

  @override
  void initState(){
    super.initState();

    // 初始化加载数据
    _handleRefresh();
  }

  Future<Null> _handleRefresh() async{
    try {
      HomeModel model = await HomeDao.fetch();

      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        saleBoxModel = model.salesBox;
        _loading = false;
      });
    } catch(e) {
      setState(() {
        print(e);
        _loading = false;
      });
    }

    return null;
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
      body:LoadingContainer(isLoading: _loading,child: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
              context: context,
              removeTop: true, // 移除顶部的间距
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                    onNotification: (scrollNotification){
                      if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                        // 滚动，并且只有 ListView滚动的时候 ，scrollNotification.depth == 0 代表第一级子元素(ListView)滚动
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                    },
                    child: _listView
                ),
              )
          ),
          _appBar
        ],
      ))
    );
  }

  // 抽取appBar
  Widget get _appBar{
    return Opacity(
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
            child: Padding(padding: EdgeInsets.only(top: 30),child: Text('首页'))
        ),
      ),
    );
  }

  // 抽取ListView
  Widget get _listView{
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: saleBoxModel),
        )
      ]
    );
  }

  // 抽取轮播图
  Widget get _banner{
    return Container(
      height: 200,
      child: Swiper(
          itemCount: bannerList.length,
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: (){
                CommonModel model = bannerList[i];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => WebView(
                    url: model.url,
                    title: model.title,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar
                  )
                ));
              },
              child: Image.network(bannerList[i].icon, fit: BoxFit.fill),
            );
          },
          autoplay: true,
          pagination: SwiperPagination()),
    );
  }
}