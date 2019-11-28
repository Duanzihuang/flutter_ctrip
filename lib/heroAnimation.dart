import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue), home: HeroAnimation()));
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(photo, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timeDilation = 10.0; // 1.0 means normal animation speed.
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo:
              'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574863884536&di=747d4cbb815c2645a9ec7dd457929c24&imgtype=0&src=http%3A%2F%2Fpic162.nipic.com%2Ffile%2F20180424%2F25159533_220757424034_2.jpg',
          width: 300,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute<void>(builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(title: const Text('Flippers Page')),
                body: Container(
                  color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    photo:
                        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574863884536&di=747d4cbb815c2645a9ec7dd457929c24&imgtype=0&src=http%3A%2F%2Fpic162.nipic.com%2Ffile%2F20180424%2F25159533_220757424034_2.jpg',
                    width: 100.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }));
          },
        ),
      ),
    );
  }
}
