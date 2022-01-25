import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/Models/upcoming_visitor_model.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Staff/over_staying.dart';
import 'package:facechk_app/Screen/Staff/visitor_detail_staff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffDashboard extends StatefulWidget {

  @override
  _StaffDashboardState createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {

  var height, width;
  bool loading = false;
  String companyUrl;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    formProvider.upComingVisitorApi().then((value){
      setState(() {
        loading = false;
      });
    });
    getImage();
    super.initState();
  }
  getImage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      companyUrl = prefs.getString('baseUrl');
    });
  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    formProvider.upComingVisitorApi().then((value){
      setState(() {
        loading = false;
      });
    });
    getImage();
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return loading? Loading() : Consumer<PreInvitationFormProvider>(
      builder: (context, value, child) {
        return RefreshIndicator(
          onRefresh: getData,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      circle('Check In\nVisitors',value.upComingVisitor.allCheckinVisitor.toString()),
                      circle("Upcoming\nVisitors",value.upComingVisitor.upcomingVisitor.toString()),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OverStaying()));
                        },
                        child: circle('Overstaying\nVisitors',value.upComingVisitor.allOverstayingVisitor.toString())),
                      circle('Check Out\nVisitors',value.upComingVisitor.allCheckoutVisitor.toString()),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: width,
                  margin: EdgeInsets.all(10),
                  child: Text("Upcoming Visitors",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: value.upComingVisitor.appointments.isEmpty ? Center(
                  child: Text("No Visitors Yet",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                ) : Container(
                  child: ListView.builder(
                    itemCount: value.upComingVisitor.appointments.length,
                    itemBuilder: (context, index) {
                      var data = value.upComingVisitor.appointments[index];
                      // DateTime formattedDate = DateFormat('yyyy-MM-dd – kk:mm').parse(data.visiteTime);
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VisitorDetailStaff(userId: data.id.toString(),isVisitorList: false,isReport: false,)));
                        },
                        child: Container(
                          height: height*0.32,

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
                                  flex: 3,
                                  child: Container(
                                    // height: height*0.1,
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          radius: 40,
                                          backgroundImage: NetworkImage("https://vztor.in/$companyUrl/storage/app/public/${data.image}"),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data.name.capitalize(),
                                              style: TextStyle(
                                                  fontSize: 18,fontWeight: FontWeight.bold
                                              ),),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: data.getInOutStatus.inStatus == "No" ? Colors.red:Colors.greenAccent,
                                                      borderRadius: BorderRadius.circular(22)
                                                  ),
                                                  child: Center(
                                                    child: Text(data.getInOutStatus.inStatus == "No" ? "OUTSIDE" : "INSIDE",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white
                                                      ),),
                                                  ),
                                                ),
                                                SizedBox(width: 8,),
                                                Icon(Icons.logout,color: Colors.grey),
                                                SizedBox(width: 8,),
                                                // Text(formattedDate.toString(),
                                                //   style: TextStyle(
                                                //       fontSize: 15,
                                                //       color: Colors.grey
                                                //   ),),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Container(
                                    // height: height*0.134,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.message_outlined,color: Colors.grey),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text("Temp-${data.temprature ?? "NA"} . Mask-On",
                                                style: TextStyle(
                                                    fontSize: 15
                                                ),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.person,color: Colors.grey),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text(data.parentDetail == null ? "Allowed By --" : "Allowed By ${data.parentDetail.name}",
                                                style: TextStyle(
                                                    fontSize: 15
                                                ),),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.coronavirus_outlined,color: data.vaccine == "yes" ? Colors.green : Colors.red),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text(data.vaccine == "yes" ? "Vaccinated" : "Not Vaccinated",
                                                style: TextStyle(
                                                    fontSize: 15,color: data.vaccine == "yes" ? Colors.green : Colors.red
                                                ),),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                // Divider(),
                                Flexible(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Consumer<PreInvitationFormProvider>(
                                        builder: (context, value, child) {
                                          return GestureDetector(
                                            onTap: (){
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Confirm Alert"),
                                                      content: Text("Are you sure you want to send panic alert?"),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Text("YES"),
                                                          onPressed: () {
                                                            value.sendPanicAlertApi(data.id.toString()).then((val){
                                                              Navigator.of(context).pop();
                                                              BaseMethod().VMSToastMassage("Panic Alert send successfully");
                                                            });

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
                                            child: Container(
                                              width: width*0.3,
                                              height: height*0.06,
                                              color: Colors.white,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add_alert_rounded,color: Colors.black87,),
                                                  SizedBox(width: 5,),
                                                  Text("Panic Alert",
                                                    style: TextStyle(
                                                        fontSize: 13,color: Colors.black54
                                                    ),),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          value.blockVisitorApi(data.id.toString()).then((val){
                                            BaseMethod().VMSToastMassage(value.block.msg);
                                            setState(() {
                                              loading = true;
                                            });
                                            value.currentVisitorApi().then((value){
                                              setState(() {
                                                loading = false;
                                              });
                                            });
                                          });
                                        },
                                        child: Container(
                                          width: width*0.31,
                                          height: height*0.06,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.block,color: Colors.black87),
                                              SizedBox(width: 5,),
                                              Text("Block Visitor",
                                                style: TextStyle(
                                                    fontSize: 13,color: Colors.black54
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width*0.31,
                                        height: height*0.06,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("images/gatePass.png",scale: 7,),
                                            // Icon(Icons.account_balance,color: Colors.grey),
                                            SizedBox(width: 5,),
                                            Text("GatePass",
                                              style: TextStyle(
                                                  fontSize: 13,color: Colors.black54
                                              ),),
                                          ],
                                        ),
                                      ),
                                    ],
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
              )
            ],
          ),
        );
      },
    );
  }

  Widget circle(String text, count){
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0XFFB3E5FC)
            ),
            child: Center(child: Text(count,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal
            ),),),
          ),
          Text(text,textAlign: TextAlign.center,style: TextStyle(fontSize: 11),),
        ],
      ),
    );
  }

}
