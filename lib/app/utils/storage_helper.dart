import 'package:get_storage/get_storage.dart';



class StorageHelper {
  static final _storage = GetStorage();
  static const _tokenKey = 'auth_token';
  static const _userDataKey = 'user_data';

// ==========================
// Token Management
  static Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  static String? getToken() {
    return _storage.read(_tokenKey);
  }

  static Future<void> clearToken() async {
    await _storage.remove(_tokenKey);
  }

// ==========================
// User Data Management

  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _storage.write(_userDataKey, userData);
  }

  static Map<String, dynamic>? getUserData() {
    return _storage.read(_userDataKey);
  }

  static Future<void> clearUserData() async {
    await _storage.remove(_userDataKey);
  }

}
