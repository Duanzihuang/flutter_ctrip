import 'package:flutter_ctrip/model/common_model.dart';
import 'package:flutter_ctrip/model/config_model.dart';
import 'package:flutter_ctrip/model/grid_nav_model.dart';
import 'package:flutter_ctrip/model/sales_box_model.dart';

// 首页需要的模型
class HomeModel{
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel({this.config,this.bannerList,this.localNavList,this.subNavList,this.gridNav,this.salesBox});

  // 工厂方法
  factory HomeModel.fromJson(Map<String,dynamic> json){
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((item) => CommonModel.fromJson(item)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavListJson.map((item) => CommonModel.fromJson(item)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavListJson.map((item) => CommonModel.fromJson(item)).toList();

    return HomeModel(
      bannerList:bannerList,
      localNavList:localNavList,
      subNavList:subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox'])
    );
  }
}