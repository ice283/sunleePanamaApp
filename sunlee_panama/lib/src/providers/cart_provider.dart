import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/models/cart_model.dart';
import 'package:sunlee_panama/src/models/products_model.dart';

class CartNotifier extends ChangeNotifier {
  int items = 0;
  Cart cart = Cart.isEmpty();
  List<CartItem> products = [];

  void addItem(Product product) {
    items++;
    notifyListeners();
  }

  void removeItem(Product product) {
    items--;
    notifyListeners();
  }

  void emptyCart() {
    items = 0;
    cart = Cart.isEmpty();
    products = [];
    notifyListeners();
  }

  void loadCart(String jsonCart){
    cart = Cart.fromJson(jsonCart);
    products = cart.products;
    items = cart.products.length;
    notifyListeners();
  }
}
