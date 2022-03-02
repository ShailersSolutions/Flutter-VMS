import 'package:facechk_app/CommonMethod/access_box.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Guard/guard_dashboard.dart';
import 'package:facechk_app/Screen/guardlogin.dart';
import 'package:facechk_app/Screen/known_status.dart';
import 'package:facechk_app/Screen/login_screen.dart';
import 'package:facechk_app/Screen/qrcode.dart';
import 'package:facechk_app/Screen/send_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuardMainDashboard extends StatefulWidget {
  const GuardMainDashboard({Key key}) : super(key: key);

  @override
  _GuardMainDashboardState createState() => _GuardMainDashboardState();
}

class _GuardMainDashboardState extends State<GuardMainDashboard> {
  var height, width;
  var guardId;

  getGuardId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      guardId = prefs.getInt('guardId');
      print("guardId   $guardId");
    });
  }

  @override
  void initState() {
    getGuardId();
    super.initState();
  }

  @override
  Widget build (BuildContext context) {

    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: (){
        return SystemNavigator.pop();
      },
      child: Scaffold(
          body: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [( Color(0XFF4FC3F7)), Color(0XFF81D4FA),Color(0XFFB3E5FC)]
                  )
              ),
              child: SingleChildScrollView(
                child: Center(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: height*0.15,
                            width: width*0.5,
                            color: Colors.transparent,
                            margin: EdgeInsets.only(top: 50,bottom: 15),
                            child: Image.network(formProvider.officeUrlModel.logo,fit: BoxFit.contain,),
                          ),
                          Container(
                            // margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Guard Access",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          AccessMethod(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GuardMain()));
                            },
                            image: 'images/skills.png',
                            text: 'Check Visitors List',
                          ),

                          // AccessMethod(
                          //   onTap: (){
                          //     Navigator.push(context, MaterialPageRoute(
                          //         builder: (context)=>SendOtp(mytitle: 'New_visit',)
                          //     ));
                          //   },
                          //   text: "New Visit",
                          //   image: 'images/newvisitors.jpg',
                          // ),
                          // AccessMethod(
                          //   onTap: (){
                          //     Navigator.push(context, MaterialPageRoute(
                          //         builder: (context)=>SendOtp(mytitle: 're_visit',)
                          //     ));
                          //   },
                          //   image: 'images/revisitors.png',
                          //   text: 'Re Visit',
                          // ),
                          AccessMethod(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=> KnownStatus()
                              ));
                            },
                            text: "Know Visit Status",
                            image: 'images/k.png',
                          ),
                          AccessMethod(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> QRCode(),
                              ));
                            },
                            image: 'images/qr code.jpg',
                            text: 'QR Scanner',
                          ),
                          /*guardId != null ? AccessMethod(
                            onTap: ()async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.remove('guardId');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GaurdLogin(loginType: "Guard Login",)));
                            },
                            image: 'images/person.png',
                            text: 'Guard Log Out',
                          ) :*/
                          AccessMethod(
                            onTap: ()async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.remove('guardId');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GaurdLogin(loginType: "Guard Login",)));
                            },
                            image: 'images/logout.png',
                            text: 'Guard Log Out',
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 50, left: 50),
                            child: Text(
                              "Version 1.0",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        ]
                    )
                ),
              )
          )












        /*body: SingleChildScrollView(
              child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [(new Color(0XFF81D4FA)),new Color(0XFF4FC3F7),Color(0XFFB3E5FC)],
                    )
                ),
                child: Column(
                    children: [
                Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Image.asset("images/facechk_logo.png"),
                        //height: 300,
                        //width: 300,
                      ),
                      Container(
                        // margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Visitor Management System",
                          style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              color: Colors.white
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()=>{
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>SendOtp()
                          ))
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 50, right: 50 ,top:70),
                          alignment:Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [BoxShadow (
                              offset: Offset(0,10),
                              blurRadius: 50,
                              color: Color(0xFF0D47A1),
                            )],
                          ),
                          child:Row(
                              children:[
                                Container(
                                  padding: EdgeInsets.only(left: 20,right: 18,top: 5,bottom: 5),
                                  child: Image.asset("images/newvisitors.jpg"),
                                ),
                                Text(
                                  "New Visit",
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                    color: Colors.blue[900],
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()=>{
                          Navigator.of(context).pop(),
                          Navigator.push(context,MaterialPageRoute(builder:(builder)=>SendOtp()
                          ),
                          )
                        },


                        child: Container(
                          margin: EdgeInsets.only(left: 50, right: 50 ,top:30),
                          alignment:Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [BoxShadow (
                              offset: Offset(0,10),
                              blurRadius: 50,
                              color: Color(0xFF0D47A1),
                            )],
                          ),
                          child:Row(
                              children:[
                                Container(
                                  padding: EdgeInsets.only(left: 20,right: 18,top: 5,bottom: 5),
                                  child: Image.asset("images/revisitors.png"),
                                ),
                                Text(
                                  "Re-Visit",
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                    color: Colors.blue[900],
                                  ),
                                )
                              ]
                          ),
                        ),

                      ),
                      GestureDetector(
                        onTap: ()=>{
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> KnownStatus()
                          ))

                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 50, right: 50 ,top:30),
                          alignment:Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [BoxShadow (
                              offset: Offset(0,10),
                              blurRadius: 50,
                              color: Color(0xFF0D47A1),
                            )],
                          ),
                          child:Row(
                              children:[
                                Container(
                                  padding: EdgeInsets.only(left: 20,right: 18,top: 5,bottom: 5),
                                  child: Image.asset("images/k.png"),
                                ),
                                Text(
                                  "Know Visit Status",
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                    color: Colors.blue[900],
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()=>{
                        // Navigator.push(context, MaterialPageRoute(
                        // builder: (context)=> QRCode(),
                        // ))
                          },
                        child: Container(
                            margin: EdgeInsets.only(left: 50, right: 50 ,top:30,),
                            alignment:Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow (
                                offset: Offset(0,10),
                                blurRadius: 60,
                                color: Color(0xFF0D47A1),
                              )],
                            ),
                            child:Row(
                                      children:[
                                  Container(
                                  padding: EdgeInsets.only(left: 20,right: 18,top: 5,bottom: 5),
                                  child: Image.asset("images/qr code.jpg"),
                                ),
                             Text(
                              "QR Scanner",
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                                color: Colors.blue[900],
                              ),
                            )
]
                        ),
                      ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height*.30,
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 50, left: 50,bottom: 30),
                        child: Text(
                          "Version 1.0",
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ]
                ),
              ),

          ]
      ),
              ),


      ])));*/

      ),
    );
  }
}
