import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestService extends ChangeNotifier {
  void getApi() async {
    var option = BaseOptions(
      baseUrl: 'https://openapi.naver.com/v1/search/movie.json',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    // Response res = await Dio().get();
  }
}
