import 'dart:convert';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Provider/visitor_form_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VisitorPage4 extends StatefulWidget {
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<VisitorPage4> {
  TextEditingController visitAssetInfoNameCtrl = TextEditingController();
  TextEditingController visitAssetInfoSerialNoCtrl = TextEditingController();
  TextEditingController visitAssetInfoBrandCtrl = TextEditingController();
  TextEditingController visitAssetInfoPanDriverCtrl = TextEditingController();
  TextEditingController visitAssetInfoHardDiskCtrl = TextEditingController();

  var height,width;

  Widget build(BuildContext context) {
    return initWidget();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget initWidget() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);
    VisitorFormProvider visitorFormProvider = Provider.of(context, listen: false);
    final routeData =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    print("Navigator organizationNameCtrl $routeData['organizationNameCtrl']");
    print("Navigator org_country_id $routeData['org_country_id']");
    print("Navigator org_state_id $routeData['org_state_id']");
    print("Navigator org_city_id $routeData['org_city_id']");
    print("Navigator organizationpinCtrl $routeData['organizationpinCtrl']");
    print("Navigator fileNameProfile $routeData['fileNameProfile']");
    print("Navigator visitorAdhdhar $routeData['visitorAdhdhar']");

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
                            "Visitor's Assets Information",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: visitorFormProvider.assetName,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: " Asset Name:"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: visitorFormProvider.serialNum,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Serial Number:"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: visitorFormProvider.assetBrand,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: " Asset Brand:"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: visitorFormProvider.penDrive,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "No.Of Pen Drive:"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: visitorFormProvider.hardDisk,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "No. Of Hard Disk:"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),

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
                                RaisedButton(
                                  color: Colors.blue[900],
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus.unfocus();
                                    Navigator.pushNamed(context, '/visitorPage5', arguments: {
                                      'location_id': routeData['location_id'],
                                      'buildingType': routeData['buildingType'],
                                      'department_id': routeData['department_id'],
                                      'officerType': routeData['officerType'],
                                      // 'pusposeVisitCtrl': routeData['pusposeVisitCtrl'],
                                      'visitorName': routeData['visitorName'],
                                      'visitorEmail': routeData['visitorEmail'],
                                      'visitorPhone': routeData['visitorPhone'],
                                      'visitDurationType': routeData['visitDurationType'],
                                      'purposeVisitType': routeData['purposeVisitType'],
                                      'vehicleType': routeData['vehicleType'],
                                      'country_id': routeData['country_id'],
                                      'state_id': routeData['state_id'],
                                      'city_id': routeData['city_id'],
                                      'visitorVehicle': routeData['visitorVehicle'],
                                      'organizationpinCtrl': routeData['organizationpinCtrl'],
                                      'visitorPinNo': routeData['visitorPinNo'],
                                      'visitorAddress': routeData['visitorAddress'],
                                      'visitorAddress2': routeData['visitorAddress2'],
                                      'documentType': routeData['documentType'],
                                      'genderType': routeData['genderType'],
                                      'fileName': routeData['fileName'],
                                      'visitorAdhdhar': routeData['visitorAdhdhar'],
                                      'organizationNameCtrl': routeData['organizationNameCtrl'],
                                      'org_country_id': routeData['org_country_id'],
                                      'org_state_id': routeData['org_state_id'],
                                      'org_city_id': routeData['org_city_id'],
                                      'fileNameProfile': routeData['fileNameProfile'],

                                      'dateTime': routeData['dateTime'],

                                      'visitAssetInfoNameCtrl':
                                       visitorFormProvider.assetName.text.toString(),
                                      'visitAssetInfoSerialNoCtrl':
                                       visitorFormProvider.serialNum.text.toString(),
                                      'visitAssetInfoBrandCtrl':
                                       visitorFormProvider.assetBrand.text.toString(),
                                      'visitAssetInfoPanDriverCtrl':
                                       visitorFormProvider.penDrive.text.toString(),
                                      'visitAssetInfoHardDiskCtrl':
                                       visitorFormProvider.hardDisk.text.toString(),
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  textColor: Colors.white,
                                  child: Text("Next"),
                                ),
                              ]))
                ]),
              ))),
    );
  }
}
