import 'package:product_explorer/domain/base/login_exception.dart';
import 'package:product_explorer/domain/request_models/login_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  final _storage = FlutterSecureStorage();
  String _email = "";
  String get email => _email;
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  String _authToken = "";
  String get authToken => _authToken;
  Future<void> login(LoginRequest loginRequest) async {
    final response = await http.post(Uri.parse("https://api.escuelajs.co/api/v1/auth/login"), body: loginRequest.toJson(),);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await _storage.write(key: 'accessToken', value: data['access_token']);
      _isAuthenticated = true;
      _authToken = data['access_token'];
      _email = loginRequest.email;
      notifyListeners();
    } else if(response.statusCode==400){
      throw Exception("Bad request");
    }
    else if(response.statusCode==401){
      throw LoginException(errorCode: 401, errorMessage: "Invalid credentials");
    }
    else if(response.statusCode==403){
      throw LoginException(errorCode: 403, errorMessage: "Insufficient permissions");
    }
    else{
      throw Exception();
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
    _isAuthenticated = false;
    _authToken = "";
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    final token = await _storage.read(key: 'token');
    _isAuthenticated = token != null;
    notifyListeners();
  }
}
