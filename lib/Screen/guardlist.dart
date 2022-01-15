// import 'dart:convert';
//
// import 'package:facechk_app/Constants/ApiConstants.dart';
// import 'package:facechk_app/Constants/RoutePaths.dart';
// import 'package:facechk_app/Models/GaurdLoginModel.dart';
// import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
// import 'package:facechk_app/Screen/Staff/visitor_detail_staff.dart';
// import 'package:facechk_app/Screen/Visitor_detail.dart';
// import 'package:facechk_app/Screen/guardlogin.dart';
// import 'package:facechk_app/Screen/guardvisitordetail.dart';
// import 'package:facechk_app/Screen/visitor_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// import 'login_screen.dart';
//
// class GuardDashboard extends StatefulWidget {
//   GuardDashboardState createState() => GuardDashboardState();
//   List<Datum> vlist;
//
//   GuardDashboard({this.vlist});
// }
//
// class GuardDashboardState extends State<GuardDashboard> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Widget build(BuildContext context) {
//     PreInvitationFormProvider formProvider =
//         Provider.of(context, listen: false);
//     Future<bool> _onWillPop() {
//       return showDialog(
//             context: context,
//             builder: (context) => new AlertDialog(
//               // title: new Text("Confirmation"),
//               content: new Text(
//                 "Do you want to Exit?",
//                 style: TextStyle(color: Colors.black),
//               ),
//               actions: <Widget>[
//                 new FlatButton(
//                   onPressed: () {
//                     SystemNavigator.pop();
//                   },
//                   child: new Text("Yes", style: TextStyle(color: Colors.black)),
//                 ),
//                 new FlatButton(
//                     onPressed: () => Navigator.of(context).pop(false),
//                     child:
//                         new Text("No", style: TextStyle(color: Colors.black))),
//               ],
//             ),
//           ) ??
//           false;
//     }
//
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Color(0XFF4FC3F7),
//             /*(${formProvider.staffLoginModel.locationName})*/
//             title: Text("${formProvider.officeUrlModel.name} "),
//           ),
//           body: Container(
//               child: Column(
//                   children: [
//
//             Flexible(child: getBody()),
//           ]))),
//     );
//   }
//
//   Widget getBody() {
//     if (widget.vlist.contains(null) || widget.vlist.length < 0) {
//       return Center(child: CircularProgressIndicator());
//     }
//     return ListView.builder(
//         itemCount: widget.vlist.length,
//         itemBuilder: (context, index) {
//           return getCard(widget.vlist[index]);
//         });
//   }
//
//   Widget getCard(item) {
//     var id = item.id.toString();
//     var name = item.name;
//     var email = item.email;
//     var status = item.appStatus;
//
//     //visitorListDrop=item['visitor_group'];
//     //var user_id = item['user_id'];
//     // print('mshrgd'+visitorListDrop.toString());
//     return Card(
//       elevation: 1.5,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: ListTile(
//           title: Row(
//             children: <Widget>[
//               SizedBox(
//                 width: 20,
//               ),
//               Expanded(
//                   child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     // SizedBox(
//                     //     width: MediaQuery.of(context).size.width - 140,
//                     //     child: Text(
//                     //       "Id: " + (id ?? ""),
//                     //       style: TextStyle(fontSize: 16),
//                     //     )),
//                     Text(
//                       "FullName: " + (name ?? ""),
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     Text(
//                       "Email: " + (email ?? ""),
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     Text(
//                       "Status: " + (status ?? ""),
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: status == 'Pending' ? Colors.red : Colors.green,
//                       ),
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: RaisedButton(
//                             textColor: Colors.lightBlueAccent,
//                             child: Text('View'),
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => VisitorDetailStaff(
//                                           userId: id.toString())));
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
