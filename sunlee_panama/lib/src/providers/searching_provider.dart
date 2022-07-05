import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/models/products_model.dart';
import 'package:sunlee_panama/src/services/request/products_service.dart';

class SearchingProvider extends ChangeNotifier {
  String _searchingData = '';
  bool _isSearching = false;
  bool _loadingMore = false;
  ProductsService productsService = ProductsService();
  List<Product> _products = [];
  List<Product> _most_wanted = [];
  List<Product> _recomended = [];
  List<Product> _buyed = [];
  String _SelectedCategory = "0";
  List<dynamic> _categories = [];
  int _current_page = 1;

  String get searchingData => _searchingData;
  bool get isSearching => _isSearching;
  bool get loadingMore => _loadingMore;
  String get selectedCategorie => _SelectedCategory;

  set selectedCategorie(String value) {
    _SelectedCategory = value;
    notifyListeners();
  }

  set searching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  set loadingMore(bool value) {
    _loadingMore = value;
    notifyListeners();
  }

  set fillProducts(List<Product> value) {
    _products = value;
    notifyListeners();
  }

  List<Product> get products => _products;
  List<Product> get wanted => _most_wanted;
  List<Product> get buyed => _buyed;
  List<Product> get recomended => _recomended;

  List<dynamic> get categories => _categories;

  String get searchData => _searchingData;

  void loadCategories() {
    _categories = [];
    _categories.add({"category_name": "TODAS", "id_cat": "0"});
    productsService.getCategories().then((value) {
      _categories.addAll(value);
      notifyListeners();
    });
  }

  void searchingDataFn(String value) async {
    searching = true;
    _current_page = 1;
    _searchingData = value;
    _products = (value == '')
        ? await productsService.getProducts('recent', _SelectedCategory)
        : await productsService.searchProducts(value, _SelectedCategory);
    _isSearching = false;
    notifyListeners();
  }

  void loadMore(String value) async {
    _current_page++;
    loadingMore = true;
    _searchingData = value;
    _products.addAll(await productsService.loadMore(
        'recent', _SelectedCategory, value, _current_page));
    loadingMore = false;
    notifyListeners();
  }

  initializeProducts() async {
    searching = true;
    _current_page = 1;
    loadCategories();
    _products = await productsService.getProducts('recent', _SelectedCategory);
    _buyed = await productsService.getMostBuyed();
    _most_wanted = await productsService.getMostWanted();
    _recomended = await productsService.getRecomended();
    searching = false;
  }
}
