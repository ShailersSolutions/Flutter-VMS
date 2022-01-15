import 'package:flutter/material.dart';

class CommonDropDown extends StatefulWidget {

  var dropDownValue;
  List<dynamic> dropDownList;
  var itemValue;
  String text;
  Function onTap;

  CommonDropDown({this.dropDownList,this.dropDownValue,this.onTap,this.text,this.itemValue});

  @override
  _CommonDropDownState createState() => _CommonDropDownState();
}

class _CommonDropDownState extends State<CommonDropDown> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.only(left: 7,right: 7,),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26,),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonFormField(
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              onTap: (){
                widget.onTap();
              },
              isExpanded: true,
              value: widget.dropDownValue,
              hint: Text('Select Your Location'),
              items: widget.dropDownList.map((e) {
                return DropdownMenuItem(
                  value: e[widget.itemValue],
                  child: Text(
                    e[widget.text],
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                );
              }).toList(),
            onChanged: (value) {
                setState(() {
                  widget.dropDownValue = value;
                });
            } ,
              )
          ),
        ),
      );

  }



}
