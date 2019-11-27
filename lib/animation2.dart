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

class AnimationAppLogo extends AnimatedWidget {
  AnimationAppLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: animation.value,
          width: animation.value,
          child: new FlutterLogo()),
    );
  }
}

class AnimationAppWidgetState extends State<AnimationAppWidget>
    with SingleTickerProviderStateMixin {
  // 定义好模型
  Animation<double> animation; // 动画
  AnimationController controller; // 动画控制器

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 初始化动画相关的内容
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: 300).animate(controller);

    controller.forward(); // 执行动画
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new AnimationAppLogo(animation: animation);
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
