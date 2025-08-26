import 'package:product_explorer/domain/base/login_exception.dart';
import 'package:product_explorer/domain/request_models/login_request.dart';
import 'package:product_explorer/presentation/home_screen.dart';
import 'package:product_explorer/presentation/widgets/login_error_bottom_sheet.dart';
import 'package:product_explorer/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordVisibility = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
  if (_formKey.currentState!.validate()) {
    var request = LoginRequest(
      email: _emailController.text,
      password: _passwordController.text,
    );
    try {
      final authProvider = context.read<AuthProvider>();
      await authProvider.login(request);
      if(authProvider.isAuthenticated){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
    } on LoginException catch (exception) {
      _showError(exception.toString());
    } on Exception catch (exception) {
      _showError("An unexpected error occurred: ${exception.toString()}");
    }
  }
}

  void _showError(String message) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return LoginErrorBottomSheet(message: message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 200, 241, 253),
      body: Center(        
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            border: Border(right: BorderSide()),
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 202, 237, 255),
          ),
          child: SizedBox(
            height: 600,
            width: 300,
            child: Padding(
              
              padding: EdgeInsets.zero,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock),
                    const Text("Login", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 100),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !passwordVisibility,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                          icon: Icon(
                            passwordVisibility ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height:45,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: _login,
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      
    );
  }
}
