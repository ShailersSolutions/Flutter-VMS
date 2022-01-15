import 'package:flutter/material.dart';

class CommonTextForm extends StatefulWidget {
  String text;
  TextEditingController controller;
  bool enable;

  CommonTextForm({this.text,this.controller,this.enable});
  @override
  _CommonTextFormState createState() => _CommonTextFormState();
}

class _CommonTextFormState extends State<CommonTextForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10,top: 20),
      alignment: Alignment.center,
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.enable,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.text),
      ),
    );
  }
}
