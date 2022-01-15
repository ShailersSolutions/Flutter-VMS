import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/Constants/RoutePaths.dart';
import 'package:facechk_app/Models/OtpVerifyModel.dart';
import 'package:facechk_app/Models/sendOtpModel.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:facechk_app/Screen/KnowStatusList.dart';
import 'package:facechk_app/Screen/visitor_forms.dart';
import 'package:facechk_app/Constants/ApiConstants.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:timer_button/timer_button.dart';

class OtpPage extends StatefulWidget {
  String mobilenumber;
  String purpose;
  OtpPage({this.mobilenumber = '', this.purpose = ''});
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<OtpPage> {
  bool loading = false, hasError = false;
  var height, width;
  TextEditingController otpController = TextEditingController();
  OtpVerifyModel otpverifymodel = OtpVerifyModel();
  SendOtpModel sendOtpModel = SendOtpModel();

  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;


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
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "Enter Your  Otp",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[900]),
                                )),
                          ),
                          Center(
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: PinCodeTextField(
                                  autofocus: true,

                                  controller: otpController,
                                  hideCharacter: false,
                                  highlight: true,pinBoxRadius: 10,
                                  highlightColor: Colors.white,
                                  defaultBorderColor: Colors.white,
                                  hasTextBorderColor: Colors.white,
                                  highlightPinBoxColor: Colors.white,
                                  maxLength: 6,
                                  hasError: hasError,
                                  onTextChanged: (text) {
                                    setState(() {
                                      hasError = false;
                                    });
                                  },
                                  onDone: (text) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Pin"),
                                            content: Text("Pin entered is $text"),
                                          );
                                        });
                                    var manager = RequestManager();

                                    var data = manager
                                        .verifyOtp(
                                        widget.mobilenumber,
                                        text,
                                        widget.purpose.toString())
                                        .then((value) {
                                      // print('response:$value');
                                      otpverifymodel = value;
                                      print('response:${otpverifymodel.msg}');
                                      if (otpverifymodel.msg == 'Otp Verify') {
                                        if (otpverifymodel.purpose == 'New_visit') {
                                          BaseMethod()
                                              .VMSToastMassage('${otpverifymodel.purpose}');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => VisitorForms(
                                                      purpose: otpverifymodel.purpose,
                                                      mobileNo:
                                                      widget.mobilenumber.toString())));
                                        } else if (otpverifymodel.purpose == 're_visit') {
                                          BaseMethod()
                                              .VMSToastMassage('${otpverifymodel.purpose}');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => VisitorForms(
                                                      purpose: otpverifymodel.purpose)));
                                        } else if (otpverifymodel.purpose ==
                                            'know_status') {
                                          BaseMethod()
                                              .VMSToastMassage('${otpverifymodel.purpose}');

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => KnowStatusList(
                                                      mobileNo: widget.mobilenumber)));
                                        } else {
                                          BaseMethod()
                                              .VMSToastMassage('${otpverifymodel.purpose}');
                                        }
                                      } else if (otpverifymodel.msg == 'Invalid Otp') {
                                        print('msg : ${otpverifymodel.msg}');
                                        BaseMethod()
                                            .VMSToastMassage('${otpverifymodel.msg}');
                                      }
                                    });
                                  },
                                  pinBoxWidth: width*0.13,
                                  pinBoxHeight: height*0.1,
                                  hasUnderline: false,
                                  wrapAlignment: WrapAlignment.spaceAround,
                                  pinBoxDecoration:
                                  ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                                  pinTextStyle: TextStyle(fontSize: 22.0),
                                  pinTextAnimatedSwitcherTransition:
                                  ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                                  pinTextAnimatedSwitcherDuration:
                                  Duration(milliseconds: 300),
