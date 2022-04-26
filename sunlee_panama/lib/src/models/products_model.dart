class Products {
  List<Product> items = [];

  Products.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (final item in jsonList) {
      final product = Product.fromJsonMap(item);
      items.add(product);
    }
  }
}

class Product {
  late String idProduct;
  late String bqProductCode;
  late String refProdCode;
  late String idCat;
  late String idSuplier;
  late String productName;
  late String productAltName;
  late double productCost;
  late double productTax;
  late double productSalePrice;
  late double productSalePrice2;
  late double productSalePrice3;
  late double productDiscount;
  late double productDiscountAlt;
  late String idStorage;
  late String productRegDate;
  late String productLimitDate;
  late String prodLastModDate;
  late String lastSaleDate;
  late String quantityAlert;
  late int statusQuantityAlert;
  late String model;
  late String brand;
  late int status;
  late String location;
  late int deadlineDays;
  late String aupsa;
  late String expiration;
  late int frozen;
  late int idInventoryUnit;
  late String packageProductId;
  late String categoryName;
  late String imagen;
  late String storageName;
  late double exist;
  late String weight;
  late String height;
  late String width;
  late String depth;
  late String suplierName;
  late Map<String, dynamic> cardex;
  late Map<String, dynamic> buy;
  late Map<String, dynamic> sell;
  late Map<String, dynamic> images;

  Product({
    required this.idProduct,
    required this.bqProductCode,
    required this.refProdCode,
    required this.idCat,
    required this.idSuplier,
    required this.productName,
    required this.productAltName,
    required this.productCost,
    required this.productTax,
    required this.productSalePrice,
    required this.productSalePrice2,
    required this.productSalePrice3,
    required this.productDiscount,
    required this.productDiscountAlt,
    required this.idStorage,
    required this.productRegDate,
    required this.productLimitDate,
    required this.prodLastModDate,
    required this.lastSaleDate,
    required this.quantityAlert,
    required this.statusQuantityAlert,
    required this.model,
    required this.brand,
    required this.status,
    required this.location,
    required this.deadlineDays,
    required this.aupsa,
    required this.expiration,
    required this.frozen,
    required this.idInventoryUnit,
    required this.packageProductId,
    required this.categoryName,
    required this.imagen,
    required this.storageName,
    required this.exist,
    required this.suplierName,
    required this.weight,
    required this.height,
    required this.width,
    required this.depth,
  });

  Product.imagesFromJson(Map<String, dynamic> json) {}

  Product.fromJsonMap(Map<String, dynamic> json) {
    idProduct = json['id_product'].toString();
    bqProductCode = json['BQ_product_code'].toString();
    refProdCode = json['ref_prod_code'].toString();
    idCat = json['id_cat'].toString();
    idSuplier =
        (json['id_suplier'] == null) ? '' : json['id_suplier'].toString();
    productName = (json['product_name'] == null) ? '' : json['product_name'];
    productAltName = (json['product_alt_name'] == null)
        ? ''
        : json['product_alt_name'].toString();
    productCost = (json['product_cost'] == null)
        ? 0.00
        : double.parse(json['product_cost']);
    productTax = (json['product_tax'] == null)
        ? 0.00
        : double.parse(json['product_tax']);
    productSalePrice = (json['product_sale_price'] == null)
        ? 0.00
        : double.parse(json['product_sale_price']);
    productSalePrice2 = (json['product_sale_price_2'] == null)
        ? 0.00
        : double.parse(json['product_sale_price_2']);
    productSalePrice3 = (json['product_sale_price_3'] == null)
        ? 0.00
        : double.parse(json['product_sale_price_3']);
    productDiscount = (json['product_discount'] == null)
        ? 0.00
        : double.parse(json['product_discount']);
    productDiscountAlt = (json['product_discount_alt'] == null)
        ? 0.00
        : double.parse(json['product_discount_alt']);
    idStorage =
        (json['id_storage'] == null) ? '' : json['id_storage'].toString();
    productRegDate =
        (json['product_reg_date'] == null) ? '' : json['product_reg_date'];
    productLimitDate =
        (json['product_limit_date'] == null) ? '' : json['product_limit_date'];
    prodLastModDate =
        (json['prod_last_mod_date'] == null) ? '' : json['prod_last_mod_date'];
    lastSaleDate =
        (json['last_sale_date'] == null) ? '' : json['last_sale_date'];
    quantityAlert = (json['quantity_alert'] == null)
        ? ''
        : json['quantity_alert'].toString();
    statusQuantityAlert = (json['status_quantity_alert'] == null)
        ? 0
        : int.parse(json['status_quantity_alert']);
    model = (json['model'] == null) ? '' : json['model'];
    brand = (json['brand'] == null) ? '' : json['brand'];
    status = (json['status'] == null) ? 0 : int.parse(json['status']);
    location = (json['location'] == null) ? '' : json['location'];
    deadlineDays =
        (json['deadline_days'] == null) ? 0 : int.parse(json['deadline_days']);
    aupsa = (json['aupsa'] == null) ? '' : json['aupsa'];
    expiration = (json['expiration'] == null) ? '' : json['expiration'];
    frozen = (json['frozen'] == null) ? 0 : int.parse(json['frozen']);
    idInventoryUnit = (json['id_inventory_unit'] == null)
        ? 0
        : int.parse(json['id_inventory_unit']);

    packageProductId = (json['packageProductId'] == null)
        ? ''
        : json['packageProductId'].toString();
    categoryName = (json['category_name'] == null) ? '' : json['category_name'];
    imagen = (json['imagen'] == null) ? '' : json['imagen'];
    storageName = (json['storage_name'] == null) ? '' : json['storage_name'];
    exist = (json['exist'] == null) ? 0 : double.parse(json['exist']);
    suplierName = (json['suplier_name'] == null) ? '' : json['suplier_name'];
    weight = (json['delivery_product_weight'] == null)
        ? ''
        : json['delivery_product_weight'].toString();
    height = (json['delivery_product_height'] == null)
        ? ''
        : json['delivery_product_height'].toString();
    width = (json['delivery_product_width'] == null)
        ? ''
        : json['delivery_product_width'].toString();
    depth = (json['delivery_product_deep'] == null)
        ? ''
        : json['delivery_product_deep'].toString();
  }

  String getImgUrl() {
    if (imagen == '' || imagen == null) {
      return 'https://roadmap-tech.com/wp-content/uploads/2019/04/placeholder-image.jpg';
    }
    return 'http://186.188.172.22/sunlee/uploads/$imagen';
  }

  Map<String, dynamic> toMap() => {
        'id_product': idProduct,
        'BQ_product_code': bqProductCode,
        'ref_prod_code': refProdCode,
        'id_cat': idCat,
        'id_suplier': idSuplier,
        'product_name': productName,
        'product_alt_name': productAltName,
        'product_cost': productCost,
        'product_tax': productTax,
        'product_sale_price': productSalePrice,
        'product_sale_price_2': productSalePrice2,
        'product_sale_price_3': productSalePrice3,
        'product_discount': productDiscount,
        'product_discount_alt': productDiscountAlt,
        'id_storage': idStorage,
        'categoryName': categoryName,
        'exist': exist,
        'suplier_name': suplierName
      };

  void loadImages(Product product, Map<String, dynamic> json) {
    List<dynamic> images = [];
    for (var i = 0; i < json.length; i++) {
      images.add(json[i]);
    }
    product.imagen = json['imagen'];
  }
}
