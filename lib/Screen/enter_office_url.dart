import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:facechk_app/Screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterOfficeUrl extends StatefulWidget {

  @override
  _EnterOfficeUrlState createState() => _EnterOfficeUrlState();
}

class _EnterOfficeUrlState extends State<EnterOfficeUrl> {

  var height, width;
  TextEditingController officeUrl = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: (){
        return SystemNavigator.pop();
      },
      child: Scaffold(

          body: SingleChildScrollView(
              child: Container(
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Text(
                            "VZTOR",
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 70,
                            ),
                          ),
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
                        SizedBox(
                          height: 80,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left:20),
                            child: Text(
                              "Enter Company Name",
                              style: TextStyle(
                                  fontSize: 21,
                                  //fontStyle: FontStyle.italic,
                                  color: Colors.blue[900]),
                            ),
                          ),
                        ),
                        // SizedBox(height: 10,),
                        Container(
                          height: height*0.07,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white
                          ),
                          child: TextFormField(
                            controller: officeUrl,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.add_link,color: Colors.black87,),
                                hintText: "Your company",
                            ),
                          ),
                        ),
                        loading ? Center(
                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                        ) : RaisedButton(
                          color: Colors.blue[900],
                          onPressed: () async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            setState(() {
                              loading = true;
                            });
                            if(officeUrl.text.isEmpty){
                              setState(() {
                                loading = false;
                              });
                              BaseMethod().VMSToastMassage("Url must be entered!");
                            }
                            else{

                              formProvider.companyUrl(officeUrl.text.toLowerCase()).then((value){
                                setState(() {
                                  loading = false;
                                });
                                print("qwertp ${formProvider.officeUrlModel}");
                                if(formProvider.officeUrlModel.data != null){
                                  prefs.setString("companyId", formProvider.officeUrlModel.id);
                                  prefs.setString('baseUrl', officeUrl.text.toString());
                                  print("qwert  ${formProvider.officeUrlModel.data}");
                                  formProvider.setOfficeUrlDetails(formProvider.officeUrlModel);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      LoginScreen()));

                                }else if(formProvider.officeUrlModel == null){
                                  print("in");
                                  BaseMethod().VMSToastMassage("Company not registered. Please check the url entered");
                                }
                              });

                              // await RequestManager().officeUrl(officeUrl.text).then((value){
                              //
                              //   print("company status === ${value.status}");
                              //
                              //   if(value.status == "success"){
                              //     setState(() {
                              //       loading = false;
                              //     });
                              //     context.read<PreInvitationFormProvider>().setOfficeUrlDetails(value);
                              //     Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              //         LoginScreen()));
                              //
                              //   }else if(value.status == "failed"){
                              //     setState(() {
                              //       loading = false;
                              //     });
                              //     BaseMethod().VMSToastMassage("Company not registered. Please check the url entered");
                              //   }
                              // });
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          textColor: Colors.white,
                          child: Text("Submit"),
                        ),
                        SizedBox(
                          height: 200,
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
                      ])))),
    );
  }
}
