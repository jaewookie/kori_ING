import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kori_test_refactoring/Utills/callApi.dart';
import 'package:kori_test_refactoring/screens/MainScreen.dart';

class GetApi{
  final String? url;
  final String? endadr;

  GetApi({this.url, this.endadr});

  Future<dynamic> Getting() async {
    String host = url!;
    String endPoint = endadr!;
    String apiAddress = host + endPoint;

    NetworkGet network = NetworkGet(apiAddress);

    dynamic getApiData = await network.getAPI();

    print('b: $getApiData');

    return getApiData;
  }
}