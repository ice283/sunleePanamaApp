import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/models/cart_model.dart';
import 'package:sunlee_panama/src/models/products_model.dart';

class CartNotifier extends ChangeNotifier {
  int items = 0;
  Cart cart = Cart.isEmpty();

  void addItem(CartItem cartItem) {
    cart.addToCart(cartItem);
    items = cart.items;
    notifyListeners();
  }

  void removeItem(String idProduct) {
    cart.removeFromCart(idProduct);
    items = cart.items;
    notifyListeners();
  }

  void addOne(String idProduct) {
    cart.addOne(idProduct);
    notifyListeners();
  }

  void removeOne(String idProduct) {
    cart.removeOne(idProduct);
    notifyListeners();
  }

  void emptyCart() {
    items = 0;
    cart = Cart.isEmpty();
    notifyListeners();
  }

  void loadCart(String jsonCart) {
    cart = Cart.fromJson(jsonCart);
    items = cart.products.length;
    notifyListeners();
  }
}
