import 'dart:convert';
import 'package:uuid/uuid.dart';

class OrderDocument {
  List<OrderItem> _items = [];
  double _totalDocument = 0.0;
  late int id;
  late String idClient;
  late String clientName;
  late String dateOrder;
  late String idSeller;
  late String sellerName;
  late int status_send;
  OrderDocument({
    required this.id,
    required this.idClient,
    required this.clientName,
    required this.dateOrder,
    required this.idSeller,
    required this.sellerName,
    required this.status_send,
  });

  double get totalDocument {
    return _totalDocument;
  }

  OrderDocument.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'] as int;
    idClient = json['idClient'].toString();
    clientName = json['clientName'].toString();
    dateOrder = json['dateOrder'].toString();
    idSeller = json['idSeller'].toString();
    sellerName = json['sellerName'].toString();
    _totalDocument = json['totalDocument'].toDouble();
    status_send = json['status_send'] as int;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'idClient': idClient,
        'clientName': clientName,
        'dateOrder': dateOrder,
        'idSeller': idSeller,
        'sellerName': sellerName,
        'totalDocument': _totalDocument,
        'items': [],
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
