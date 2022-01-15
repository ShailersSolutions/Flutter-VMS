import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/Constants/ApiConstants.dart';
import 'package:facechk_app/Constants/RoutePaths.dart';
import 'package:facechk_app/Models/NewRegistrationModel.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:facechk_app/Screen/visitor_page5.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisitorPage6 extends StatefulWidget {
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<VisitorPage6> {
  String page6Documrnt;
  var page6VisitType = 'Visit Type';
  final List<String> accountType = ['Visit Type', 'Single', 'Group'];
  var page6GenderType = 'Gender';
  final List<String> accountType1 = ['Gender', 'Male', 'Female', 'Other'];
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);
    NewRegistrationModel newRegistrationModel=NewRegistrationModel();
    TextEditingController page6NameCtrl = TextEditingController();
TextEditingController page6MobileCtrl = TextEditingController();

    final routeData=ModalRoute.of(context).settings.arguments as Map<String,String>;
    print("Navigator data6 "+routeData['covidBodyTempCtrl']);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF4FC3F7),
          title: Text("${formProvider.officeUrlModel.name}"),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                (Color(0XFF4FC3F7)),
                Color(0XFF81D4FA),
                Color(0XFFB3E5FC)
              ])),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Container(
                  margin: EdgeInsets.only(top: 35, left: 50, right: 50),
                  child: Image.asset("images/facechk_logo.png"),
                  height: 30,
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                    child: Text(
                  "Visitor Management System",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                )),
              ]))),
      SizedBox(
        height: 10,
      ),
      Container(
          child: Text(
        "Visit Type",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.blue[900]),
      )),

      SizedBox(
        height: 20,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: EdgeInsets.only(
              left: 7,
              right: 7,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonFormField(
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              isExpanded: true,
              value: accountType[0],
              items: accountType.map((accountType) {
                return DropdownMenuItem(
                  value: accountType,
                  child: Text(
                    accountType,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String val) {
                setState(() {
                  page6VisitType = val ?? "";
                });
              },
            ),
          ),
        ),
      ),
      // add a dropdown button
      SizedBox(
        height: 20,
      ),
      Center(
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: page6NameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Name:"),
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Center(
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: page6MobileCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Mobile No.:"),
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: EdgeInsets.only(
              left: 7,
              right: 7,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black26,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonFormField(
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              isExpanded: true,
              value: accountType1[0],
              items: accountType1.map((accountType) {
                return DropdownMenuItem(
                  value: accountType,
                  child: Text(
                    accountType,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String val) {
                setState(() {
                  page6GenderType = val ?? "";
                });
              },
            ),
          ),
        ),
      ),
      Center(
        child: Form(
            child: Row(children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 60, //MediaQuery.of(context).size.width*.200,
              width: 340,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: RaisedButton(
                  child: Text(
                    'Attached Document',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  color: Colors.white,
                  onPressed: () async {
                    var picked = await FilePicker.platform.pickFiles();
                    print("picked$picked");
                    if (picked != null) {
                      print(picked.files.first.name);
                      page6Documrnt=picked.files.first.name;
                      // FileUploadInputElement uploadInput = FileUploadInputElement();
                      // uploadInput.accept = '.png,.jpg';
                      // uploadInput.click();
                    }
                  })),
        ])),
      ),

      SizedBox(
        height: 5,
      ),
      Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
            RaisedButton(
              color: Colors.blueGrey,
              onPressed: () {
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              textColor: Colors.white,
              child: Text("Back"),
            ),
            SizedBox(
              width: 15,
            ),
            RaisedButton(
              color: Colors.blue[900],
              onPressed: () {
                print('hlllo');
                /*var manager = RequestManager();
                var data = manager.newRegistrationApi(ApiConstants.Base_Url+RoutePaths.NewVisitUrl, '', "","")
                    .then((value) {
                  print('response:$value');
                  newRegistrationModel = value;
                  print('response:${newRegistrationModel.message}');
                  if (newRegistrationModel.status == 'status') {
                    BaseMethod().VMSToastMassage('${newRegistrationModel.message}');


                  }else if(newRegistrationModel.status == 'failed'){
                    print('msg : ${newRegistrationModel.message}');
                    BaseMethod().VMSToastMassage('${newRegistrationModel.message}');
                  }
                });*/
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              textColor: Colors.white,
              child: Text("Submit"),
            ),
          ]))
    ]))
    );
  }
}
