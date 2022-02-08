import 'dart:convert';

import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/Models/NewRegistrationModel.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Provider/visitor_form_provider.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:facechk_app/Screen/Visitor_detail.dart';
import 'package:facechk_app/Screen/visitor_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facechk_app/Constants/ApiConstants.dart';
import 'package:facechk_app/Constants/RoutePaths.dart';
import 'package:facechk_app/Screen/visitor_page3.dart';
import 'package:facechk_app/Screen/visitor_page5.dart';
import 'package:facechk_app/ApiService/loading.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitorPage5 extends StatefulWidget {
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<VisitorPage5> {
  bool loading = false;
  // TextEditingController covidBodyTempCtrl = TextEditingController();
  var first_click = true;

  List sympttomsDrop = [];
  String takenVaccineType;
  final List<String> accountType =
  ['yes', 'no'];

  String currentVaccineDose;
  String currentVaccineDoseValue;

  final List<String> vaccineType = [
        'First Dose',
    'Second Dose','Booster Dose'
  ];

  String currentVaccineCompany;

  final List<String> vaccineCompany = [
    'Covishield',
    'Covaxin',
    'Sputnik V',
    'ZyCoV-D',
    'mRNA-1273',
  ];

  String currentSymptomsType;
  String dayTravelledType;
  final List<String> accountType2 = [

    'yes',
    'no'
  ];
  String touchCovidPatientType;
  final List<String> accountType3 = [

    'yes',
    'no',
  ];
  Future<String> _getSymptomsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var companyUrl = prefs.getString('baseUrl');
    var url = 'https://vztor.in/$companyUrl/public/api/getSymptoms';
    var res = await http.post(
        Uri.parse(url),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print('${resBody['date']}');
    setState(() {
      sympttomsDrop = resBody['date'];
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    _getSymptomsList();
  }

  bool validatedetail() {
    if (takenVaccineType == accountType[0]) {
      BaseMethod().VMSToastMassage("Select Have you taken Vaccine");
      return false;
    } else if (currentSymptomsType == null) {
      BaseMethod().VMSToastMassage("Select Symptoms ");
      return false;
    } else if (dayTravelledType == null) {
      BaseMethod().VMSToastMassage(
          "Select Have you travelled in past 14 days to any of the state?");
      return false;
    } else if (touchCovidPatientType == null) {
      print("image mode");
      BaseMethod().VMSToastMassage(
          "Did you get in touch with any Covid positive patient ?");

      return false;
    }

    return true;
  }

  bool viewVisible = false;
  var height, width;

  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);
    VisitorFormProvider visitorFormProvider = Provider.of(context, listen: false);
    final routeData =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    print("Navigator data5 " + routeData['visitAssetInfoNameCtrl']);

    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF4FC3F7),
          title: Text("${formProvider.officeUrlModel.name}"),
        ),
            body: Container(

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
                              "Covid Declaration Form",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
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
                              hint: Text('Have you taken the vaccine?*'),
                              isExpanded: true,
                              value: takenVaccineType,
                              items: accountType.map((accountType) {
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
                                if (val == 'yes') {
                                  setState(() {
                                    viewVisible = true;
                                  });
                                } else {
                                  setState(() {
                                    viewVisible = false;
                                    currentVaccineDose = null;
                                    currentVaccineCompany = null;
                                  });
                                }
                                setState(() {
                                  takenVaccineType = val;
                                  visitorFormProvider.takenVaccine = takenVaccineType;
                                  print("takenVaccineType  $takenVaccineType");
                                });
                              },
                            ),
                          ),
                        ),

                        //  vaccinetype:
                        Visibility(
                          visible: viewVisible,
                          child: Container(
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
                                hint: Text('Which dose of vaccine have you taken?*'),
                                isExpanded: true,
                                value: currentVaccineDose,
                                items: vaccineType.map((accountType) {
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
                                    currentVaccineDose = val;
                                    if(currentVaccineDose == "First Dose"){
                                      currentVaccineDoseValue = "1";
                                    }else if(currentVaccineDose == "Second Dose"){
                                      currentVaccineDoseValue = "2";
                                    }else if(currentVaccineDose == "Booster Dose"){
                                      currentVaccineDoseValue = "3";
                                    }
                                    print("selecteddose  $currentVaccineDoseValue");
                                    visitorFormProvider.doseOfVaccine = currentVaccineDose;
                                    visitorFormProvider.doseOfVaccineValue = currentVaccineDoseValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),

                        //  vaccinetype:
                        Visibility(
                          visible: viewVisible,
                          child: Container(
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
                                hint: Text('Select vaccine name:*'),
                                isExpanded: true,
                                value: currentVaccineCompany,
                                items: vaccineCompany.map((accountType) {
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
                                    currentVaccineCompany = val;
                                    visitorFormProvider.vaccineName = currentVaccineCompany;
                                    // print("selelctedcompany$currentVaccineCompany");
                                  });
                                },
                              ),
                            ),
                          ),
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
                              value: currentSymptomsType,
                              hint: Text(
                                  'Are you currently experiencing any following symptoms?*'),
                              items: sympttomsDrop?.map((e) {
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
                                  currentSymptomsType = val;
                                  visitorFormProvider.currentlyExperiencing = currentSymptomsType;
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
                              hint: Text('Have you travelled in past 14 days to any of the state?*'),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              isExpanded: true,
                              value: dayTravelledType,
                              items: accountType2.map((accountType) {
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
                                  dayTravelledType = val ?? "";
                                  visitorFormProvider.travelled = dayTravelledType;
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
                              hint: Text('Did you get in touch with any Covid positive patient ?*'),
                              isExpanded: true,
                              value: touchCovidPatientType,
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
                                  touchCovidPatientType = val ;
                                  visitorFormProvider.covidPatient = touchCovidPatientType;
                                });
                              },
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, right: 20),
                        //   alignment: Alignment.center,
                        //   child: TextFormField(
                        //     controller: covidBodyTempCtrl,
                        //     decoration: InputDecoration(
                        //         border: OutlineInputBorder(),
                        //         labelText: "Current Body Temperature*"),
                        //     keyboardType: TextInputType.number,
                        //     inputFormatters: <TextInputFormatter>[
                        //       LengthLimitingTextInputFormatter(4),
                        //       FilteringTextInputFormatter.digitsOnly
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
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
                                  loading
                                      ? Loading()
                                      :RaisedButton(
                                    color: Colors.blue[900],
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus.unfocus();
                                      if (true) {
                                        // print('hlllo');
                                        // print("vaccine----" + takenVaccineType);
                                        // print("vaccine dose" + currentVaccineDose);
                                        // print("vaccine company" + currentVaccineCompany);
                                        // print("vaccine symptoms" + currentSymptomsType);
                                        // print(" travelled" + dayTravelledType);
                                        // print("touch patient " + touchCovidPatientType);
                                        // print(
                                        //     "temperature " + covidBodyTempCtrl.text.toString());

                                        NewRegistrationModel newRegistrationModel = NewRegistrationModel();

                                        setState(() {
                                          loading = true;
                                          print("loading true");
                                        });
                                        BaseMethod().VMSToastMassage('Please wait');
                                        String visName = routeData['visitorName'];
                                        String visEmail = routeData['visitorEmail'];
                                        String visPhone = routeData['visitorPhone'];
                                        String visdocumentType = routeData['documentType'];
                                        String visitorAdhdhar = routeData['visitorAdhdhar'];
                                        String purposeVisitType = routeData['purposeVisitType'];
                                        String genderType = routeData['genderType'];
                                        String visitDurationType = routeData['visitDurationType'];
                                        String fileName = routeData['fileName'];
                                        String officerType = routeData['officerType'];

                                        String country_id = routeData['country_id'];
                                        String state_id = routeData['state_id'];
                                        String city_id = routeData['city_id'];
                                        String pincode = routeData['visitorPinNo'];
                                        String address_1 = routeData['visitorAddress'];
                                        String address_2 = routeData['visitorAddress2'];
                                        String organizationNameCtrl =
                                        routeData['organizationNameCtrl'];
                                        String orga_country_id = routeData['org_country_id'];
                                        String orga_state_id = routeData['org_state_id'];
                                        String orga_city_id = routeData['org_city_id'];
                                        String organizationpinCtrl =
                                        routeData['organizationpinCtrl'];
                                        String department_id = routeData['department_id'];
                                        String location_id = routeData['location_id'];
                                        String building_id = routeData['buildingType'];

                                        String visite_duration = routeData['visitDurationType'];
                                        String visite_time = routeData['dateTime'];
                                        String vehical_type = routeData['vehicleType'];
                                        String vehical_reg_num = routeData['visitorVehicle'];
                                        String pan_drive =
                                        routeData['visitAssetInfoPanDriverCtrl'];
                                        String hard_disk =
                                        routeData['visitAssetInfoHardDiskCtrl'];
                                        String assets_name =
                                        routeData['visitAssetInfoNameCtrl'];
                                        String assets_number =
                                        routeData['visitAssetInfoHardDiskCtrl'];

                                        String assets_brand =
                                        routeData['visitAssetInfoNameCtrl'];
                                        String fileNameProfile = routeData['fileNameProfile'];

                                        var manager = RequestManager();

                                        manager
                                            .newRegistrationApi(
                                          visName != null ? visName : "",
                                          visEmail != null ? visEmail : "",
                                          visPhone != null ? visPhone : "",
                                          visdocumentType != null ? visdocumentType : "",
                                          visitorAdhdhar != null ? visitorAdhdhar : "",
                                          purposeVisitType != null ? purposeVisitType : "",
                                          genderType != null ? genderType : "",
                                          visite_time != null ? visite_time : "",
                                          visitDurationType != null ? visite_duration : "",
                                          fileName != null ? fileName : "",
                                          officerType != null ? officerType : "",
                                          takenVaccineType != null ? takenVaccineType : "",
                                          currentVaccineDose != null ? currentVaccineDose : "",
                                          currentVaccineCompany != null
                                              ? currentVaccineCompany
                                              : "",
                                          currentSymptomsType != null
                                              ? currentSymptomsType
                                              : "",
                                          dayTravelledType != null ? dayTravelledType : "",
                                          touchCovidPatientType != null
                                              ? touchCovidPatientType
                                              : "",
                                          /*covidBodyTempCtrl.text.toString() != null
                                              ? covidBodyTempCtrl.text.toString()
                                              :*/ "",
                                          country_id != null ? country_id : "",
                                          state_id != null ? state_id : "",
                                          city_id != null ? city_id : "",
                                          pincode != null ? pincode : "",
                                          address_1 != null ? address_1 : "",
                                          address_2 != null ? address_2 : "",
                                          organizationNameCtrl != null
                                              ? organizationNameCtrl
                                              : "",
                                          orga_country_id != null ? orga_country_id : "",
                                          orga_state_id != null ? orga_state_id : "",
                                          orga_city_id != null ? orga_city_id : "",
                                          organizationpinCtrl != null
                                              ? organizationpinCtrl
                                              : "",
                                          department_id != null ? department_id : "",
                                          location_id != null ? location_id : "",
                                          building_id != null ? building_id : "",
                                          vehical_type != null ? vehical_type : "",
                                          vehical_reg_num != null ? vehical_reg_num : "",
                                          pan_drive != null ? pan_drive : "",
                                          hard_disk != null ? hard_disk : "",
                                          assets_name != null ? assets_name : "",
                                          assets_number != null ? assets_number : "",
                                          assets_brand != null ? assets_brand : "",
                                          fileNameProfile != null ? fileNameProfile : "",
                                        )
                                            .then((value) {
                                          print('response:$value');
                                          newRegistrationModel = value;
                                          print('response:${newRegistrationModel.message}');

                                          if (newRegistrationModel.status == "success") {
                                            print("all Done");
                                            // var visitor_id =
                                            // newRegistrationModel.visitorId.toString();
                                            //
                                            // print(" visitt id---${visitor_id}");
                                            // // setState(() {
                                            // //   loading = false;
                                            // // });
                                            BaseMethod().VMSToastMassage(
                                                '${newRegistrationModel.message}');

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => VisitorScreen(
                                                        )));
                                          } else if (newRegistrationModel.status == "failed") {
                                            print(
                                                'failed status msg : ${newRegistrationModel.message}');
                                            setState(() {
                                              loading = false;
                                            });
                                            BaseMethod().VMSToastMassage(
                                                '${newRegistrationModel.message}');
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => VisitorScreen()));
                                          }
                                        });

                                        first_click = false;
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    textColor: Colors.white,
                                    child: Text("Submit"),
                                  ),
                                ]))
                  ]),
                ))));
  }
}
