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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black45,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Balance',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$' + numberFormat(client.pendientes),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Saldo Pendiente',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Codigo Cliente',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                              Expanded(child: Center()),
                              Text(
                                headerDataClient.codeClient.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Facturas Pendientes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                              Expanded(child: Center()),
                              Text(
                                client.facsPending.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Solo Facturas Pendientes',
                                style: TextStyle(
                                  color: Colors.black,
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
                                activeColor: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
    _columns.add({'name': 'DOC', 'id': 'btn', 'width': 50.0});
    _columns.add({'name': 'FECHA', 'id': 'date', 'width': 85.0});
    _columns.add({'name': 'REF', 'id': 'doc', 'width': 65.0});
    _columns.add({'name': 'MONTO', 'id': 'amount', 'width': 75.0});
    _columns.add({'name': 'PEND.', 'id': 'pending', 'width': 75.0});
    _columns.add({'name': 'BAL', 'id': 'balance', 'width': 75.0});
    _columns.add({'name': 'D', 'id': 'days', 'width': 60.0});
    double _bl = 0.0;
    //client.document.sort((a, b) => a.idDocument.compareTo(b.idDocument));
    client.document.forEach((element) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime dateTime = dateFormat.parse(element.docDate.toString());
      final fecha = DateFormat('yyyy/MM/dd').format(dateTime);

      final overdue =
          (element.pending > 0 && element.overCredit == 1) ? true : false;
      final line = {
        'id': element.idDocument,
        'btn': element.idDocument,
        'client_name': element.clientName,
        'seller_name': '',
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
            print(
              _data[line]['doc'].toString(),
            );
            /*goto(
                context,
                _data[line]['id'].toString(),
                _data[line]['client_name'].toString(),
                _data[line]['seller_name'].toString());*/
          },
        ),
      );
    }
  }
}
