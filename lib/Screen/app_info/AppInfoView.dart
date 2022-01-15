import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppInfoView extends StatefulWidget {
  @override
  _AppInfoViewState createState() {
    return _AppInfoViewState();
  }
}

class _AppInfoViewState extends  State<AppInfoView>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (!isConnectedToInternet) {
      print('loading ads....');
      return MaterialApp(

        /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sending  Message.... $counter'),
            backgroundColor: new Color(0xff075E54),
          ));*/

      );
    }
  }
}