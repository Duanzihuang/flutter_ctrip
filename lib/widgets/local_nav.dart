import 'package:flutter/material.dart';
import 'package:flutter_ctrip/model/common_model.dart';

class LocalNav extends StatelessWidget{
  final List<CommonModel> localNavList;

  const LocalNav({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context)
      ),
    );
  }

  Widget _items(BuildContext context){
    if (localNavList == null) return null;

    List<Widget> items = [];

    localNavList.forEach((model){
      items.add(_item(context, model));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context,CommonModel model){
    return GestureDetector(
      onTap: (){
       print(model.title);
      },
      child: Column(
        children: <Widget>[
          Image.network(model.icon,width: 32,height: 32),
          Text(model.title,style: TextStyle(fontSize: 12))
        ]
      )
    );
  }
}