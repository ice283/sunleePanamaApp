import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  final String title;

  const BlankPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          child: Text(title),
        ),
      ),
    );
  }
}
