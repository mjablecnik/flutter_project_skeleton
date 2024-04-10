import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  late final FlutterSecureStorage _storage;

  SecureStorage() {
    _storage = const FlutterSecureStorage();
  }

  Future<void> remove(String key) {
    return _storage.delete(key: key);
  }

  Future<void> saveString(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  Future<String?> getString(String key) {
    return _storage.read(key: key);
  }

  Future<void> saveMap(String key, Map value) {
    return _storage.write(key: key, value: json.encode(value));
  }

  Future<dynamic> getMap(String key) async {
    return json.decode((await _storage.read(key: key)).toString());
  }
}
