import 'dart:convert';

import 'package:facechk_app/Constants/ApiConstants.dart';
import 'package:facechk_app/Constants/RoutePaths.dart';
import 'package:facechk_app/Constants/enum.dart';
import 'package:facechk_app/Models/CityModel.dart';
import 'package:facechk_app/Models/CountryModel.dart';
import 'package:facechk_app/Models/StateModel.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Provider/visitor_form_provider.dart';
import 'package:facechk_app/Screen/visitor_page2.dart';
import 'package:facechk_app/Screen/visitor_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' as Io;
import 'package:http/http.dart' as http;
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class VisitorForms extends StatefulWidget {
  String purpose;
  String mobileNo;

  VisitorForms({this.purpose = '', this.mobileNo = ''});

  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<VisitorForms> {
  TextEditingController visitorNameCtrl = TextEditingController();
  TextEditingController visitorEmailCtrl = TextEditingController();
  TextEditingController visitorPhoneCtrl = TextEditingController();
  TextEditingController visitorAdhdharCtrl = TextEditingController();
  TextEditingController visitorVehicleCtrl = TextEditingController();
  TextEditingController visitorPinNoCtrl = TextEditingController();
  TextEditingController visitorAddressCtrl = TextEditingController();
  TextEditingController visitorAddress2Ctrl = TextEditingController();
  String country_id;
  String state_id;
  String city_id;
  CountryModel countryData = CountryModel();
  StateModel stateData = StateModel();
  CityModel cityData = CityModel();
  List countryDrop = [];
  List stateDrop = [];
  List cityDrop = [];
  bool disableDropDown = true;
  bool disableDropDownthird = true;
  var height,width;
  String selectGender = "Select Gender*",
      selectDoc = "Select Document*",
  selectVehicle = "Select Vehicle",
  selectVisitDuration = "Select Visit Duration*",
  selectPurposeVisit = "Select Purpose of Visit*";

  // String fileName = 'Attached Documents';
  String fileNameProfile = 'Select Image*';
  String file_name = "Upload Your Document";
  var genderType;
  var documentType;
  var vehicleType;
  var visitDurationType;
  var purposeVisitType;
  String imageSelectProfile;
  final List<String> accountType3 = [
    'Camera',
    'Gallery',
  ];

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


  bool validatedetail() {
    VisitorFormProvider visitorProvider = Provider.of(context, listen: false);
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (visitorProvider.visitorName.text.isEmpty) {
      BaseMethod().VMSToastMassage('Enter Visitor Name');
      return false;
    } else if (visitorProvider.visitorPhone.text.length == 0) {
      BaseMethod().VMSToastMassage('Enter Mobile No');
      return false;
    } else if (!regExp.hasMatch(visitorProvider.visitorPhone.text)) {
      BaseMethod().VMSToastMassage('Enter valid mobile No');
      return false;
    } else if (genderType == null) {
      BaseMethod().VMSToastMassage('Select Gender Type');
      return false;
    } else if (documentType == null) {
      BaseMethod().VMSToastMassage('Select Document Type');
      return false;
    } /*else if (visitorAdhdharCtrl.text.isEmpty) {
      BaseMethod().VMSToastMassage("Enter Document Id Number");
      return false;
    }*/ else if (imageSelectProfile == null) {
      print("image mode");
      BaseMethod().VMSToastMassage("Select Image Mode");

      return false;
    } else if (imageSelectProfile == 'Camera' && fileNameProfile.isEmpty) {
      BaseMethod().VMSToastMassage("Capture Image first");

      return false;
    } else if (imageSelectProfile == 'Gallery' && fileNameProfile.isEmpty) {
      BaseMethod().VMSToastMassage("Select Image first");
      return false;
    } else if (visitDurationType == null) {
      BaseMethod().VMSToastMassage("Select Visit duration");
      return false;
    } else if (purposeVisitType == null) {
      BaseMethod().VMSToastMassage("Select Purpose of Visit");
      return false;
    } /*else if (country_id == null) {
      BaseMethod().VMSToastMassage("Select Country");
      return false;
    } else if (state_id == null) {
      BaseMethod().VMSToastMassage("Select State");
      return false;
    } else if (city_id == null) {
      BaseMethod().VMSToastMassage("Select City");
      return false;
    }*/

    return true;
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Confirmation"),
        content: new Text(
          "Do you want to Exit?",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => VisitorScreen()),
                      (Route<dynamic> route) => false);
            },
            child: new Text("Yes", style: TextStyle(color: Colors.black)),
          ),
          new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child:
              new Text("No", style: TextStyle(color: Colors.black))),
        ],
      ),
    ) ??
        false;
  }

  getMobile() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    VisitorFormProvider visitorProvider = Provider.of(context, listen: false);
    setState(() {
      visitorProvider.visitorPhone.text = pref.getString('mobile');
    });
  }

  @override
  void initState() {
    super.initState();
    print(genderType);
    _getCountryList();
    getMobile();
  }

  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);
    VisitorFormProvider visitorProvider = Provider.of(context, listen: false);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: Text(
                                "New Visitor Entry",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[600]),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: width,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[900]
                              ),
                              child: Text(
                                "Visitor Details",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.center,
                            child: TextFormField(
                              // controller: visitorNameCtrl,
                              controller: visitorProvider.visitorName,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: " Visitor Name:*"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    controller: visitorProvider.visitorEmail,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Visitor Email:"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    controller: visitorProvider.visitorPhone,
                                    // enabled: false,

                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Visitor Phone:*"),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
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
                              child: DropdownButton<Gender>(
                                dropdownColor: Colors.white,
                                hint: Text(selectGender),
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                isExpanded: true,
                                value: genderType,
                                items: Gender.values.map((Gender gender) {
                                  return DropdownMenuItem<Gender>(
                                    value: gender,
                                    child: Text(
                                      genderName(gender),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Gender val) {
                                  setState(() {
                                    genderType = val;
                                    visitorProvider.gender = genderType;
                                    print(visitorProvider.gender);
                                    print(genderId(visitorProvider.gender));
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                                child: DropdownButton<Document>(
                                    dropdownColor: Colors.white,
                                    hint: Text(selectDoc),
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 36,
                                    isExpanded: true,
                                    value: documentType,
                                    items: Document.values.map((Document document) {
                                      return DropdownMenuItem<Document>(
                                        value: document,
                                        child: Text(
                                          documentName(document),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (Document val) {
                                      setState(() {
                                      documentType = val;
                                      visitorProvider.docType = documentType;
                                      });
                                    }),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: visitorProvider.docId,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Document Id Number:"),
                            ),
                          ),
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
                                      color: file_name == "Upload Your Photo*"
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
                                        final bytes = Io.File(image.path).readAsBytesSync();
                                        String img64 = base64Encode(bytes);
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
                                        final bytes = Io.File(image.path).readAsBytesSync();
                                        String img64 = base64Encode(bytes);
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
                            height: 8,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                              padding: EdgeInsets.only(left: 7, right: 7,),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<VisitDuration>(
                                    dropdownColor: Colors.white,
                                    icon: Icon(Icons.arrow_drop_down),
                                    hint: Text(selectVisitDuration),
                                    iconSize: 36,
                                    isExpanded: true,
                                    value: visitDurationType,
                                    items: VisitDuration.values.map((VisitDuration visit) {
                                      return DropdownMenuItem<VisitDuration>(
                                        value: visit,
                                        child: Text(
                                          visitName(visit),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (VisitDuration val) {
                                      setState(() {
                                        visitDurationType = val ?? "";
                                        visitorProvider.visitDuration = visitDurationType;
                                      });
                                    }),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                              padding: EdgeInsets.only(left: 7, right: 7,),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<PurposeVisitType>(
                                    dropdownColor: Colors.white,
                                    icon: Icon(Icons.arrow_drop_down),
                                    hint: Text(selectPurposeVisit),
                                    iconSize: 36,
                                    isExpanded: true,
                                    value: purposeVisitType,
                                    items: PurposeVisitType.values.map((PurposeVisitType visit) {
                                      return DropdownMenuItem(
                                        value: visit,
                                        child: Text(
                                          purposeName(visit),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (PurposeVisitType val) {
                                      setState(() {
                                      purposeVisitType = val ?? "";
                                      visitorProvider.purposeOfVisit = purposeVisitType;
                                      });
                                    }),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                              padding: EdgeInsets.only(left: 7, right: 7,),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Vehicle>(
                                    dropdownColor: Colors.white,
                                    icon: Icon(Icons.arrow_drop_down),
                                    hint: Text(selectVehicle),
                                    iconSize: 36,
                                    isExpanded: true,
                                    value: vehicleType,
                                    items: Vehicle.values.map((Vehicle vehicle) {
                                      return DropdownMenuItem<Vehicle>(
                                        value: vehicle,
                                        child: Text(
                                          vehicleName(vehicle),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (Vehicle val) {
                                      setState(() {
                                        vehicleType = val ?? "";
                                        visitorProvider.vehicleType = vehicleType;
                                      });
                                    }),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: visitorProvider.vehicleRegNum,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "DL-8C-0556",
                                  labelText: "Vehicle Registration Number:"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.only( left: 20, right: 20),
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
                                  items: countryDrop?.map((e) {
                                    print("countryDrop----$countryDrop");
                                    return DropdownMenuItem(
                                      value: e['id'].toString(),
                                      child: new Text(e['name'].toString(),style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),),
                                    );
                                  })?.toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      country_id = newVal;
                                      visitorProvider.country = country_id;
                                      state_id = null;
                                      city_id = null;
                                      print('selectcountry---${visitorProvider.country}');
                                      _getStateList(country_id);
                                    });
                                  },
                                  value: country_id,
                                  hint: Text('Select Your Country'),
                                ),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                  value: state_id,
                                  hint: Text('Select Your State'),
                                  onChanged: (val) {
                                    setState(() {
                                      state_id = val;
                                      visitorProvider.state = state_id;
                                      city_id = null;
                                      print('selectstate---$state_id');
                                      _getCityList(val);
                                      print(visitorProvider.state);
                                    });
                                  },
                                  items: stateDrop?.map((ee) {
                                    return DropdownMenuItem<String>(
                                      value: ee['id'].toString(),
                                      child: new Text(
                                        ee['name'].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  })?.toList(),
                                ),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                  value: city_id,
                                  hint: Text('Select Your City'),
                                  onChanged: (String valCity) {
                                    setState(() {
                                      city_id = valCity;
                                      visitorProvider.city = city_id;
                                      print(visitorProvider.city);
                                    });
                                  },
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
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    controller: visitorProvider.pinCode,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(), labelText: "Pincode:"),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(6),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    controller: visitorProvider.address1,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(), labelText: "Address-1:"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    controller: visitorProvider.address2,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(), labelText: "Address-2:"),
                                  ),
                                )
                              ],
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => VisitorPage2(
                                                    visitorName: visitorProvider.visitorName.text.toString(),
                                                    visitorEmail: visitorProvider.visitorEmail.text.toString(),
                                                    visitorPhone: visitorProvider.visitorPhone.text.toString(),
                                                    genderType: genderId(visitorProvider.gender),
                                                    documentType: documentId(visitorProvider.docType),
                                                    visitorAdhdhar: visitorProvider.docId.text.toString(),
                                                    fileName: fileNameProfile.toString(),
                                                    visitDurationType: visitId(visitorProvider.visitDuration),
                                                    purposeVisitType: purposeId(visitorProvider.purposeOfVisit),
                                                    vehicleType: vehicleId(visitorProvider.vehicleType),
                                                    visitorVehicle: visitorProvider.vehicleRegNum.text.toString(),
                                                    country_id: country_id,
                                                    state_id: state_id,
                                                    city_id: city_id,
                                                    visitorPinNo: visitorProvider.pinCode.text.toString(),
                                                    visitorAddress: visitorProvider.address1.text.toString(),
                                                    visitorAddress2: visitorProvider.address2.text.toString(),
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
                  )))),
    );
  }

}