//                    highlightAnimation: true,
                                  highlightAnimationBeginColor: Colors.black,
                                  highlightAnimationEndColor: Colors.white12,
                                  keyboardType: TextInputType.number,
                                ),
                                // PinEntryTextField(
                                //     fields: 6,
                                //
                                //     // fields: int.parse('$otpController'),
                                //     showFieldAsBox: true,
                                //     onSubmit: (String pin) {
                                //       showDialog(
                                //           context: context,
                                //           builder: (context) {
                                //             return AlertDialog(
                                //               title: Text("Pin"),
                                //               content: Text("Pin entered is $pin"),
                                //             );
                                //           });
                                //       var manager = RequestManager();
                                //
                                //       var data = manager
                                //           .verifyOtp(
                                //           widget.mobilenumber,
                                //           pin,
                                //           widget.purpose.toString())
                                //           .then((value) {
                                //         // print('response:$value');
                                //         otpverifymodel = value;
                                //         print('response:${otpverifymodel.msg}');
                                //         if (otpverifymodel.msg == 'Otp Verify') {
                                //           if (otpverifymodel.purpose == 'New_visit') {
                                //             BaseMethod()
                                //                 .VMSToastMassage('${otpverifymodel.purpose}');
                                //             Navigator.push(
                                //                 context,
                                //                 MaterialPageRoute(
                                //                     builder: (context) => VisitorForms(
                                //                         purpose: otpverifymodel.purpose,
                                //                         mobileNo:
                                //                         widget.mobilenumber.toString())));
                                //           } else if (otpverifymodel.purpose == 're_visit') {
                                //             BaseMethod()
                                //                 .VMSToastMassage('${otpverifymodel.purpose}');
                                //             Navigator.push(
                                //                 context,
                                //                 MaterialPageRoute(
                                //                     builder: (context) => VisitorForms(
                                //                         purpose: otpverifymodel.purpose)));
                                //           } else if (otpverifymodel.purpose ==
                                //               'know_status') {
                                //             BaseMethod()
                                //                 .VMSToastMassage('${otpverifymodel.purpose}');
                                //
                                //             Navigator.push(
                                //                 context,
                                //                 MaterialPageRoute(
                                //                     builder: (context) => KnowStatusList(
                                //                         mobileNo: widget.mobilenumber)));
                                //           } else {
                                //             BaseMethod()
                                //                 .VMSToastMassage('${otpverifymodel.purpose}');
                                //           }
                                //         } else if (otpverifymodel.msg == 'Invalid Otp') {
                                //           print('msg : ${otpverifymodel.msg}');
                                //           BaseMethod()
                                //               .VMSToastMassage('${otpverifymodel.msg}');
                                //         }
                                //       });
                                //     }),
                              ),
                            ),
                          ),
                          new TimerButton(
                            label: "Send OTP Again",
                            timeOutInSeconds: 30,
                            onPressed: () {
                              print("send otp");
                              setState(() {
                                loading = true;
                              });

                              var manager = RequestManager();
                              var data = manager
                                  .sendOtp(
                                  widget.mobilenumber.toString(),
                                  widget.purpose.toString())
                                  .then((value) {
                                print('response:$value');
                                sendOtpModel = value;
                                print('response:${sendOtpModel.msg}');
                                if (sendOtpModel.msg == 'Otp send successfully') {
                                  setState(() {
                                    loading = false;
                                  });

                                  BaseMethod().VMSToastMassage('${otpverifymodel.msg}');
                                }
                              });
                            },
                            disabledColor: Colors.red,
                            color: Colors.white,
                            disabledTextStyle: new TextStyle(fontSize: 20.0),
                            activeTextStyle:
                            new TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                          SizedBox(
                            width: 20,
                            height: 10,
                          ),
                          RaisedButton(
                            color: Colors.blue[900],
                            onPressed: () {
                              print('hlllo');
                              var manager = RequestManager();
                              setState(() {
                                loading = true;
                              });

                              var data = manager
                                  .verifyOtp(
                                  '',
                                  otpController.text.toString(),
                                  widget.purpose.toString())
                                  .then((value) {
                                print('response:$value');
                                otpverifymodel = value;
                                print('response:${otpverifymodel.msg}');
                                if (otpverifymodel.msg == 'Otp Verify') {
                                  setState(() {
                                    loading = false;
                                  });

                                  if (otpverifymodel.purpose == 'New_visit') {
                                    BaseMethod().VMSToastMassage('${otpverifymodel.purpose}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VisitorForms(
                                                purpose: otpverifymodel.purpose,
                                                mobileNo: widget.mobilenumber.toString())));
                                  } else if (otpverifymodel.purpose == 're_visit') {
                                    BaseMethod().VMSToastMassage('${otpverifymodel.purpose}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VisitorForms(
                                                purpose: otpverifymodel.purpose)));
                                  } else if (otpverifymodel.purpose == 'know_status') {
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => KnowStatusList(
                                    //             mobileNo: widget.mobilenumber)),
                                    //     (Route<dynamic> route) => false);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => KnowStatusList(
                                                mobileNo: widget.mobilenumber)));
                                    BaseMethod().VMSToastMassage('${otpverifymodel.purpose}');
                                  } else {
                                    BaseMethod().VMSToastMassage('${otpverifymodel.purpose}');
                                  }
                                } else if (otpverifymodel.msg == 'Invalid Otp') {
                                  setState(() {
                                    loading = false;
                                  });

                                  print('msg : ${otpverifymodel.msg}');
                                  BaseMethod().VMSToastMassage('${otpverifymodel.msg}');
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            textColor: Colors.white,
                            child: Text("Submit"),
                          ),
                    ]))),

          ])));
  }
}
