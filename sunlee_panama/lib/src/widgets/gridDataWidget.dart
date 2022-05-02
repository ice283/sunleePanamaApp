import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GridWidget extends StatefulWidget {
  List<Map<String, dynamic>> header;
  List<Map<String, dynamic>> rows;
  Function onTap;

  GridWidget({
    Key? key,
    required this.header,
    required this.rows,
    required this.onTap,
  }) : super(key: key);

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> row = widget.rows;
    List<GridColumn> header = setColumns(widget.header);
    Function onTap = widget.onTap;
    DataGridSource source = DataSource(rowsData: row, columns: widget.header);

    //print(col);
    //return Container();
    source.sortedColumns.add(SortColumnDetails(
        name: 'date', sortDirection: DataGridSortDirection.descending));
    source.sort();
    return SfDataGrid(
      source: source,
      columns: header,
      onQueryRowHeight: (details) => 30.0,
      allowSorting: true,
      onCellDoubleTap: (e) {
        onTap(e);
      },
    );
  }

  List<GridColumn> setColumns(List<Map<String, dynamic>> columns) {
    List<GridColumn> cols = <GridColumn>[];
    columns.forEach((element) {
      cols.add(
        GridColumn(
            columnName: element['id'].toString(),
            width: (element['width'] != null) ? element['width'] : 100.0,
            label: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  element['name'].toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ))),
      );
    });
    return cols;
  }
}

class DataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  DataSource(
      {required List<Map<String, dynamic>> rowsData,
      required List<Map<String, dynamic>> columns}) {
    _rowsData = rowsData
        .map<DataGridRow>((e) => DataGridRow(cells: getCells(e, columns)))
        .toList();
  }

  List<DataGridCell> getCells(line, columns) {
    List<DataGridCell> cells = [];
    columns.forEach((element) {
      cells.add(
        DataGridCell(
            columnName: element['id'].toString(), value: line[element['id']]),
      );
    });
    return cells;
  }

  List<DataGridRow> _rowsData = [];

  @override
  List<DataGridRow> get rows => _rowsData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      TextStyle? getTextStyle() {
        if (e.columnName == 'days' && e.value >= 30) {
          return const TextStyle(
            fontSize: 12.0,
            color: Colors.red,
          );
        } else {
          return const TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          );
        }
      }

      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: Text(
          e.value.toString(),
          style: getTextStyle(),
        ),
      );
    }).toList());
  }
}
