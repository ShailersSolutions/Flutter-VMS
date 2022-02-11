import 'dart:convert';

import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/Constants/ApiConstants.dart';
import 'package:facechk_app/Constants/RoutePaths.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Provider/visitor_form_provider.dart';
import 'package:facechk_app/Screen/visitor_page2.dart';
import 'package:facechk_app/Screen/visitor_page4.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitorPage3 extends StatefulWidget {
  final String location_id,
      buildingType,
      department_id,
      officerType,
      pusposeVisitCtrl,
      visitorName;
  final String visitorEmail,
      visitorPhone,
      visitDurationType,
      purposeVisitType,
      vehicleType;
  final String country_id,
      state_id,
      city_id,
      visitorVehicle,
      visitorPinNo,
      visitorAdhdhar;
  final String visitorAddress,
      visitorAddress2,
      documentType,
      genderType,
      valueChanged1,
      fileName;

  VisitorPage3(
      {this.location_id = '',
      this.buildingType = '',
      this.department_id = '',
      this.officerType = '',
      this.pusposeVisitCtrl = '',
      this.visitorName = '',
      this.visitorEmail = '',
      this.visitorPhone = '',
      this.visitDurationType = '',
      this.purposeVisitType = '',
      this.vehicleType = '',
      this.country_id = '',
      this.state_id = '',
      this.city_id = '',
      this.visitorVehicle = '',
      this.visitorPinNo = '',
      this.visitorAddress = '',
      this.visitorAddress2 = '',
      this.documentType = '',
      this.genderType = '',
      this.fileName = '',
      this.visitorAdhdhar = '',
      this.valueChanged1 = ''});

  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<VisitorPage3> {
  String org_country_id;
  String org_state_id;
  String org_city_id;
  List countryDrop = [];
  List stateDrop = [];
  List cityDrop = [];
  String fileNameProfile = 'Select Image';
  String profileImage = 'Select Image';
  String file_name = "Upload Your Photo";
  var height,width;


  String imageSelectProfile;
  final List<String> accountType3 = [
    'Camera',
    'Gallery',
  ];
  TextEditingController organizationNameCtrl = TextEditingController();
  TextEditingController organizationpinCtrl = TextEditingController();
  Widget build(BuildContext context) {
    return initWidget();
  }

  Future<String> _getCountryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getCountry';
    var res = await http.post(
        Uri.parse(url),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print('${resBody['date']}');
    setState(() {
      countryDrop = resBody['date'];
    });
    return "Success";
  }

  Future<String> _getStateList(String country_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getState';
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json"
        },
        body: {
          'country_id': country_id,
        });
    var resBody = json.decode(res.body);
    print('state ${resBody['date']}');
    setState(() {
      stateDrop = resBody['date'];
    });
    return "Success";
  }

  Future<String> _getCityList(String state_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getCity';
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json"
        },
        body: {
          'state_id': state_id,
        });
    var resBody = json.decode(res.body);
    print('city ${resBody['date']}');
    setState(() {
      cityDrop = resBody['date'];
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    _getCountryList();

    print("Navigator data3 " +
        widget.location_id.toString() +
        " " +
        widget.buildingType.toString() +
        " " +
        widget.department_id.toString() +
        " " +
        widget.officerType.toString() +
        " " +
        " " +
        widget.valueChanged1.toString() +
        " " +
        widget.visitorName.toString() +
        " " +
        widget.visitorEmail.toString());
  }

  bool validatedetail() {
    /*if (organizationNameCtrl.text.isEmpty) {
      BaseMethod().VMSToastMassage("Enter Organization Name");
      return false;
    } else if (org_country_id == null) {
      BaseMethod().VMSToastMassage("Select Organization Country");
      return false;
    } else if (org_state_id == null) {
      BaseMethod().VMSToastMassage("Select Organization State");
      return false;
    } else if (org_city_id == null) {
      BaseMethod().VMSToastMassage("Select Organization City");
      return false;
    }*/ if (imageSelectProfile == null) {
      print("image mode");
      BaseMethod().VMSToastMassage("Select Image Mode");

      return false;
    } else if (imageSelectProfile == 'Camera' && profileImage.isEmpty) {
      BaseMethod().VMSToastMassage("Capture Image first");

      return false;
    } else if (imageSelectProfile == 'Gallery' && profileImage.isEmpty) {
      BaseMethod().VMSToastMassage("Select Image first");
      return false;
    }

    return true;
  }

  Widget initWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);
    VisitorFormProvider visitorFormProvider = Provider.of(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF4FC3F7),
          title: Text("${formProvider.officeUrlModel.name}"),
        ),
        body: Container(
          height: height,
            width: width,
            child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: width,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[900]
                            ),
                            child: Text(
                              "Visitor Address",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: visitorFormProvider.orgName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Organization Name:"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.only(left: 7, right: 7,),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              isExpanded: true,
                              value: org_country_id,
                              hint: Text('Select Organization Country'),
                              items: countryDrop?.map((e) {
                                return DropdownMenuItem(
                                  value: e['id'].toString(),
                                  child: Text(
                                    e['name'].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              })?.toList(),
                              onChanged: (String val) {
                                setState(() {
                                  org_country_id = val;
                                  visitorFormProvider.orgCountry = org_country_id;
                                  org_state_id = null;
                                  org_city_id = null;
                                  _getStateList(val);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20,top: 15),
                          padding: EdgeInsets.only(left: 7, right: 7,),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              isExpanded: true,
                              value: org_state_id,
                              hint: Text('Select Organization State'),
                              items: stateDrop?.map((ee) {
                                return DropdownMenuItem(
                                  value: ee['id'].toString(),
                                  child: Text(
                                    ee['name'].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              })?.toList(),
                              onChanged: (String vals) {
                                setState(() {
                                  org_state_id = vals ;
                                  visitorFormProvider.orgState = org_state_id;
                                  _getCityList(vals);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 7, right: 7,),
                          margin: EdgeInsets.only(left: 20, right: 20,top: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              isExpanded: true,
                              value: org_city_id,
                              hint: Text('Select Organization City'),
                              items: cityDrop?.map((e) {
                                return DropdownMenuItem(
                                  value: e['id'].toString(),
                                  child: Text(
                                    e['name'].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              })?.toList(),
                              onChanged: (String val) {
                                setState(() {
                                  org_city_id = val ;
                                  visitorFormProvider.orgCity = org_city_id;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: visitorFormProvider.orgPinCode,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Organization Pin Code:"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(6),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: Text(
                              "Upload Your Photo",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[600]),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              hint: Text("Select Image Mode*"),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              isExpanded: true,
                              value: imageSelectProfile,
                              items: accountType3.map((accountType) {
                                return DropdownMenuItem(
                                  value: accountType,
                                  child: Text(
                                    accountType,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  imageSelectProfile = val;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20, right: 20,top: 15),
                            height: 50, //MediaQuery.of(context).size.width*.200,
                            width: width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: RaisedButton(
                                child: Text(
                                  file_name,
                                  style: TextStyle(
                                    color: file_name == "Upload Your Photo"
                                        ? Colors.black
                                        : Colors.green,
                                    fontSize: 15,
                                  ),
                                ),
                                color: Colors.white,
                                onPressed: () async {
                                  if (imageSelectProfile == 'Gallery') {
                                    PickedFile image = await ImagePicker()
                                        .getImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      profileImage = image.path;
                                      final bytes = Io.File(image.path).readAsBytesSync();
                                      String img64 = base64Encode(bytes);
                                      print(img64);
                                      fileNameProfile = img64.toString();
                                      setState(() {
                                        file_name = "Image Uploaded ";
                                      });

                                      print(" imageSelectProfile" + fileNameProfile);

                                      // imageSelectProfile = "";
                                    }
                                  } else if (imageSelectProfile == 'Camera') {
                                    PickedFile image = await ImagePicker()
                                        .getImage(source: ImageSource.camera);
                                    if (image != null) {
                                      profileImage = image.path;
                                      final bytes = Io.File(image.path).readAsBytesSync();
                                      String img64 = base64Encode(bytes);
                                      print(img64);
                                      fileNameProfile = img64.toString();
                                      setState(() {
                                        file_name = "Image Uploaded ";
                                      });
                                      print(fileNameProfile);
                                    }
                                  } else {
                                    BaseMethod().VMSToastMassage('Select Image Mode');
                                  }
                                })),
                        SizedBox(
                          height: 15,
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
                                    onPressed: () async {
                                      if (validatedetail()) {
                                        FocusManager.instance.primaryFocus.unfocus();
                                        Navigator.pushNamed(context, '/visitorPage4', arguments: {
                                          'location_id': widget.location_id,
                                          'buildingType': widget.buildingType,
                                          'department_id': widget.department_id,
                                          'officerType': widget.officerType,
                                          // 'pusposeVisitCtrl': widget.pusposeVisitCtrl,
                                          'visitorName': widget.visitorName,
                                          'visitorEmail': widget.visitorEmail,
                                          'visitorPhone': widget.visitorPhone,
                                          'visitDurationType': widget.visitDurationType,
                                          'purposeVisitType': widget.purposeVisitType,
                                          'vehicleType': widget.vehicleType,
                                          'country_id': widget.country_id,
                                          'state_id': widget.state_id,
                                          'city_id': widget.city_id,
                                          'visitorVehicle': widget.visitorVehicle,
                                          'organizationpinCtrl': visitorFormProvider.orgPinCode.text.toString(),
                                          'visitorPinNo': widget.visitorPinNo,
                                          'visitorAddress': widget.visitorAddress,
                                          'visitorAddress2': widget.visitorAddress2,
                                          'documentType': widget.documentType,
                                          'genderType': widget.genderType,
                                          'fileName': widget.fileName,
                                          'organizationNameCtrl': visitorFormProvider.orgName.text.toString(),
                                          'org_country_id': visitorFormProvider.orgCountry.toString(),
                                          'org_state_id': visitorFormProvider.orgState.toString(),
                                          'org_city_id': visitorFormProvider.orgCity.toString(),
                                          'fileNameProfile': profileImage,
                                          // 'fileNameProfile': fileNameProfile.toString(),
                                          'visitorAdhdhar': widget.visitorAdhdhar,
                                          'dateTime': widget.valueChanged1.toString(),
                                        });
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    textColor: Colors.white,
                                    child: Text("Next"),
                                  ),
                                ]))
                  ]),
                ))));
  }
}
