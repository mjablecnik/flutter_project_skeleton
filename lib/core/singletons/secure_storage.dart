import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  late final FlutterSecureStorage storage;

  static final SecureStorage get = SecureStorage._initialize();

  SecureStorage._initialize() {
    storage = const FlutterSecureStorage();
  }

  Future<void> remove(String key) {
    return storage.delete(key: key);
  }

  Future<void> saveString(String key, String value) {
    return storage.write(key: key, value: value);
  }

  Future<String?> getString(String key) {
    return storage.read(key: key);
  }

  Future<void> saveMap(String key, Map value) {
    return storage.write(key: key, value: json.encode(value));
  }

  Future<dynamic> getMap(String key) {
    return json.decode(storage.read(key: key).toString());
  }
}
