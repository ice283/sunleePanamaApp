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
    notifyListeners();
  }

  set fillProducts(List<Product> value) {
    _products = value;
    notifyListeners();
  }

  List<Product> get products => _products;

  void searchingDataFn(String value) async {
    searching = true;
    _searchingData = value;
    _products = (value == '')
        ? await productsService.getProducts('recent')
        : await productsService.searchProducts(value);
    _isSearching = false;
    notifyListeners();
  }

  initializeProducts() async {
    
      searching = true;
      _products = await productsService.getProducts('recent');
      searching = false;

  }
}
