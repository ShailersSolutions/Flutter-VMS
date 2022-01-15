
import 'dart:async';
import 'dart:convert';
import 'package:facechk_app/CommonMethod/staff_bottom_naviogation.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:facechk_app/Screen/Guard/guard_dashboard.dart';
import 'package:facechk_app/Screen/enter_office_url.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:facechk_app/Screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget{
  State<StatefulWidget> createState() =>InitState();
}

class InitState extends State<SplashScreen>{


  void autoLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = prefs.getString('baseUrl');
    if(url == null){
      print("url not found");
    }else{
      print(url);
    }
    var companyId = prefs.getString('companyId');
    var staffId = prefs.getInt('staffId');
    var guardId = prefs.getInt('guardId');
    print("guardId  $guardId");
    print("staffId  $staffId");
    print("companyId  $companyId");
    if(companyId == null){
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => EnterOfficeUrl())));
    }else if(companyId != null && staffId == null && guardId == null ){
      RequestManager().companyData().then((value) {
        context.read<PreInvitationFormProvider>().setOfficeUrlDetails(value);
          return Timer(
              Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen())));
      });
    }else if(companyId != null && staffId != null){
      RequestManager().companyData().then((val) {
        context.read<PreInvitationFormProvider>().setOfficeUrlDetails(val);
      RequestManager().staffData().then((value) {
        context.read<PreInvitationFormProvider>().setStaffLoginDetails(value);
        return Timer(
            Duration(seconds: 3),
                () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => StaffBottomNavBar())));
      });
      });
    }/*else if(companyId != null && guardId == null){
      RequestManager().companyData().then((value) {
        context.read<PreInvitationFormProvider>().setOfficeUrlDetails(value);
        return Timer(
            Duration(seconds: 3),
                () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen())));
      });
    }*/else if(companyId != null && guardId != null){
      RequestManager().companyData().then((val) {
        context.read<PreInvitationFormProvider>().setOfficeUrlDetails(val);
        RequestManager().guardData().then((value) {
          context.read<PreInvitationFormProvider>().setGuardLoginDetails(value);
          return Timer(
              Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => GuardMain())));
        });
      });
    }
    // if(formProvider.officeUrlModel.id == null){
    //   print("EnterOfficeUrl");

    // }else if(formProvider.officeUrlModel.id != null && formProvider.staffId == null){
    //   print("LoginScreen");

    // }else if(formProvider.staffId != null){
    //   print("StaffBottomNavBar");
    //   Timer(
    //       Duration(seconds: 5),
    //           () => Navigator.of(context).pushReplacement(MaterialPageRoute(
    //           builder: (BuildContext context) => StaffBottomNavBar())));
    // }
  }

  @override
  void initState() {

    Permission.camera.request();
    Permission.storage.request();
    super.initState();

    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [( Color(0XFF4FC3F7)), Color(0XFF81D4FA),Color(0XFFB3E5FC),Color(0xFF03A9F4)],
              )
          ),
          child: ListView(
            children: [

              Center(

                  child: Container(
                    margin: EdgeInsets.only(left: 50, right: 50 ,top:70),
                    alignment:Alignment.center,
                    height: 70,
                    width: 500,
                    child: Text(
                      "VZTOR",
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 70,
                      ),
                    ),
                    // child: Image.asset("images/facechk_logo.png"),
                  )
              ),

              Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20 ,top: 40),
                    alignment:Alignment.center,
                    child: Column(
                      children:[ RichText(
                        text: TextSpan(
                          text:
                          "Visitor Management System",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                        SizedBox(height: 15,),
                        Text("Get Safe & TouchLess Entry",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue[900],
                              fontSize: 20,
                            ))
                      ],
                    ),
                  )),
              SizedBox(height: 40,),
              Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top:50,bottom: 20),
                    alignment:Alignment.center,
                    child: Image.asset("images/visitor_logo.png"),
                  )
              ),
              SizedBox(height: 20,),
              Center(
                child: Text("Powered By\nEI NETWORKS PVT LTD",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 20,
                    )),
              )
            ],
          ),
        )
    );
  }
}