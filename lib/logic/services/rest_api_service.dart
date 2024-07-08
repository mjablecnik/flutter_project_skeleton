import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/clients/http_client.dart';
import 'package:flutter_project_skeleton/data/entities/product.dart';
import 'package:flutter_project_skeleton/data/entities/user.dart';
import 'package:mocktail/mocktail.dart';

class MockRestApiService extends Mock implements RestApiService {}

class RestApiService {
  RestApiService({required HttpClient httpClient}) {
    _api = httpClient;
    _client = httpClient.dio;
  }

  late final Dio _client;
  late final HttpClient _api;

  bool _handleError(Function() callback) {
    try {
      callback.call();
      return true;
    } catch (e) {
      logger.handle(e);
      return false;
    }
  }

  bool setBasicAuth(String userName, String password) {
    return _handleError(() {
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$userName:$password'))}';
      _client.options.headers['authorization'] = basicAuth;
    });
  }

  bool setAuthToken(String token) {
    return _handleError(() {
      _client.options.headers['authorization'] = token;
    });
  }

  bool removeAuth() {
    return _handleError(() {
      if (_client.options.headers.containsKey('authorization')) {
        _client.options.headers.remove('authorization');
      }
    });
  }

  Future<User> login(String userName, String password) {
    return _api.createRequest(
      () => _client.post('/auth/login', data: {
        'username': userName,
        'password': password,
      }),
      (data) async => User.fromJson(data),
    );
  }

  Future<User> getLoggedUser() async {
    return _api.createRequest(
      () => _client.get('/auth/me'),
      (data) async => User.fromJson(data),
    );
  }

  Future<User> getUser(String userName) async {
    Future.delayed(const Duration(seconds: 1));
    return User(firstName: "John", lastName: "Doe", userName: userName);
  }

  Future<List<Product>> getProducts() async {
    return _api.createRequest(
      () => _client.get('/products'),
      (data) async => [...data["products"].map((e) => Product.fromJson(e))],
    );
  }
}
