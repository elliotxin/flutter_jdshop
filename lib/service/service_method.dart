import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

Future request(url, {formData}) async {
  try {
    // print('开始获取数据................');
    Response response;
    Dio dio = Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后段接口出现异常.');
    }
  } catch (e) {
    return print('ERROR:====================>$e');
  }
}
