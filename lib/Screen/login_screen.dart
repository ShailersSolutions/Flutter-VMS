import 'package:facechk_app/CommonMethod/access_box.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Guard/guard_main_dashboard.dart';
import 'package:facechk_app/Screen/enter_office_url.dart';
import 'package:facechk_app/Screen/guardlogin.dart';
import 'package:facechk_app/Screen/qrcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Guard/guard_dashboard.dart';
import 'visitor_screen.dart';
import 'visitor_forms.dart';

class LoginScreen extends StatefulWidget {
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginScreen> {

  var height,width;

  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return initWidget();
  }

  Widget initWidget() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);

    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  TextButton(
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  TextButton(
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      },
      child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: SingleChildScrollView(
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
                      height: height*0.2,
                      width: width*0.7,
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: 50,bottom: 15),
                      child: Image.network(formProvider.officeUrlModel.logo,fit: BoxFit.contain,),
                    ),
                    Container(
                      // margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Visitor Management System",
                        style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                      ),
                    ),
                    AccessMethod(
                      image: "images/staff.png",
                      text: "Staff Access",
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GaurdLogin(loginType: "Staff Login",)));
                      },
                    ),
                        // AccessMethod(
                        //   image: "images/visit.png",
                        //   text: "Visitor Access",
                        //   onTap: (){
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => VisitorScreen()));
                        //   },
                        // ),
                        AccessMethod(
                          image: "images/staff.png",
                          text: "Guard Access",
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => /*GuardMainDashboard()*/
                                  GaurdLogin(loginType: "Guard Login",)));
                          },
                        ),
                        AccessMethod(
                          image: "images/qr code.jpg",
                          text: "Scan QR Code",
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        QRCode()));
                          },
                        ),
                        GestureDetector(
                          onTap: ()async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.remove('companyId');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EnterOfficeUrl()));
                          },
                          child: Container(
                            height: height*0.09,
                            margin: EdgeInsets.all(20),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset('images/globe.png',scale: 7),
                            ),
                          ),
                        ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 50, left: 50, bottom: 50),
                      child: Text(
                        "Version 1.0",
                        style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ),
                  ])))
      ])),
          )),
    );
  }
}
