import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/src/client.dart';
import 'package:product_explorer/domain/data_models/product.dart';
import 'package:product_explorer/domain/data_models/products.dart';
import 'package:product_explorer/domain/data_models/user.dart';
import 'package:product_explorer/domain/request_models/login_request.dart';
import 'package:product_explorer/presentation/main_screen.dart';
import 'package:product_explorer/presentation/product_explorer_screen.dart';
import 'package:product_explorer/presentation/settings_screen.dart';
import 'package:product_explorer/presentation/about_screen.dart';
import 'package:product_explorer/presentation/home_screen.dart';
import 'package:product_explorer/provider/auth_provider.dart';
import 'package:product_explorer/provider/data_provider.dart';
import 'package:product_explorer/provider/layout_utilities_provider.dart';
import 'package:product_explorer/utilities/layout_type.dart';
import 'package:provider/provider.dart';

import '../mocks/mocks.mocks.dart';
class FakeAuthProvider extends ChangeNotifier implements AuthProvider {
  String _email = 'test@example.com';
  @override
  String get email => _email;

  @override
  Future<void> checkAuthStatus() async{
    
  }

  @override
  bool get isAuthenticated => true;

  @override
  Future<void> login(LoginRequest loginRequest) async{
  }

  @override
  Future<void> logout() async{
    
  }

  @override
  Box<User> get box => MockBox();

  @override
  Client get httpClient => throw UnimplementedError();
}
class FakeDataProvider extends ChangeNotifier implements DataProvider{
  @override
  Box<Products> get box => Hive.box('product_explorer');

  @override
  bool get isLoading => false;
  
  List<Product> _products = [];
  @override
  List<Product> get products => _products;

  @override
  Future<void> retrieveProducts() async {
  }

  @override
  Future<void> retrieveProductsFromHive() async{
  }

  @override
  void storeProductsInHive(List<Product> products) {
  }
  
  @override
  // TODO: implement httpClient
  Client get httpClient => throw UnimplementedError();

}
class FakeLayoutUtilitiesProvider extends ChangeNotifier implements LayoutUtilitiesProvider{
  @override
  int get gridSize => 6;

  @override
  LayoutType get layoutType => LayoutType.grid;

  @override
  void setGridSize(int? newGridSize) async{
  }

  @override
  void setLayoutType(LayoutType layoutType) async{
  }

  @override
  void setTextSize(double textSize) async{
  }

  @override
  void setTextStyle(TextStyle textStyle) async{
  }

  @override
  double get textSize => 20;

  @override
  TextStyle get textStyle => GoogleFonts.merriweather();

}
void main() {
  
  Widget createMainScreenTestWidget() {
      return MultiProvider( 
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => FakeAuthProvider()),
          ChangeNotifierProvider<DataProvider>(create: (_)=> FakeDataProvider()),
          ChangeNotifierProvider<LayoutUtilitiesProvider>(create: (_)=> FakeLayoutUtilitiesProvider()),
          ],
          child: MaterialApp(
            home: MainScreen(),
      )
    );
  }
  testWidgets('End Drawer navigation works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createMainScreenTestWidget());
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, 'Products'));
    await tester.pumpAndSettle();

    expect(find.byType(ProductExplorerScreen), findsOneWidget);
    expect(find.text('Product Explorer'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, 'Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
    //expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, 'About the developer'));
    await tester.pumpAndSettle();

    expect(find.byType(AboutScreen), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });
}
