import 'dart:convert';

class OrderDocument {
  List<OrderItem> _items = [];
  double _totalDocument = 0.0;
  late int id;
  late String idClient;
  late String dateOrder;
  late String idSeller;
  late int status_send;

  OrderDocument({
    required this.id,
    required this.idClient,
    required this.dateOrder,
    required this.idSeller,
    required this.status_send,
  });

  double get totalDocument {
    return _totalDocument;
  }

  void addItem(OrderItem item) {
    _items.add(item);
    _totalDocument += item.subtotalProduct;
  }

  OrderDocument.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'] as int;
    idClient = json['idClient'].toString();
    dateOrder = json['dateOrder'].toString();
    idSeller = json['idSeller'].toString();
    _totalDocument = json['totalDocument'].toDouble();
    status_send = json['status_send'] as int;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'idClient': idClient,
        'dateOrder': dateOrder,
        'idSeller': idSeller,
        'totalDocument': _totalDocument,
        'items': _items.map((e) => e.toJson()).toList(),
      };
}

class OrderItem {
  double subtotalProduct = 0.0;
  late int? id;
  late String idProduct;
  late String productName;
  late int? idOrder;
  late int quantityProduct;
  late double priceProduct;

  OrderItem({
    required this.idProduct,
    required this.productName,
    required this.idOrder,
    required this.quantityProduct,
    required this.priceProduct,
  });
  OrderItem.fromJsonMap(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'] as int;
    idProduct = json['productId'].toString();
    idOrder = (json['idOrder'] == null) ? null : json['idOrder'] as int;
    productName = json['productName'].toString();
    quantityProduct = json['productQuantity'] as int;
    priceProduct = json['productSalePrice'].toDouble();
    subtotalProduct = quantityProduct.toDouble() * priceProduct.toDouble();
  }

  set productQuantity(int productQuantity) {}

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_product': idProduct,
        'idOrder': idOrder,
        'product_name_temp': productName,
        'quantity_product': quantityProduct,
        'product_sale_price': priceProduct,
      };
}
