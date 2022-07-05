import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/models/cart_model.dart';
import 'package:sunlee_panama/src/models/products_model.dart';
import 'package:sunlee_panama/src/providers/cart_provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/utils/common.functions.dart';
import 'package:sunlee_panama/src/widgets/cart_icon_widget.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({Key? key}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  TextEditingController _controller = TextEditingController();
  int _quantity = 1;
  @override
  void initState() {
    _controller.text = _quantity.toString();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    var cartData = Provider.of<CartNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName,
            style: TextStyle(
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
        actions: [
          CartIconCounter(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: width * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _quantity++;
                        _controller.text = _quantity.toString();
                        setState(() {});
                      },
                      icon: Icon(Icons.add),
                      color: Colors.grey[700]),
                  Container(
                    width: 70,
                    height: 50,
                    child: TextField(
                      style: TextStyle(fontSize: 16.0),
                      controller: _controller,
                      onSubmitted: (value) {
                        if (value == null || value.isEmpty) {
                          _quantity = 1;
                          _controller.text = _quantity.toString();
                          setState(() {});
                        } else {
                          if (int.parse(value) < 1) {
                            _quantity = 1;
                            _controller.text = _quantity.toString();
                            setState(() {});
                          } else {
                            _quantity = int.parse(value);
                          }
                        }
                      },
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (_quantity > 1) {
                          _quantity--;
                          _controller.text = _quantity.toString();
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.remove),
                      color: Colors.grey[700]),
                ],
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    cartData.addItem(CartItem(
                      idCart: '0',
                      idProduct: product.idProduct,
                      productName: product.productName,
                      price: product.productSalePrice,
                      image: product.getImgUrl(),
                      quantity: _quantity,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Agregado A la Cesta ${product.productName}'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text('Agregar al Pedido'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              height: screenHeight * 0.5,
              child: Stack(
                children: [
                  Container(
                    height: screenHeight * 0.45,
                    width: width,
                    child: fixedProductImage(product: product),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fitWidth,
                        height: 40.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                          color:
                              (product.exist > 0) ? Colors.green : Colors.red,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                (product.exist > 0)
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                (product.exist > 0) ? 'Disponible' : 'Agotado',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Description(product: product),
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    var ClientData = Provider.of<ClientNotifier>(context, listen: true);
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          //color: Colors.black54,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black12,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.productAltName}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      'Codigo: ${product.bqProductCode}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Categoria: ${product.categoryName}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Referencia: ${product.refProdCode}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    (ClientData.price_permision == '0')
                        ? Container()
                        : Text(
                            '\$ ' + numberFormat(product.productSalePrice),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class carrousel extends StatelessWidget {
  const carrousel({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Hero(
          tag: product.idProduct,
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 100),
            fadeOutDuration: const Duration(milliseconds: 100),
            placeholder: (context, url) => Image.asset(
              'assets/images/placeholder-image.jpeg',
              fit: BoxFit.fitHeight,
            ),
            imageUrl: product.getImgUrl(),
            fit: BoxFit.fitHeight,
          ),
        ),
        CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 100),
          fadeOutDuration: const Duration(milliseconds: 100),
          placeholder: (context, url) => Image.asset(
            'assets/images/placeholder-image.jpeg',
            fit: BoxFit.fitHeight,
          ),
          imageUrl: product.getImgUrl(),
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class fixedProductImage extends StatelessWidget {
  const fixedProductImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.idProduct,
      child: CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: const Duration(milliseconds: 100),
        placeholder: (context, url) => Image.asset(
          'assets/images/placeholder-image.jpeg',
          fit: BoxFit.fitHeight,
        ),
        imageUrl: product.getImgUrl(),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
