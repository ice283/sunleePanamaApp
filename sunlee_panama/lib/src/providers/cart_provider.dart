import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/models/cart_model.dart';
import 'package:sunlee_panama/src/models/order_list.dart';
import 'package:sunlee_panama/src/models/products_model.dart';
import 'package:sunlee_panama/src/services/request/order_service.dart';
import 'package:uuid/uuid.dart';

class CartNotifier extends ChangeNotifier {
  int items = 0;
  Cart cart = Cart.isEmpty();
  UploadOrderProvider uploadOrderProvider = UploadOrderProvider();

  void addItem(CartItem cartItem) {
    cart.addToCart(cartItem);
    items = cart.items;
    notifyListeners();
  }

  void setClient(String client) {
    cart.idClient = client;
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

  Future<bool> sendOrder() async {
    UploadOrderProvider uploadOrderProvider = UploadOrderProvider();
    OrderDocument orderDocument = OrderDocument.fromJsonMap({
      'id': 1,
      'idClient': cart.idClient,
      'dateOrder': DateTime.now().toString(),
      'idSeller': 12,
      'status_send': 1,
      'totalDocument': cart.totalCart,
    });
    cart.products.forEach((product) {
      orderDocument.addItem(OrderItem.fromJsonMap(
        {
          'id': 1,
          'productId': product.idProduct,
          'productName': product.productName,
          'idOrder': 1,
          'productQuantity': product.quantity,
          'productSalePrice': product.price,
        },
      ));
    });
    await uploadOrderProvider.send(orderDocument.toJson());
    return true;
  }
}
