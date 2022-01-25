import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Staff/visitor_detail_staff.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ClassType {Pending, Approved, PreInvited ,Blocked}

String classId(ClassType classType){
  switch(classType){
    case ClassType.Pending:
      return "0";
    case ClassType.Approved:
      return "1";
    case ClassType.PreInvited:
      return "2";
    case ClassType.Blocked:
      return "3";
  }
}

String className(ClassType classSelected){
  switch(classSelected){
    case ClassType.Pending:
      return "Pending";
    case ClassType.Approved:
      return "Approved";
    case ClassType.PreInvited:
      return "PreInvited";
    case ClassType.Blocked:
      return "Blocked";
  }
}

class VisitorList extends StatefulWidget {
  const VisitorList({Key key}) : super(key: key);

  @override
  _VisitorListState createState() => _VisitorListState();
}

class _VisitorListState extends State<VisitorList> {

  var width, height;
  var classType;
  bool loading = false;
  String filter = "Filter";
  String companyUrl;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    formProvider.currentVisitorApi().then((value){
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
    formProvider.currentVisitorApi().then((value){
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

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text("Current Visitors",
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
                child: value.currentVisitor.isEmpty ? Center(
                  child: Text("No Visitors Yet",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                ) : Container(

                  child: ListView.builder(
                    itemCount: value.currentVisitor.length,
                    itemBuilder: (context, index) {
                      var data = value.currentVisitor[index];
                      String formattedDate;
                      print("length ${value.currentVisitor.length}");
                      data.visiteTime == null ? "" : formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(data.visiteTime));

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VisitorDetailStaff(userId: data.id.toString(),isReport: false,isVisitorList: true,)));
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
                                          backgroundColor: Colors.red,
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
                                                // Container(
                                                //   height: 25,
                                                //   width: 80,
                                                //   decoration: BoxDecoration(
                                                //       color: Colors.greenAccent,
                                                //       borderRadius: BorderRadius.circular(22)
                                                //   ),
                                                //   child: Center(
                                                //     child: Text("INSIDE",
                                                //       style: TextStyle(
                                                //           fontSize: 15,
                                                //           color: Colors.white
                                                //       ),),
                                                //   ),
                                                // ),
                                                // SizedBox(width: 8,),
                                                Icon(Icons.logout,color: Colors.grey),
                                                SizedBox(width: 8,),
                                                Text(formattedDate == null ? "" : formattedDate,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey
                                                  ),),
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
                                              child: Text("Temp - ${data.temprature ?? "NA"}",
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
                                              child: Text("Allowed By ${data.officerDetail.name.capitalize()}",
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
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                                width: width*0.28,
                                                height: height*0.06,
                                                color: Colors.white,
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.add_alert_rounded,color: Colors.black87,size: 18,),
                                                    SizedBox(width: 5,),
                                                    Text("Panic Alert",
                                                      style: TextStyle(
                                                          fontSize: 14,color: Colors.black54
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
                                            width: width*0.30,
                                            height: height*0.06,color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.block,color: Colors.black87,size: 18,),
                                                SizedBox(width: 5,),
                                                Text("Block Visitor",
                                                  style: TextStyle(
                                                      fontSize: 14,color: Colors.black54
                                                  ),),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width*0.29,
                                          height: height*0.06,color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset("images/gatePass.png",scale: 8,),
                                              // Icon(Icons.account_balance,color: Colors.grey),
                                              SizedBox(width: 5,),
                                              Text("GatePass",
                                                style: TextStyle(
                                                    fontSize: 14,color: Colors.black54
                                                ),),
                                            ],
                                          ),
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
        )

      ],
    );
  }
}
