/*
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:product_explorer/domain/data_models/user.dart';
import 'package:product_explorer/domain/base/login_exception.dart';
import 'package:product_explorer/domain/request_models/login_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../mocks/mocks.mocks.dart';

// Create a mock class for http.Client
class MockHttpClient extends Mock implements http.Client {
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
        return http.Response('{}', 201);
      }


}

void main() {
  String uri = "https://api.escuelajs.co/api/v1/auth/login";
  
  // Instantiate the mock http client
  final mockHttpClient = MockHttpClient(); 

  MockBox<User> mockBox = MockBox<User>();
  MockAuthProvider authProvider = MockAuthProvider();

  group('AuthProvider', () {
    test('Successful login sets auth state and stores user', () async {
      final loginRequest = LoginRequest(email: 'test@example.com', password: 'password123');
      final responseJson = {
        'access_token': 'fakeAccessToken',
        'refresh_token': 'fakeRefreshToken',
      };
      
      // Corrected: Ensure a Future<http.Response> is returned
      when(mockHttpClient.post(
        Uri.parse(uri),
        body: any,
      )).thenAnswer((_) async => http.Response(jsonEncode(responseJson), 201));

      // Corrected: Handle the return value of the put method
      when(mockBox.put('currentUser', any)).thenAnswer((_) async => null);

      await authProvider.login(loginRequest);

      expect(authProvider.isAuthenticated, true);
      expect(authProvider.email, 'test@example.com');
      verify(mockBox.put('currentUser', any)).called(1);
    });

    test('Login with wrong credentials throws LoginException 401', () async {
      // Corrected: Ensure a Future<http.Response> is returned with a 401 status
      when(mockHttpClient.post(
        Uri.parse(uri),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Unauthorized', 401));

      expect(
        () async => await authProvider.login(LoginRequest(email: 'wrong@example.com', password: 'wrongpassword')),
        throwsA(isA<LoginException>().having((e) => e.errorCode, 'errorCode', 401)),
      );
    });

    test('Login with 403 throws LoginException 403', () async {
      // Corrected: Ensure a Future<http.Response> is returned with a 403 status
      when(mockHttpClient.post(
        Uri.parse(uri),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Forbidden', 403));

      expect(
        () async => await authProvider.login(LoginRequest(email: 'test@example.com', password: 'password123')),
        throwsA(isA<LoginException>().having((e) => e.errorCode, 'errorCode', 403)),
      );
    });

    test('Logout clears user and resets auth state', () async {
      // Corrected: Handle the return value of the delete method
      when(mockBox.delete('currentUser')).thenAnswer((_) async => null);

      await authProvider.logout();

      expect(authProvider.isAuthenticated, false);
      verify(mockBox.delete('currentUser')).called(1);
    });

    test('checkAuthStatus sets isAuthenticated correctly when token exists', () async {
      final user = User(accessToken: 'token123', refreshToken: 'refresh123');

      when(mockBox.isEmpty).thenReturn(false);
      when(mockBox.get('currentUser')).thenReturn(user);

      await authProvider.checkAuthStatus();

      expect(authProvider.isAuthenticated, true);
    });

    test('checkAuthStatus sets isAuthenticated false when no token', () async {
      when(mockBox.isEmpty).thenReturn(true);

      await authProvider.checkAuthStatus();

      expect(authProvider.isAuthenticated, false);
    });
  });
}
*/