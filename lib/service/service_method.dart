import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

//获取首页主题内容
Future getHomePageContnet() async {
  try {
    print('开始获取首页数据................');
    Response response;
    Dio dio = Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContext'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后段接口出现异常.');
    }
  } catch (e) {
    return print('ERROR:====================>$e');
  }
}
