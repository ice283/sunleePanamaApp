import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/cart_provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/utils/common.functions.dart';
import 'package:sunlee_panama/src/widgets/confirm_widget.dart';

class CartSumaryPage extends StatelessWidget {
  const CartSumaryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartNotifier = Provider.of<CartNotifier>(context, listen: true);
    final client = Provider.of<ClientNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen de Pedido'),
        bottom: AppBar(
          backgroundColor: Colors.grey[100],
          leading: Container(),
          leadingWidth: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              (client.price_permision == '0')
                  ? Text('Productos: ${cartNotifier.items}',
                      style: TextStyle(fontSize: 20, color: Colors.black))
                  : Text(
                      'Total: \$ ' + numberFormat(cartNotifier.cart.totalCart),
                      style: TextStyle(fontSize: 20, color: Colors.black)),
              (cartNotifier.cart.items == 0)
                  ? SizedBox(
                      width: 20,
                    )
                  : FittedBox(
                      child: RawMaterialButton(
                        padding: EdgeInsets.all(8),
                        fillColor: Colors.red,
                        textStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        onPressed: (cartNotifier.items == 0)
                            ? null
                            : () async {
                                final confirm = await showConfirm(
                                    context,
                                    'Confirmar Pedido',
                                    'Se enviara su solicitud de pedido a Sunlee Panama para su procesamiento. ¿Desea continuar?');
                                if (confirm) {
                                  cartNotifier.setClient(client.idClient);
                                  final response =
                                      await cartNotifier.sendOrder();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Pedido Enviado...'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                  cartNotifier.emptyCart();
                                }
                                //Navigator.of(context).pushNamed('/checkout');
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Enviar Pedido'),
                            Icon(Icons.check_circle_outline_rounded),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      body: (cartNotifier.items == 0)
          ? Center(
              child: Text('No hay productos en el carrito'),
            )
          : ListView.builder(
              itemCount: cartNotifier.items,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      elevation: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CachedNetworkImage(
                                    fadeInDuration:
                                        const Duration(milliseconds: 100),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 100),
                                    placeholder: (context, url) => Image.asset(
                                      'assets/images/placeholder-image.jpeg',
                                      fit: BoxFit.contain,
                                    ),
                                    imageUrl:
                                        cartNotifier.cart.products[index].image,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  (client.price_permision == '0')
                                      ? Container()
                                      : Text(
                                          '\$ ' +
                                              numberFormat(cartNotifier
                                                  .cart.products[index].price) +
                                              ' x Und.',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                              thickness: 2,
                              width: 6.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 110,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cartNotifier
                                          .cart.products[index].productName,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.redAccent),
                                          visualDensity: VisualDensity.compact,
                                        ),
                                        onPressed: () async {
                                          final r = await showConfirm(
                                              context,
                                              'Eliminar',
                                              'Se eliminara del carrito, ¿Desea continuar?');
                                          if (r) {
                                            cartNotifier.removeItem(cartNotifier
                                                .cart
                                                .products[index]
                                                .idProduct);
                                          }
                                        },
                                        icon: Icon(Icons.delete_forever),
                                        label: Text('Borrar'),
                                      ),
                                      (client.price_permision == '0')
                                          ? Container()
                                          : Text(
                                              '\$ ' +
                                                  numberFormat(cartNotifier.cart
                                                      .products[index].total),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black,
                              thickness: 2,
                              width: 6.0,
                            ),
                            Container(
                              color: Colors.grey[100],
                              width: 40,
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        cartNotifier.addOne(cartNotifier
                                            .cart.products[index].idProduct);
                                      },
                                      icon: Icon(Icons.add)),
                                  Text(cartNotifier
                                      .cart.products[index].quantity
                                      .toString()),
                                  IconButton(
                                      onPressed: () {
                                        if (cartNotifier.cart.products[index]
                                                .quantity ==
                                            1) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Cantidad minima de producto'),
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        } else {
                                          cartNotifier.removeOne(cartNotifier
                                              .cart.products[index].idProduct);
                                        }
                                      },
                                      icon: Icon(Icons.remove)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
