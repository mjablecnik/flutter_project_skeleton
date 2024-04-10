import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/clients/http_client.dart';
import 'package:flutter_project_skeleton/data/entities/cat.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';

class RestApiService {
  RestApiService({required HttpClient httpClient}) {
    _api = httpClient;
    _client = httpClient.dio;
  }

  late final Dio _client;
  late final HttpClient _api;

  bool setBasicAuth(String userName, String password) {
    try {
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$userName:$password'))}';
      _client.options.headers['authorization'] = basicAuth;
      return true;
    } catch (e) {
      logger.error(e);
      return false;
    }
  }

  bool removeBasicAuth() {
    try {
      if (_client.options.headers.containsKey('authorization')) {
        _client.options.headers.remove('authorization');
      }
      return true;
    } catch (e) {
      logger.error(e);
      return false;
    }
  }

  Future<User> getUser(String userName) async {
    Future.delayed(const Duration(seconds: 1));
    return User(firstName: "John", lastName: "Doe", userName: userName);
  }

  Future<List<Cat>> getCats() async {
    return _api.createRequest(
      () => _client.get('/v1/images/search?limit=10'),
      (data) async => [...data.map((e) => Cat.fromJson(e))],
    );
  }
}
