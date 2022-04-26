import 'dart:convert';

class Cart {
  String idCart;
  String idClient;
  List<CartItem> products = [];
  Cart({
    required this.idCart,
    required this.idClient,
    required this.products,
  });
  Cart.isEmpty()
      : this(
          idCart: '',
          idClient: '',
          products: [],
        );

  void addToCart() {
    print('addToCart');
  }

  void removeFromCart() {
    print('addToCart');
  }

  Map<String, dynamic> toMap() {
    return {
      'idCart': idCart,
      'idClient': idClient,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      idCart: map['idCart'] ?? '',
      idClient: map['idClient'] ?? '',
      products:
          List<CartItem>.from(map['products']?.map((x) => CartItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}

class CartItem {
  String idCart;
  String idProduct;
  int quantity;
  double price;
  double total;
  String image;
  CartItem({
    required this.idCart,
    required this.idProduct,
    required this.quantity,
    required this.price,
    required this.total,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCart': idCart,
      'idProduct': idProduct,
      'quantity': quantity,
      'price': price,
      'total': total,
      'image': image,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      idCart: map['idCart'] ?? '',
      idProduct: map['idProduct'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      total: map['total']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));
}
