import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_explorer/domain/data_models/user.dart';
import 'package:product_explorer/presentation/login_screen.dart';
import 'package:product_explorer/presentation/main_screen.dart';
import 'package:product_explorer/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final box = Hive.box<User>('user');
    if (authProvider.isAuthenticated) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return box.get('access_token')!=null
        ? MainScreen()
        : LoginScreen();
  }
}
