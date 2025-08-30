import 'package:hive/hive.dart';
import 'package:product_explorer/domain/data_models/products.dart';
import 'package:product_explorer/domain/data_models/product.dart' as model;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:product_explorer/domain/data_models/product.dart';
class DataProvider with ChangeNotifier{
  List<model.Product> _products = [];
  List<model.Product> get products => _products;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final Box<Products> box;
  final http.Client httpClient;
  DataProvider({required this.box, required this.httpClient});
  void storeProductsInHive(List<Product> products) => box.put('products', Products(products));
  Future<void> retrieveProductsFromHive() async => _products = box.get('products')!.products;
  
  Future<void> retrieveProducts() async {
    _isLoading = true;
    final response = await httpClient.get(Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['products'];
      storeProductsInHive(jsonList.map((json) => Product.fromJson(json)).toList());
      retrieveProductsFromHive();
      _isLoading = false;
      notifyListeners();
    } 
    else{
      _isLoading = false;
      notifyListeners();
      throw Exception("Bad request");
    }
  }
}
