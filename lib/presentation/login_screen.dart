import 'package:product_explorer/domain/base/login_exception.dart';
import 'package:product_explorer/domain/request_models/login_request.dart';
import 'package:product_explorer/presentation/main_screen.dart';
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
  bool isLoading = false;
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
      setState(() {
        isLoading = true;
      });
      final authProvider = context.read<AuthProvider>();
      await authProvider.login(request);
      if(authProvider.isAuthenticated){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
      }
    } on LoginException catch (exception) {
      _showError(exception.toString());
    } on Exception catch (exception) {
      _showError("An unexpected error occurred: ${exception.toString()}");
    }finally{
      setState(() {
        isLoading = false;
      });
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
      backgroundColor: const Color.fromARGB(255, 200, 241, 253),
      body: Center(        
        child: Container(
          padding: const EdgeInsets.all(40),
          child: SizedBox(
            height: 600,
            width: 400,
            child: Padding(
              
              padding: EdgeInsets.zero,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock, size: 50,),
                    const Text("Login", style: TextStyle(fontSize: 35)),
                    const SizedBox(height: 80),
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
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 40),
                    SizedBox(
                      height:45,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _login,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        _showError("Service unavailable");
                      },
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
