// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:facechk_app/ApiService/BaseMethod.dart';
// import 'package:facechk_app/ApiService/Loading.dart';
// import 'package:facechk_app/Constants/ApiConstants.dart';
// import 'package:facechk_app/Constants/RoutePaths.dart';
// import 'package:facechk_app/Models/DetailQRModel.dart';
//
// import 'package:facechk_app/RequestManager/RequestManager.dart';
// import 'package:facechk_app/Screen/visitor_forms.dart';
//
// import 'package:flutter/material.dart';
// import 'package:barcode_widget/barcode_widget.dart';
// import 'package:http/http.dart' as http;
//
// class VisitorDetail extends StatefulWidget {
//   String visit_id;
//   VisitorDetail({this.visit_id = ''});
//
//   @override
//   _VisitorDetailState createState() => _VisitorDetailState();
// }
//
// class _VisitorDetailState extends State<VisitorDetail> {
//   var fname = '',
//       app_status = '',
//       services = '',
//       email = '',
//       visitPhone = '',
//       gender = '',
//       documentNo = '',
//       Visitimage = '',
//       organization_name = '',
//       vaccine = '',
//       vaccine_name = '',
//       symptoms = '',
//       travelled_states = '',
//       patient = '',
//       temprature = '',
//       slip_id = '',
//       referCode = '',
//       building = '',
//       vaccineCount = '',
//       companyName = '',
//       officer_department = '';
//   List GenerateSlipListDrop = [];
//   bool loading = false;
//   DetailQrModel detailQrModel = DetailQrModel();
//
//   @override
//   void initState() {
//     super.initState();
//     print('hlllo');
//     var manager = RequestManager();
//
//     setState(() {
//       loading = true;
//     });
//
//     var data = manager.GenerateSlipApi(
//             widget.visit_id.toString())
//         .then((value) {
//       print('response:$value');
//       detailQrModel = value;
//       // VisitorGrouprModel=value.data.visitorGroup;
//       print('response:${detailQrModel.toString()}');
//       if (detailQrModel.status == 'success') {
//         String gName;
//         setState(() {
//           fname = detailQrModel.data.name;
//           app_status = detailQrModel.data.appStatus;
//           services = detailQrModel.data.services;
//           email = detailQrModel.data.email;
//           visitPhone = detailQrModel.data.mobile;
//           gender = detailQrModel.data.gender;
//           documentNo = detailQrModel.data.adharNo;
//           Visitimage = detailQrModel.data.image;
//           // profileImage = Base64Decoder().convert(Visitimage);
//
//           print("img--${Visitimage}");
//
//           organization_name = detailQrModel.data.organizationName;
//           vaccine = detailQrModel.data.vaccine;
//           vaccine_name = detailQrModel.data.vaccineName;
//           symptoms = detailQrModel.data.symptoms;
//           travelled_states = detailQrModel.data.travelledStates;
//           patient = detailQrModel.data.patient;
//           temprature = detailQrModel.data.temprature;
//           slip_id = detailQrModel.data.slipId;
//           officer_department = detailQrModel.data.officerDetail.name;
//           referCode = detailQrModel.data.referCode;
//           building = detailQrModel.data.building.name;
//           vaccineCount = detailQrModel.data.vaccineCount;
//           companyName = detailQrModel.data.companyName;
//
//           //gName=VisitorGrouprModel.groupMobile.toString();
//           setState(() {
//             loading = false;
//           });
//         });
//
//         BaseMethod().VMSToastMassage('Welcome ${fname}');
//       } else if (detailQrModel.msg == 'failed') {
//         setState(() {
//           loading = false;
//         });
//         print('msg : ${detailQrModel.msg}');
//         BaseMethod().VMSToastMassage('${detailQrModel.status}');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return initWidget();
//   }
//
//   Widget initWidget() {
//     return loading
//         ? Loading()
//         : Scaffold(
//             body: SingleChildScrollView(
//                 child: Column(children: [
//             Container(
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                       (Color(0XFF4FC3F7)),
//                       Color(0XFF81D4FA),
//                       Color(0XFFB3E5FC)
//                     ])),
//                 child: Center(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                       Container(
//                         margin: EdgeInsets.only(top: 50, left: 80, right: 80),
//                         child: Image.asset("images/facechk_logo.png"),
//                         height: 30,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                           child: Text(
//                         "Visitor Management System",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontStyle: FontStyle.italic,
//                             color: Colors.white),
//                       )),
//                     ]))),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//                 child: Text('Appointment Slip & Status: ${app_status}',
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       fontStyle: FontStyle.italic,
//                       color:
//                           app_status == 'Pending' ? Colors.red : Colors.green,
//                       // color: Colors.blue[900]),
//                     ))),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10, left: 10, right: 3),
//               padding: EdgeInsets.all(0),
//               child: Text(
//                 "Visitor Details ",
//                 style: TextStyle(fontSize: 15, color: Colors.blue[900]),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 3, left: 10, right: 5),
//               padding: EdgeInsets.all(0),
//               child: Center(
//                 child: Visitimage != null
//                     ? Image.network(
//                         ApiConstants.ImagePath + Visitimage,
//                         height: 150,
//                         width: 150,
//                       )
//                     : Image.network(
//                         "https://clipartart.com/images/facebook-profile-icon-clipart-7.png",
//                         height: 150,
//                         width: 150,
//                       ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 5),
//               padding: EdgeInsets.all(0),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "VISITOR :${referCode}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "${fname.toUpperCase()}",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "${companyName.toUpperCase()}",
//                       style: TextStyle(fontSize: 20, color: Colors.black),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 3, left: 40, right: 40),
//                     padding: EdgeInsets.all(0),
//                     child: Divider(
//                       height: 10.0,
//                       indent: 5.0,
//                       thickness: 1,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "Visiting Office : ${organization_name}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "Person to meet : ${officer_department}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "Building : ${building}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(4.0),
//                   //   child: Text(
//                   //     "Vaccinated : ${vaccine}",
//                   //     style: TextStyle(fontSize: 22, color: Colors.blue),
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 4.0),
//                     child: Text(
//                       "Covid Declaration :",
//                       style: TextStyle(fontSize: 22, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "Vaccinated : ${vaccine}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "Dose : ${vaccineCount}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "Vaccine Name : ${vaccine_name}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "Current Temperature : ${temprature}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(
//                       "Travelled in past 14 days out side India : ${travelled_states}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(
//                       "Got in touch of any Covid +ve paitent : ${patient}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(
//                       "Any health issue : ${vaccine_name}",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                 ],
//               ),
//               // child: Text(
//               //   "Name: ${fname}\nPurpose of visit: ${services}\nEmail: ${email}\nMobile:"
//               //   " ${visitPhone}\nGender: ${gender}\nOrganization Name: ${organization_name}\nvaccine: ${vaccine}\nVaccine Name: "
//               //   "${vaccine_name}\nSymptoms: ${symptoms}\nTravelled States: ${travelled_states}\nCovid Patient: ${patient}\nTemprature: "
//               //   "${temprature}\n Offer Name: ${officer_department}",
//               //   style: TextStyle(
//               //     fontSize: 15,
//               //   ),
//               // ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 3, left: 10, right: 5),
//               padding: EdgeInsets.all(0),
//               child: Center(
//                 child: BarcodeWidget(
//                   barcode: Barcode.qrCode(),
//                   color: Colors.black,
//                   data: ApiConstants.QrUrl + widget.visit_id.toString(),
//                   width: 200,
//                   height: 200,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             // Center(
//             //     child: Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   mainAxisSize: MainAxisSize.max,
//             //   children: [
//             //     RaisedButton(
//             //       shape: RoundedRectangleBorder(
//             //         borderRadius: BorderRadius.circular(10),
//             //       ),
//             //       textColor: Colors.lightBlueAccent,
//             //       child: Text('Add New Visitor'),
//             //       onPressed: () {
//             //         Navigator.push(
//             //             context,
//             //             MaterialPageRoute(
//             //                 builder: (context) => VisitorForms()));
//             //       },
//             //     ),
//             //   ],
//             // )),
//           ])));
//   }
// }
