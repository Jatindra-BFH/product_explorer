import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:product_explorer/presentation/login_screen.dart';
import 'package:product_explorer/presentation/main_screen.dart';
import 'package:product_explorer/provider/auth_provider.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  MockAuthProvider mockAuthProvider = MockAuthProvider();

  Future<void> pumpLoginScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>.value(
        value: mockAuthProvider,
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
  }
  group('LoginScreen Widget Tests', () {
    testWidgets('shows validation errors when fields are empty', (tester) async {
      await pumpLoginScreen(tester);

      // Tap login without entering any data
      await tester.tap(find.text('Login').last);
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);
    });
    testWidgets('successful login navigates to MainScreen', (tester) async {
      when(mockAuthProvider.isAuthenticated).thenReturn(true);
      when(mockAuthProvider.email).thenReturn('test@example.xom');
      when(mockAuthProvider.login(any)).thenAnswer((_) async {});

      await pumpLoginScreen(tester);

      // Enter valid email and password
      await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');

      await tester.tap(find.text('Login').last);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      // Verify MainScreen is shown
      expect(find.byType(MainScreen), findsOneWidget);
    });
  });
}