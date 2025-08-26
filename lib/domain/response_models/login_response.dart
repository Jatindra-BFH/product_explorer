class LoginResponse {
  final String? accessToken;
  final String? refreshToken;
  LoginResponse({required this.accessToken, required this.refreshToken});
  factory LoginResponse.fromJson(Map<String, dynamic> jsonData){
    return LoginResponse(
      accessToken: jsonData['access_token'], 
      refreshToken: jsonData['refresh_token'], 
      );
  }
}