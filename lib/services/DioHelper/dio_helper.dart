import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:quranapp/services/CacheHelper/cache_helper.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'http://132.209.87.189/api',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> queries,
    String token,
  }) async {
    dio.options.headers = getHeaders();
    try {
      return await dio.get(url, queryParameters: queries);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Response> postData({
    String url,
    // String token,
    // Map<String, dynamic> queries,
    Map<String, dynamic> data,
  }) async {
    dio.options.headers = getHeaders();
    try {
      return await dio.post(url, data: data);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Response> updateData({
    String url,
    // String token,
    // Map<String, dynamic> queries,
    Map<String, dynamic> data,
  }) async {
    dio.options.headers = getHeaders();
    try {
      return await dio.put(url, data: data);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Response> deleteData({
    String url,
    // String token,
    // Map<String, dynamic> queries,
    Map<String, dynamic> data,
  }) async {
    dio.options.headers = getHeaders();
    try {
      return await dio.delete(url, data: data);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Map<String, dynamic> getHeaders() {
    String token = CacheHelper.getToken(key: 'token');
    Map<String, dynamic> headers = token == null
        ? {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
        : {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          };
    return headers;
  }
}
