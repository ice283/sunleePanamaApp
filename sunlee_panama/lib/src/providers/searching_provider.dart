import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/models/products_model.dart';
import 'package:sunlee_panama/src/services/request/products_service.dart';

class SearchingProvider extends ChangeNotifier {
  String _searchingData = '';
  bool _isSearching = false;
  ProductsService productsService = ProductsService();
  List<Product> _products = [];

  String get searchingData => _searchingData;
  bool get isSearching => _isSearching;

  set searching(bool value) {
    _isSearching = value;
  }

  List<Product> get products => _products;

  void searchingDataFn(String value) async {
    searching = true;
    _searchingData = value;
    _products = await productsService.searchProducts(value);
    _isSearching = false;
    notifyListeners();
  }

  void initializeProducts() async {
    searching = true;
    _products = await productsService.getProducts('recent');
    _isSearching = false;
    notifyListeners();
  }
}
