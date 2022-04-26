import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? text;
  const LoadingWidget({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 15),
          (text != null) ? Text(text.toString()) : Text('Cargando...'),
        ],
      ),
    );
  }
}
