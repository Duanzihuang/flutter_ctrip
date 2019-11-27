import 'package:flutter/material.dart';

void main() {
  runApp(AnimationApp());
}

class AnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: AnimationAppWidget());
  }
}

class AnimationAppWidget extends StatefulWidget {
  AnimationAppWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnimationAppWidgetState();
  }
}

class AnimationAppWidgetState extends State<AnimationAppWidget>
    with SingleTickerProviderStateMixin {
  // 定义好模型
  Animation<double> animation; // 动画
  AnimationController controller; // 动画控制器
  AnimationStatus animationStatus; // 动画状态
  double animationValue; // 动画的值

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 初始化动画相关的内容
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      // 添加监听
      ..addListener(() {
        setState(() {
          animationValue = animation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          animationStatus = status;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                controller.reset(); // 重置动画
                controller.forward(); // 开始执行动画
              },
              child: Text('Start')),
          Text('State:' + animationStatus.toString()),
          Text('Value:' + animationValue.toString()),
          Container(
              height: animationValue,
              width: animationValue,
              child: FlutterLogo())
        ],
      ),
    );
  }
}
