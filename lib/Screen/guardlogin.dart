import 'dart:io';
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/CommonMethod/staff_bottom_naviogation.dart';
import 'package:facechk_app/Constants/ApiConstants.dart';
import 'package:facechk_app/Constants/RoutePaths.dart';
import 'package:facechk_app/Models/GaurdLoginModel.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';

import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:facechk_app/Screen/Guard/guard_dashboard.dart';
import 'package:facechk_app/Screen/Guard/guard_main_dashboard.dart';
import 'package:facechk_app/Screen/enter_office_url.dart';
import 'package:facechk_app/Screen/guardlist.dart';
import 'package:facechk_app/Screen/Staff/staff_dashboard.dart';
import 'package:facechk_app/Screen/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GaurdLogin extends StatefulWidget {
  String loginType;
  GaurdLogin({this.loginType});
  _GaurdLoginState createState() => _GaurdLoginState();
}

class _GaurdLoginState extends State<GaurdLogin> {
  // List<Datum> GuardListDrop = [];

  var height, width;
  bool loading = false;
  bool isVisible = true;
  bool Visible = false;
  TextEditingController gaurdNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  // GaurdLoginModel gaurdLoginModel = GaurdLoginModel();

  DateTime currentBackPressTime;

  Widget build(BuildContext context) {

    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: (){

          return/* widget.loginType == "Staff Login" ?*/
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())) ;
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GuardMainDashboard()));
        },
          child: Scaffold(
              body: SingleChildScrollView(
                  child: Column(
                  children: [
                Container(
                  height: height,
                    width: width,
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
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                              ),
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
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left:20),
                                  child: Text(
                                    widget.loginType,
                                    style: TextStyle(
                                        fontSize: 21,
                                        //fontStyle: FontStyle.italic,
                                        color: Colors.blue[900]),
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
                                        height: height*0.07,
                                        margin: EdgeInsets.only(left: 20, right: 20),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15.0),
                                            color: Colors.white
                                        ),
                                        child: TextFormField(
                                          controller: gaurdNameCtrl,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Icon(Icons.email,color: Colors.black87,),
                                              hintText: "Email"),
                                        ),
                                      ),
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
                                        height: height*0.07,
                                        margin: EdgeInsets.only(left: 20, right: 20),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15.0),
                                            color: Colors.white
                                        ),
                                        child: TextFormField(
                                          controller: passwordCtrl,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Icon(Icons.lock,color: Colors.black87,),
                                              hintText: " Password"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 30,
                              ),

                             loading? CircularProgressIndicator(
                               valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
                             ) : Container(
                                width: width,
                                  height: height*0.07,
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    color: Colors.blue[900],
                                    textColor: Colors.white,
                                    child: Text('Sign In',style: TextStyle(fontSize: 16),),
                                    onPressed: () async{
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      setState(() {
                                        loading = true;
                                      });
                                      print('Visitor List ');
                                      if(widget.loginType == "Staff Login"){
                                        if(gaurdNameCtrl.text.isEmpty || passwordCtrl.text.isEmpty){
                                          BaseMethod().VMSToastMassage("Please fill all the details");
                                        }else {
                                          await RequestManager().staffLogin(gaurdNameCtrl.text,
                                              passwordCtrl.text,formProvider.officeUrlModel.id).then((value){
                                            setState(() {
                                              loading = false;
                                            });
                                            print(value);
                                            print(value.runtimeType);
                                            print(value.name);
                                            if(value.message == "Please check login Credentials"){
                                              BaseMethod().VMSToastMassage("Please check login Credential");
                                            }else{
                                              prefs.setInt('staffId', value.id);
                                              context.read<PreInvitationFormProvider>().setStaffLoginDetails(value);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => StaffBottomNavBar(),
                                                  ));
                                            }

                                          });

                                        }
                                      }else{
                                        if(gaurdNameCtrl.text.isEmpty || passwordCtrl.text.isEmpty){
                                          BaseMethod().VMSToastMassage("Please fill all the details");
                                        }else {
                                          await RequestManager().guardLogin(gaurdNameCtrl.text, passwordCtrl.text, formProvider.officeUrlModel.id).then((value) {
                                            setState(() {
                                              loading = false;
                                            });
                                            if(value.guardLoginModelClass == "error"){
                                              BaseMethod().VMSToastMassage("You have entered invalid credentials");
                                            }else if(value.guardLoginModelClass == "success"){
                                              prefs.setInt('guardId', value.guardDetails.id);
                                              prefs.setString('guardEmail', gaurdNameCtrl.text);
                                              prefs.setString('guardPassword', passwordCtrl.text);
                                              context.read<PreInvitationFormProvider>().setGuardLoginDetails(value);
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => GuardMainDashboard(),));
                                            }
                                          });
                                        }
                                      }

                                    },
                                  )),
                              Container(
                                  width: width,
                                  height: height*0.07,
                                  margin: EdgeInsets.only(left: 20, right: 20,top: 20),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    color: Colors.blue[900],
                                    textColor: Colors.white,
                                    child: Text('Login as',style: TextStyle(fontSize: 16),),
                                    onPressed: () async{
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                                    },
                                  )),
                              SizedBox(
                                height: 20,
                              ),

                            ]))),

              ]))),
        );

  }


  bool validatedetail() {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    RegExp regExp = new RegExp(pattern);

    var password;
    stdout.write("Enter Your  Password: ");
    password = stdin.readLineSync();

    if (gaurdNameCtrl.text.isEmpty) {
      BaseMethod().VMSToastMassage(' Enter Your Email');
      return false;
    } else if (!regExp.hasMatch(gaurdNameCtrl.text)) {
      BaseMethod().VMSToastMassage(' Enter a Valid Email');
      return false;
    } else if (passwordCtrl.text.isEmpty) {
      BaseMethod().VMSToastMassage(' Enter Your Password');
      return false;
    } else if (passwordCtrl.text.length >= 10 &&
        !password.contains(RegExp(r'\W')) &&
        RegExp(r'\d+\w*\d+').hasMatch(password)) {
      print(" \n\t$password is inValid Password");
      return false;
    }
    return true;
  }

}
