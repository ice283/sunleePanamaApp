import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/screens/dashboard/most_sold_widget.dart';
import 'package:sunlee_panama/src/screens/dashboard/most_wanted_widget.dart';
import 'package:sunlee_panama/src/screens/dashboard/recomended_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          titleDivider('Productos Recomendados'),
          RecomendedWidget(),
          titleDivider('Productos mas Buscados'),
          MostWantedWidget(),
          titleDivider('Volver a comprar'),
          MostSoldWidget(),
        ],
      ),
    );
  }

  Padding titleDivider(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
          Divider(
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
