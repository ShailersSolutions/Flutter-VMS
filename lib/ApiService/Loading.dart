import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
  const Loading({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("loading going on");
    return Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(16.0),
        color: Colors.white,
      ),

      child: SpinKitFadingCircle(

        color: Colors.blue,
        size: 80.0,
      ),);
  }
}
