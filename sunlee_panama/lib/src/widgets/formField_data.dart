import 'package:flutter/material.dart';

class FormFieldData extends StatefulWidget {
  String title;
  String initialValue;
  IconData icon;
  Function callback;
  Function validate;
  bool password;
  bool obscureText;

  FormFieldData({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.icon,
    required this.callback,
    required this.validate,
    this.password = false,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<FormFieldData> createState() => _FormFieldDataState();
}

class _FormFieldDataState extends State<FormFieldData> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.initialValue;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: widget.obscureText,
        validator: (value) {
          return widget.validate(value);
        },
        decoration: InputDecoration(
          suffixIcon: (!widget.password)
              ? null
              : IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: widget.obscureText ? Colors.grey : Colors.red[700],
                  ),
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  }),
          labelText: widget.title,
          prefixIcon: Icon(widget.icon),
        ),
        onFieldSubmitted: (text) {
          widget.callback(text);
        },
        onChanged: (text) {
          widget.callback(text);
        },
        onSaved: (text) {
          widget.callback(text);
        },
      ),
    );
  }
}
