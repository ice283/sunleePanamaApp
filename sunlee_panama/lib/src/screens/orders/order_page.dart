import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/models/detail_client_model.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/services/request/client_service.dart';
import 'package:sunlee_panama/src/utils/common.functions.dart';
import 'package:sunlee_panama/src/widgets/gridDataWidget.dart';
import 'package:sunlee_panama/src/widgets/loading_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool _pending = true;
  ClientService detailClient = ClientService();

  @override
  Widget build(BuildContext context) {
    var client = Provider.of<ClientNotifier>(context);
    return ListView(
      children: [
        Column(
          children: [
            sumary(detailClient, client),
          ],
        ),
      ],
    );
  }

  FutureBuilder<DetailClientData> sumary(
      ClientService detailClient, ClientNotifier client) {
    var headerDataClient = client;
    return FutureBuilder(
      future: detailClient.detailClient(client.idClient),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          DetailClientData client = snapshot.data;
          //print(client.pagos.toString());
          return Column(
            children: [
              //tarjeta con balance de cliente
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Card(
                  color: Color(0xFFD00000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5.0,
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Balance',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$' + numberFormat(client.pendientes),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Saldo Pendiente',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Codigo Cliente',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            Expanded(child: Center()),
                            Text(
                              headerDataClient.codeClient.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Facturas Pendientes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            Expanded(child: Center()),
                            Text(
                              client.facsPending.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Solo Facturas Pendientes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            Expanded(child: Center()),
                            Switch(
                              value: _pending,
                              onChanged: (e) {
                                _pending = e;
                                setState(() {});
                              },
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              clientReportWidget(client, _pending),
            ],
          );
        } else {
          return Container(
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingWidget(
                  text: 'Cargando Datos...',
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget clientReportWidget(DetailClientData client, bool switchShow) {
    //inicialido las listas
    List<Map<String, dynamic>> _columns = [];
    List<Map<String, dynamic>> _data = [];
    //inicializo los datos
    _columns.add({'name': 'FECHA', 'id': 'date', 'width': 85.0});
    _columns.add({'name': 'REF', 'id': 'doc', 'width': 65.0});
    _columns.add({'name': 'MONTO', 'id': 'amount', 'width': 75.0});
    _columns.add({'name': 'PEND.', 'id': 'pending', 'width': 75.0});
    _columns.add({'name': 'BAL', 'id': 'balance', 'width': 75.0});
    _columns.add({'name': 'D', 'id': 'days', 'width': 60.0});
    double _bl = 0.0;
    client.document.sort((a, b) => a.idDocument.compareTo(b.idDocument));
    client.document.forEach((element) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime dateTime = dateFormat.parse(element.docDate.toString());
      final fecha = DateFormat('yyyy/MM/dd').format(dateTime);

      final overdue =
          (element.pending > 0 && element.overCredit == 1) ? true : false;
      final line = {
        'id': element.idDocument,
        'client_name': element.clientName,
        'seller_name': '',
        'id': element.idDocument,
        'date': fecha.toString(),
        'doc': element.numDocument,
        'days': (element.pending > 0) ? element.since : 0,
        'amount': numberFormat(element.total),
        'pending': numberFormat(element.pending),
        'raw_pending': element.pending,
        'balance': numberFormat(0),
        'alert': (element.since >= element.overCredit) ? '1' : '',
      };
      if (switchShow) {
        if (element.pending > 0) {
          _data.add(line);
        }
      } else {
        _data.add(line);
      }
    });
    _data.forEach((element) {
      _bl += element['raw_pending'];
      element['balance'] = numberFormat(_bl);
    });

    //compruebo si existe informacion que desplegar
    if (_columns.isEmpty) {
      return Container(
        height: 300,
        child: Center(
          child: Text('No hay información'),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        height: 400,
        child: GridWidget(
          header: _columns,
          rows: _data,
          onTap: (DataGridCellDoubleTapDetails e) {
            int line = e.rowColumnIndex.rowIndex - 1;
            goto(
                context,
                _data[line]['id'].toString(),
                _data[line]['client_name'].toString(),
                _data[line]['seller_name'].toString());
          },
        ),
      );
    }
  }
}

void goto(
    BuildContext context, String e, String client_name, String seller_name) {
  Navigator.pushNamed(context, '/document', arguments: {
    'id_document': e,
    'client_name': client_name,
    'seller_name': seller_name
  });
}
