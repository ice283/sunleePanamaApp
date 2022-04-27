import 'dart:convert';

class Cart {
  String idCart;
  String idClient;
  double _totalCart = 0;
  List<CartItem> products = [];
  int items = 0;
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

  void recalculate() {
    _totalCart = 0;
    items = 0;
    products.forEach((element) {
      _totalCart += element.total;
      items++;
    });
  }

  double get totalCart => _totalCart;

  void addOne(String idProduct) {
    products.forEach((element) {
      if (element.idProduct == idProduct) {
        element.quantity++;
        element.total = element.quantity * element.price;
      }
    });
    recalculate();
  }

  void removeOne(String idProduct) {
    products.forEach((element) {
      if (element.idProduct == idProduct) {
        if (element.quantity > 1) {
          element.quantity--;
          element.total = element.quantity * element.price;
        }
      }
    });
    recalculate();
  }

  void addToCart(CartItem cartItem) {
    products.firstWhere(
        (element) => () {
              if (element.idProduct == cartItem.idProduct) {
                element.quantity += cartItem.quantity;
                element.price = cartItem.price;
                element.total = element.price * element.quantity;
                return true;
              }
              return false;
            }(), orElse: () {
      try {
        products.add(cartItem);
        return cartItem;
      } catch (e) {
        rethrow;
      }
    });
    recalculate();
  }

  void removeFromCart(String idProduct) {
    products.removeWhere((element) => element.idProduct == idProduct);
    items = products.length;
    recalculate();
  }

  Map<String, dynamic> toMap() {
    recalculate();
    return {
      'idCart': idCart,
      'idClient': idClient,
      'items': items,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      idCart: map['idCart'] ?? '',
      idClient: map['idClient'] ?? '',
      products:
          List<CartItem>.from(map['products']?.map((x) => CartItem.fromMap(x))),
    ).items = map['items'] ?? 0;
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) {
    final ct = Cart.fromMap(json.decode(source));
    ct.recalculate();
    return ct;
  }
}

class CartItem {
  String idCart;
  String idProduct;
  String productName;
  int quantity;
  double price;
  late double total = quantity * price;
  String image;
  CartItem({
    required this.idCart,
    required this.idProduct,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.image,
  }) {
    total = quantity * price;
  }

  Map<String, dynamic> toMap() {
    return {
      'idCart': idCart,
      'idProduct': idProduct,
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'total': total,
      'image': image,
    };
  }

  void addOne() {
    quantity++;
    total = quantity * price;
  }

  void removeOne() {
    if (quantity > 1) {
      quantity--;
      total = quantity * price;
    }
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    final tt = map['price']?.toDouble() * map['quantity']?.toDouble();
    return CartItem(
      idCart: map['idCart'] ?? '',
      idProduct: map['idProduct'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));
}
