import 'package:flutter/material.dart';

class BtnDocument extends StatelessWidget {
  final String id;
  const BtnDocument({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void goto(BuildContext context, String e) {
      Navigator.pushNamed(context, '/document', arguments: {'id_document': e});
    }

    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        goto(context, id.toString());
      },
    );
  }
}
