import 'package:flutter_ctrip/model/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const HOME_URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao{
  static Future<HomeModel> fetch() async{
    final response = await http.get(HOME_URL);

    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码的问题

      var result = json.decode(utf8decoder.convert(response.bodyBytes));

      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page json');
    }
  }
}