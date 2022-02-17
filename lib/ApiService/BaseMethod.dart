import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class BaseMethod {
  void VMSToastMassage(String s) {
    Fluttertoast.showToast(
        msg: '$s',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue[900],
        textColor: Colors.white,
        fontSize: 16.0);
  }





  void toastforqr(String s) {
    Fluttertoast.showToast(
        msg: '$s',
        timeInSecForIos: 2,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue[900],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool visible = true;
  String validateEmail(value) {
    String _msg;
    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value.isEmpty) {
      _msg = "Enter Visitor EmailId";
    } else if (!regex.hasMatch(value)) {
      _msg = "Please provide a valid emal address";
    }
    return _msg;
  }
}
