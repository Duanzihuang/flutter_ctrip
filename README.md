# flutter_ctrip

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Dart
> https://dartpad.dev/

> 注意事项

```
1、Dart未初始化的默认类型是 null，JavaScript未初始化的默认类型是 undefined

2、Dart中只有Boolean类型的true才是 true，JavaScript中非null 和 非0 都认为是true

3、?.运算符在左边为null的情况下会阻断右边的调用(相当于js的 &&)，??运算符主要作用是在左边的表达式为null时为其设置默认值
```

> 异步编程【Future、Async、Await】

```
JavaScript中Promise是异步编程

Dart中Future是异步编程

JavaScript中 async 后面返回的是一个Promise对象，await 等待的是Promise执行完毕
Dart中 async 后面返回的是一个Future对象，await 等待的是Future执行完毕
```

## Flutter

> 示例及Demo
```
https://github.com/iampawan/FlutterExampleApps

https://github.com/flutter/flutter/tree/master/examples
```
> 基础知识

```
# 创建项目
flutter create project_name

# 运行项目(终端)
flutter run -d '模拟器/真机名称'
```

> Widget

```
Flutter 中所有的视图都是由一个一个的小部件(Widget)组成的

Widget 就是 iOS、Android、RN 中的View


StatelessWidgets适用于当我们描述的用户界面不依赖于对象中的配置信息时。

例如，在Android/iOS中，我们需要用ImageView/UIImageView来显示logo。 logo在运行时不会改变，因此在Flutter中使用StatelessWidget是最好不过了。

如果要根据HTTP网络请求或用户交互后收到的数据动态更改UI，则必须使用StatefulWidget并告诉Flutter框架Widget的状态已更新，以便更新该Widget。

无状态Widget和有状态Widget之间的重要区别在于StatefulWidgets具有一个State对象，该对象存储状态数据并将其传递到树重建中，因此状态不会丢失。
```

> 项目结构和依赖

```
pubspec.yaml 
	Flutter项目的配置文件，里面包含了项目所需要的依赖，相当于RN中的 package.json 文件
	
依赖包下载地址
	https://pub.dev/flutter
	
获取项目所需要的依赖
	1、在 pubspec.yaml 中的 dependencies 配置好依赖
			dependencies:
				cupertino_icons: ^0.1.2
  			http: ^0.12.0+2
  			
  2、在项目根目录执行
  		flutter packages get
```

> Flutter 中JSON格式的转换

```
在线转换网址(json 转成 dart)
https://javiercbk.github.io/json_to_dart/
```

> Flutter 本地存储

```
shared_preferences
```

> Flutter中的列表

```
可展开的列表
ExpansionTile
```

> 和视图相关

```
获取屏幕宽高
MediaQuery.of(context).size.width
MediaQuery.of(context).size.height
```

> 各个组件特性分析

```
# Expanded
	能自动适应宽度(里面有个属性 flex:1 就会自动适应剩余的宽度)
	
# GestureDetector
	给组件添加点击事件
```

## Flutter 与 Android混合开发

> 创建Flutter module【和原生应用处于同一级】

```
flutter create -t module flutter_module

环境配置参考:
https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps
```

> Java代码中调用Flutter Module

```
Flutter.createView

FlutterFragment
```

## Flutter 与 iOS混合开发

```
环境配置参考:
https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps
```

> OC代码中调用Flutter代码

```
方式1：FlutterViewController

方式2：FlutterEngine
```

> 混合开发中开启热重载

```
flutter attach -d <deviceId>
```

> Flutter与iOS混合开发中调试Dart代码

```
1、关闭模拟器正在运行的App

2、在 Android Studio 中通过图形化工具执行 Flutter Attach

3、在 Dart 代码中打断点

4、在模拟器中启动之前关闭的App
```

## Flutter 与 Native 通信机制

> Flutter与Native通信【Channel】
```
# BasicMessageChannel
	持续的双向通信，Flutter可以给Native发消息并且接收消息，Native也可以给Flutter发消息并且接收消息

# MethodChannel
	Flutter调用Native的方法，比如Flutter调用Native的相机，实现拍照功能

# EventChannel
	非持续性的双向通信，例如Flutter中监听Native中手机电量、网络状态的变化
```
> 注意点

```
Flutter中消息的传递完全是异步的
```

> Flutter 与 iOS通信

> BasicMessageChannel
```
# iOS端
sendMessageHandler
接收Flutter端发来的消息

sendMessage
发送消息给Flutter端

# Flutter端
sendMessageHandler
接收Native端发来的消息

Future<T> send
传递数据给Native端，可以通过Future获取到Native端返回的结果
```

> MethodChannel

```
# iOS端
setMethodCallHandler
接收处理Flutter传递过来的函数

# Flutter端
Future<T> invokeMethod
Flutter调用Native的方法
```

> EventChannel

```
# iOS端
setStreamHandler


# Flutter端
Stream<dynamic> receiveBroadcastStream([dynamic arguments])
dynamic arguments 监听事件时向Native传递的数据
```

