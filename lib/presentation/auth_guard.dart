import 'package:flutter/material.dart';
import 'package:product_explorer/presentation/home_screen.dart';
import 'package:product_explorer/presentation/login_screen.dart';
import 'package:product_explorer/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isAuthenticated) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return authProvider.isAuthenticated
        ? const HomeScreen()
        : const LoginScreen();
  }
}
