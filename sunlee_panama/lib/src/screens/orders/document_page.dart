import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/services/request/client_service.dart';
import 'package:sunlee_panama/src/utils/common.functions.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> datos =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ClientService detailClient = ClientService();
    String id = datos['id'] ?? datos['id_document'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Pedido'),
      ),
      body: FutureBuilder(
        future: detailClient.getDocument(id),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return _buildLoader();
          }
          if (snapshot.hasError) {
            return _buildError();
          }
          if (snapshot.hasData) {
            return _buildDataView(snapshot.data, datos);
          }
          return _buildNoData();
        },
      ),
    );
  }

  Widget _buildDataView(dt, datos) {
    return Container(
      child: ListView(
        children: [
          _header(dt[0], datos),
          _body(dt[1]),
          _footer(dt[0], datos),
        ],
      ),
    );
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Text("Error de Datos"),
    );
  }

  Widget _buildNoData() {
    return Center(
      child: Text("No hay datos"),
    );
  }

  Widget _header(dt, datos) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Container(
            height: 50,
            child: Center(
                child: Text(
              'Documento',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  headerLine('CLIENTE: ', datos['client_name'].toString()),
                  Divider(
                    thickness: 2,
                  ),
                  headerLine('NRO. DOCUMENTO: ', dt['num_document'].toString()),
                  Divider(
                    thickness: 2,
                  ),
                  headerLine('FECHA: ', dt['doc_date'].toString()),
                  Divider(
                    thickness: 2,
                  ),
                  headerLine('NRO. CONTROL: ', dt['id_document'].toString()),
                ],
              ),
            ),
          ),
          Card(),
        ],
      ),
    );
  }

  Row headerLine(String title, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _body(dt) {
    List<Widget> list = [];
    list.add(
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: 200,
              child: Text(
                'Nombre',
                style: TextStyle(fontSize: 12.0),
              )),
          Container(
              width: 40,
              child: Text(
                'Cant.',
                style: TextStyle(fontSize: 12.0),
              )),
          Container(
              width: 80,
              child: Text(
                'Precio',
                style: TextStyle(fontSize: 12.0),
              )),
          Text('Total'),
        ],
      ),
    );
    list.add(
      Divider(
        thickness: 2,
      ),
    );
    if (dt['cant_rows'] > 0) {
      for (var i = 0; i < dt['cant_rows']; i++) {
        if (dt[i.toString()]['quantity_product'] == '') {
          list.add(Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dt[i.toString()]['product_name_temp'].toString(),
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ));
        } else {
          final subtotal = dt[i.toString()]['product_sale_price'].toDouble() *
              dt[i.toString()]['quantity_product'].toDouble();
          list.add(Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 200,
                  child: Text(
                    dt[i.toString()]['product_name_temp'].toString(),
                    style: TextStyle(fontSize: 12.0),
                  )),
              Container(
                  width: 40,
                  child: Text(
                    dt[i.toString()]['quantity_product'].toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12.0),
                  )),
              Container(
                  width: 80,
                  child: Text(
                    '\$ ' +
                        numberFormat(
                            dt[i.toString()]['product_sale_price'].toDouble()),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12.0),
                  )),
              Text(
                '\$ ' + numberFormat(subtotal),
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ));
          list.add(Divider(
            thickness: 2,
          ));
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: list,
      ),
    );
  }

  Widget _footer(dt, datos) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  headerLine('SUBTOTAL: ',
                      '\$ ' + numberFormat(dt['total_sale'].toDouble())),
                  Divider(
                    thickness: 2,
                  ),
                  headerLine('DESCUENTO: ',
                      '\$ ' + numberFormat(dt['total_discount'].toDouble())),
                  Divider(
                    thickness: 2,
                  ),
                  headerLine('ITBMS: ',
                      '\$ ' + numberFormat(dt['total_tax'].toDouble())),
                  Divider(
                    thickness: 2,
                  ),
                  headerLine('TOTAL: ',
                      '\$ ' + numberFormat(dt['total_document'].toDouble())),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
