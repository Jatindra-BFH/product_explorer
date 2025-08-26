import 'package:product_explorer/domain/base/product.dart' as model;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:product_explorer/domain/base/product.dart';
class DataProvider with ChangeNotifier{
  List<model.Product> _products = [];
  List<model.Product> get products => _products;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  /*
  Box box = Hive.box<Product>('product_explorer');
  void storeProductsInHive(List<Product> products){
    for(var product in products){
      box.put(product.id, product);
    }
  }*/
  Future<void> retrieveProducts() async {
    _isLoading = true;
    final response = await http.get(Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['products'];
      _products = jsonList.map((json) => Product.fromJson(json)).toList();
      //storeProductsInHive(_products);
      _isLoading = false;
      notifyListeners();
    } 
    else{
      _isLoading = false;
      notifyListeners();
      throw Exception("Bad request");
      //await retrieveProductsFromHive();
    }
  }
  Future<void> retrieveProductsFromHive() async {
  //  _products = box.values.cast<Product>().toList();
    _isLoading = false;
    notifyListeners();
  }
}
