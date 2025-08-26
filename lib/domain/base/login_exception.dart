class LoginException implements Exception {
  final int? errorCode;
  final String? errorMessage;
  LoginException({this.errorCode, this.errorMessage});
  @override
  String toString() => "$errorMessage";
}