import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/Constants/ApiConstants.dart';
import 'package:facechk_app/Constants/RoutePaths.dart';
import 'package:facechk_app/Models/LocationModel.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/visitor_forms.dart';
import 'package:facechk_app/Screen/visitor_page3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitorPage2 extends StatefulWidget {
  final String visitorName, documentType, genderType, fileName;
  String visitorEmail,
      visitorPhone,
      visitDurationType,
      purposeVisitType,
      vehicleType;
  String country_id, state_id, city_id, visitorVehicle, visitorPinNo;
  String visitorAddress, visitorAddress2, visitorAdhdhar;

  VisitorPage2({
    this.visitorName = '',
    this.visitorEmail = '',
    this.visitorPhone = '',
    this.genderType = '',
    this.documentType = '',
    this.visitorAdhdhar = '',
    this.fileName = '',
    this.visitDurationType = '',
    this.purposeVisitType = '',
    this.vehicleType = '',
    this.visitorVehicle = '',
    this.country_id = '',
    this.state_id = '',
    this.city_id = '',
    this.visitorPinNo = '',
    this.visitorAddress = '',
    this.visitorAddress2 = '',
  });

  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<VisitorPage2> {
  DateTime dateTime;
  List locatonDrop = [];
  List buildingDrop = [];
  List departmentDrop = [];
  List officerDrop = [];
  String location_id;
  var height, width;
  LocationModel locationModel = LocationModel();
  String buildingType;
  String department_id;
  String officerType;
  TextEditingController pusposeVisitCtrl = TextEditingController();
  // date time ?
  TextEditingController controller1 =
      TextEditingController(text: DateTime.now().toString());
  String valueChanged1 ;
  String valueChanged2 ;
  String _valueToValidate1 = '';
  String _valueSaved1 = '';

  Future<String> _getLocationList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getLocation';
    var res = await http.post(
        Uri.parse(url),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print('${resBody['date']}');
    setState(() {
      locatonDrop = resBody['date'];
    });
    print('dhfgd $locatonDrop');
    return "Success";
  }

  Future<String> _getBuildingList(String location_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getBuilding';
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json"
        },
        body: {
          'location_id': location_id,
        });
    var resBody = json.decode(res.body);
    setState(() {
      buildingDrop = resBody['date'];
    });
    print('Building $buildingDrop');
    return "Success";
  }

  Future<String> _getDepartmentList(String building_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getDepartment';
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json"
        },
        body: {
          'building_id': building_id,
        });
    var resBody = json.decode(res.body);
    setState(() {
      departmentDrop = resBody['date'];
    });
    print('Department $departmentDrop');
    return "Success";
  }

  Future<String> _getOfficerList(String department_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getOfficer';
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json"
        },
        body: {
          'department_id': department_id,
        });
    var resBody = json.decode(res.body);
    setState(() {
      officerDrop = resBody['date'];
    });
    print('Officer $officerDrop');
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    // dateTime = DateTime.now();
    /*  var manager = RequestManager();
    var data = manager.getLocationApi(ApiConstants.Base_Url+RoutePaths.GetLocationUrl)
        .then((value) {
         locationModel = value;
      print('response:${locationModel.status}');
      if (locationModel.status == 'success') {
        BaseMethod().VMSToastMassage('${locationModel.status}');

        setState(() {
        //  locatonDrop=resBody['date'];
        });
        print('dhfgd $locatonDrop');
      }
    });*/
    print("datetime$valueChanged1");
    print("controller----$valueChanged1");
    // print("datetimenow$dateTime");

    _getLocationList();
    print("visitorname--" +
        widget.visitorName.toString() +
        "visitor email-- " +
        widget.visitorEmail.toString() +
        "visitor phone -- " +
        widget.visitorPhone.toString());
    print("pincode--" +
        widget.visitorPinNo.toString() +
        " address 1--" +
        widget.visitorAddress.toString() +
        "address 2-- " +
        widget.visitorAddress2.toString());
    print("visitor vehicle no--" +
        widget.visitorVehicle.toString() +
        "country id-- " +
        widget.country_id.toString() +
        "state id-- " +
        widget.state_id.toString() +
        "city id-- " +
        widget.city_id.toString());
    print(" vehicle type --" +
        widget.vehicleType.toString() +
        " purpose visit--" +
        widget.purposeVisitType.toString() +
        "document type-- " +
        widget.documentType.toString() +
        " gender type--" +
        widget.genderType.toString());

    print("document number--" +
        widget.visitorAdhdhar.toString() +
        " visit duration-- " +
        widget.visitDurationType.toString());

    print("File Name >>2 " + widget.fileName.toString());
  }

  bool validatedetail() {
    if (location_id == null) {
      BaseMethod().VMSToastMassage("Select Location");
      return false;
    } else if (buildingType == null) {
      BaseMethod().VMSToastMassage("Select Building");
      return false;
    } else if (department_id == null) {
      BaseMethod().VMSToastMassage("Select Department");
      return false;
    } else if (officerType == null) {
      BaseMethod().VMSToastMassage("Select Officer");
      return false;
    }
    else if (valueChanged1 == null) {
      BaseMethod().VMSToastMassage("Select Date and Time");
      return false;
    }

    return true;
  }

  Widget build(BuildContext context) {

    return initWidget();
  }

  Widget initWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);
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
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Container(
                        //     child: Text(
                        //       "Visiting Address",
                        //       style: TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.blue[600]),
                        //     )),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Container(
                            width: width,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[900]
                            ),
                            child: Text(
                              "Visiting Office Address",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 20, right: 20,top:20),
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
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 36,
                                  isExpanded: true,
                                  value: location_id,
                                  hint: Text('Select Your Location*'),
                                  items: locatonDrop.map((e) {
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
                                  }).toList(),
                                  onChanged: (String val) {
                                    setState(() {
                                      location_id = val;
                                      buildingType = null;
                                      department_id = null;
                                      officerType = null;

                                      _getBuildingList(val);
                                    });
                                  }),
                            )
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20, right: 20,top:20),
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
                                  value: buildingType,
                                  hint: Text('Select Your Building*'),
                                  items: buildingDrop?.map((ee) {
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
                                  onChanged: (String val) {
                                    setState(() {
                                      buildingType = val;
                                      department_id = null;
                                      officerType = null;
                                      _getDepartmentList(val);
                                    });
                                  }),
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20, right: 20,top: 20),
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
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 36,
                                  isExpanded: true,
                                  value: department_id,
                                  hint: Text('Select Your Department*'),
                                  items: departmentDrop?.map((e) {
                                    return DropdownMenuItem(
                                      value: e['id'].toString(),
                                      child: Text(
                                        e['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  })?.toList(),
                                  onChanged: (String val) {
                                    setState(() {
                                      department_id = val;
                                      officerType = null;
                                      _getOfficerList(val);
                                    });
                                  }),
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                                  value: officerType,
                                  hint: Text('Select Your Officer*'),
                                  items: officerDrop?.map((ee) {
                                    return DropdownMenuItem(
                                      value: ee['id'].toString(),
                                      child: Text(
                                        ee['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  })?.toList(),
                                  onChanged: (String val) {
                                    setState(() {
                                      officerType = val ?? "";
                                    });
                                  }),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        new GestureDetector(
                          onTap: () {
                            print("dgh");
                            // showDatePicker(context: context, initialDate: DateTime.now(), firstDate: firstDate, lastDate: lastDate)
                          },
                          child: Container(

                            margin: const EdgeInsets.only(left: 20, right: 20),
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'yyyy-MMM-d',
                              initialValue: valueChanged1,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event),
                              dateLabelText: 'Date',
                              timeLabelText: "Hour",
                              selectableDayPredicate: (date) {
                                // Disable weekend days to select from the calendar
                                if (date.weekday == 6 || date.weekday == 7) {
                                  return false;
                                }

                                return true;
                              },
                              onChanged: (val) {
                                setState(() {
                                  valueChanged1 = val;
                                  valueChanged2 = DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.parse(valueChanged1));
                                  print(valueChanged1);
                                  print(valueChanged2);
                                });
                              },
                              // validator: (val) {
                              //   setState(() => _valueToValidate1 = val);
                              //   return null;
                              // },
                              onSaved: (val) => setState(() => _valueSaved1 = val),
                            ),
                          ),
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
                                      if (validatedetail()) {
                                        FocusManager.instance.primaryFocus.unfocus();
                                        print("hello");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => VisitorPage3(
                                                  location_id: location_id,
                                                  buildingType: buildingType,
                                                  department_id: department_id,
                                                  officerType: officerType,
                                                  visitorName: widget.visitorName,
                                                  documentType: widget.documentType,
                                                  genderType: widget.genderType,
                                                  fileName: widget.fileName,
                                                  visitorAdhdhar: widget.visitorAdhdhar,
                                                  visitorEmail: widget.visitorEmail,
                                                  visitorPhone: widget.visitorPhone,
                                                  visitDurationType: widget.visitDurationType,
                                                  purposeVisitType: widget.purposeVisitType,
                                                  vehicleType: widget.vehicleType,
                                                  country_id: widget.country_id,
                                                  state_id: widget.state_id,
                                                  city_id: widget.city_id,
                                                  visitorVehicle: widget.visitorVehicle,
                                                  visitorPinNo: widget.visitorPinNo,
                                                  visitorAddress: widget.visitorAddress,
                                                  visitorAddress2: widget.visitorAddress2,
                                                  valueChanged1: valueChanged2,
                                                )));
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
                )
            )
        ));
  }
}
