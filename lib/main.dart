import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:product_explorer/domain/data_models/product.dart';
import 'package:product_explorer/domain/data_models/products.dart';
import 'package:product_explorer/domain/data_models/user.dart';
import 'package:product_explorer/presentation/auth_guard.dart';
import 'package:product_explorer/provider/auth_provider.dart';
import 'package:product_explorer/provider/data_provider.dart';
import 'package:product_explorer/provider/layout_utilities_provider.dart';
import 'package:provider/provider.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
   Hive.registerAdapter(ProductsAdapter());
   Hive.registerAdapter(ProductAdapter());
   Hive.registerAdapter(UserAdapter());
   await Hive.openBox<Products>('product_explorer');  
   await Hive.openBox<User>('user');  
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkAuthStatus()),
        ChangeNotifierProvider(create: (_) => DataProvider()..retrieveProducts()),
        ChangeNotifierProvider(create: (_) => LayoutUtilitiesProvider())
      ],
      child: MyApp(),
    ),
  );
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JaCodPlus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.merriweatherTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 143, 196, 232)),
      ),
      home: AuthGuard(),
    );
  }
}