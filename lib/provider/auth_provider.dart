import 'package:hive/hive.dart';
import 'package:product_explorer/domain/data_models/user.dart';
import 'package:product_explorer/domain/base/login_exception.dart';
import 'package:product_explorer/domain/request_models/login_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String _email = "";
  String get email => _email;
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  final Box<User> box;
  final http.Client httpClient;
  AuthProvider({ required this.box, required this.httpClient});
  Future<void> login(LoginRequest loginRequest) async {
    final response = await http.post(Uri.parse("https://api.escuelajs.co/api/v1/auth/login"), body: loginRequest.toJson(),);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      box.put('currentUser', User(accessToken: data['access_token'], refreshToken: data['refresh_token']));
      _isAuthenticated = true;
      _email = loginRequest.email;
      notifyListeners();
    }
    else if(response.statusCode==401){
      throw LoginException(errorCode: 401, errorMessage: "Invalid credentials");
    }
    else if(response.statusCode==403){
      throw LoginException(errorCode: 403, errorMessage: "Insufficient permissions");
    }
    else{
      throw LoginException(errorCode: 400, errorMessage: "Bad request");
    }
  }

  Future<void> logout() async {
    box.delete('currentUser');
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    final token = box.isEmpty?null:box.get('currentUser')?.accessToken;
    _isAuthenticated = token != null;
    notifyListeners();
  }
}
