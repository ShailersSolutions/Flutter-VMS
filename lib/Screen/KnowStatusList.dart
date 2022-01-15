import 'dart:convert';

import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/Constants/ApiConstants.dart';
import 'package:facechk_app/Constants/RoutePaths.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Guard/guard_vistor_details.dart';
import 'package:facechk_app/Screen/Visitor_detail.dart';
import 'package:facechk_app/Screen/login_screen.dart';
import 'package:facechk_app/Screen/visitor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class KnowStatusList extends StatefulWidget {
  String mobileNo;

  KnowStatusList({this.mobileNo = ''});

  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<KnowStatusList> {

  bool loading = false;
  var width, height;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    formProvider.knowStatusApi(widget.mobileNo).then((value){
      setState(() {
        loading = false;
      });
    });
  }

  Widget build(BuildContext context) {

    PreInvitationFormProvider formProvider = Provider.of(context,listen:false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: (){
        return Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF4FC3F7),
          title: Text("${formProvider.officeUrlModel.name}"),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Visitor Status Details",
                  style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 25,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: loading? Loading() : Consumer<PreInvitationFormProvider>(
                builder: (context, value, child) {
                  return RefreshIndicator(
                      child: value.knowStatusData.isEmpty ? Center(
                        child: Text("No Visitors Yet",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                      ) : Container(

                        child: ListView.builder(
                          itemCount: value.knowStatusData.length,
                          itemBuilder: (context, index) {
                            var data = value.knowStatusData[index];
                            String formattedDate;
                            print("length ${value.knowStatusData.length}");
                            // data.visiteTime == null ? "" : formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(data.visiteTime));

                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    GuardVisitorDetails(userId: data.visitId.toString(),isKnow: true,)));
                              },
                              child: Container(
                                height: height*0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                margin: EdgeInsets.all(10),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [

                                      Flexible(
                                        flex: 5,
                                        child: Container(
                                          // height: height*0.134,
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset('images/staff.png',scale: 22,),
                                                  Container(
                                                    width: width*0.4,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 8.0),
                                                      child: Text(data.name == null ? "--" : data.name.capitalize(),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 17,fontWeight: FontWeight.w500
                                                        ),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align (
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    " #   ${data.visitorId == null ? "--" : data.visitorId}",
                                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.call,color: Colors.grey),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 8.0),
                                                    child: Text(data.mobile == null ? "--" : data.mobile,
                                                      style: TextStyle(
                                                          fontSize: 15
                                                      ),),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.brightness_1,color: Colors.grey),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 8.0),
                                                    child: Text(data.status == null ? "--" : data.status == "Approve" ?
                                                    "Approve" : data.status == "PreInvited" ? "PreInvited" :
                                                    data.status == "Blocked" ? "Blocked" : "Pending",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: data.status == "Approve" ?
                                                          Colors.green : data.status == "PreInvited" ? Colors.blue :
                                                          data.status == "PreInvited" ? Colors.orange : Colors.red
                                                      ),),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      onRefresh: getData
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
