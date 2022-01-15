import 'package:flutter/material.dart';

class AccessMethod extends StatefulWidget {

  String text;
  String image;
  Function onTap;
  AccessMethod({this.text,this.image,this.onTap});
  @override
  _AccessMethodState createState() => _AccessMethodState();
}

class _AccessMethodState extends State<AccessMethod> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
          widget.onTap()
        },
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 40),
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Colors.white,
              )
            ],
          ),
          child: Row(children: [
            Container(
              padding: EdgeInsets.only(
                  left: 20, right: 40, bottom: 5, top: 5),
              child: Image.asset(
                widget.image,
                width: 30,
              ),
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 20,
                color: Colors.blue[900],
              ),
            ),
          ]),
        ));
  }
}
