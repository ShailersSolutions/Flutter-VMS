import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/Constants/ApiConstants.dart';
import 'package:facechk_app/Constants/RoutePaths.dart';
import 'package:facechk_app/Models/sendOtpModel.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:facechk_app/Screen/otp_page.dart';
import 'package:facechk_app/Screen/visitor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class KnownStatus extends StatefulWidget {
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<KnownStatus> {
  bool loading = false;
  var height, width;
  TextEditingController mobileController = TextEditingController();
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    SendOtpModel sendOtpModels = SendOtpModel();

    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
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
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                          child: Text(
                        "Visitor Management System",
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                      )),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "Know Visit Status",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[900]),
                                )),
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
                                      controller: mobileController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.call,color: Colors.black87,),
                                          hintText: "Enter your Mobile Number"),
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  )
                                ],
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
                                        Navigator.pop(context, false);
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
                                        print('Know Visit Status');
                                        if(mobileController.text.isEmpty){
                                          BaseMethod().VMSToastMassage("Enter your mobile number");
                                        }else{
                                          setState(() {
                                            loading = true;
                                          });

                                          var manager = RequestManager();
                                          var data = manager
                                              .sendOtp(
                                              mobileController.text.toString(),
                                              'know_status')
                                              .then((value) {
                                            print('response:$value');
                                            sendOtpModels = value;
                                            print('response:${sendOtpModels.msg}');
                                            if (sendOtpModels.status == 'success') {
                                              setState(() {
                                                loading = false;
                                              });
                                              BaseMethod().VMSToastMassage(sendOtpModels.msg);

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => OtpPage(
                                                          mobilenumber:
                                                          mobileController.text.toString(),
                                                          purpose: 'know_status')));
                                            } else if (sendOtpModels.status == 'failed') {
                                              setState(() {
                                                loading = false;
                                              });
                                              BaseMethod().VMSToastMassage(sendOtpModels.msg);
                                            }
                                          });
                                        }

                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      textColor: Colors.white,
                                      child: Text("Submit"),
                                    ),
                                  ]))
                    ]))),

          ])));
  }
}
