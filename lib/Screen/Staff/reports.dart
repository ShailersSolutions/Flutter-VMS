import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/CommonMethod/common_form.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Staff/visitor_detail_staff.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Reports extends StatefulWidget {
  const Reports({Key key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {

  var height,width;
  bool loading = false;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    formProvider.reportListApi().then((value){
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  Future<void> getData() async {
    setState(() {
      loading = true;
    });
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    formProvider.reportListApi().then((value){
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text("VISITOR REPORTS",
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 25,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),]
            ),
            // height: height*0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.date_range,color: Colors.grey,size: 17,),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    selectDateFrom(context);
                  },
                  child: Container(
                    width: width * 0.21,padding: EdgeInsets.only(bottom: 4),
                    child: TextFormField(
                      controller: formProvider.dateFrom,
                      enabled: false,style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 14),
                          hintText: "Date From"),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Icon(Icons.date_range,color: Colors.grey,size: 17,),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    selectDateTo(context);
                  },
                  child: Container(
                    width: width * 0.21,padding: EdgeInsets.only(bottom: 4),
                    child: TextFormField(
                      controller: formProvider.dateTo,
                      enabled: false,style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 14),
                          hintText: "Date To"),
                    ),
                  ),
                ),
                Container(
                    width: width*0.18,
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (){
                        if(formProvider.dateFrom.text.isEmpty || formProvider.dateTo.text.isEmpty){
                          BaseMethod().VMSToastMassage("Please select both date");
                        }else{
                          setState(() {
                            loading = true;
                          });

                          formProvider.reportListApi(dateFrom: formProvider.dateFrom.text, dateTo: formProvider.dateTo.text).then((value){
                            setState(() {
                              loading = false;
                            });
                            // formProvider.dateFrom.text = "";
                            // formProvider.dateTo.text = "";
                          });
                        }

                      },
                      child: Text("Search",style: TextStyle(
                          color: Colors.blue
                      ),),
                    )
                ),
                Container(
                    width: width*0.17,
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (){

                        formProvider.dateFrom.text = "";
                        formProvider.dateTo.text = "";
                          setState(() {
                            loading = true;
                          });

                          formProvider.reportListApi().then((value){
                            setState(() {
                              loading = false;
                            });

                          });

                      },
                      child: Text("Clear",style: TextStyle(
                          color: Colors.blue
                      ),),
                    )
                ),
              ],
            ),
          ),
        ),

        Consumer<PreInvitationFormProvider>(
          builder: (context, value, child) {
            return Expanded(
              flex: 8,
              child: RefreshIndicator(
                child: loading? Loading() : value.reportList.isEmpty ? Center(
                  child: Text("No Record Found",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                ) : Container(

                  child: ListView.builder(
                    itemCount: value.reportList.length,
                    itemBuilder: (context, index) {
                      print("report length ${value.reportList.length}");
                      var data = value.reportList[index].getVisitor;
                      var temp = value.reportList[index];
                      String inTime = DateFormat('kk:mm').format(temp.inTime);
                      String date = DateFormat('yyyy-MM-dd').format(temp.inTime);
                      String outTime = DateFormat('kk:mm').format(temp.outTime);
                      return data == null ? SizedBox() : GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => VisitorDetailStaff(isReport: true,userId: temp.userId.toString(),isVisitorList: false,)));
                        },
                        child: Container(
                          height: height*0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          margin: EdgeInsets.all(10),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              // height: height*0.134,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textWidget('Visitor Id : ',data.referCode),
                                      textWidget('Date : ',date),
                                      textWidget('In Time : ',inTime),
                                      textWidget('Out Time : ',outTime),
                                    ],
                                  ),
                                  Container(
                                    width: 2,height: height*0.28,
                                    color: Colors.black,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textWidget('Name : ',data.name),
                                      textWidget('Location : ',data.location.name),
                                      textWidget('Building : ',data.building.name),
                                      textWidget('Department : ',data.officerDepartment.name),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                onRefresh: getData,
              )
            );
          },
        ),
      ],
    );
  }

  Widget textWidget(String text1, String text2){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 8.0,),
        child: Container(
          width: width*0.39,
          child: RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: text1, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                  TextSpan(text: text2,style: TextStyle(color: Colors.black) ),
                ]
            ),
          ),
        ),
      ),
    );
  }

  Future selectDateFrom(BuildContext context) async {

    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    DateTime currentDate = DateTime.now();

    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));
    if (pickedDate != null && pickedDate != currentDate)

      currentDate = pickedDate;
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    setState(() {
      formProvider.dateFrom.text = formattedDate;
    });
    return formattedDate;
  }

  Future selectDateTo(BuildContext context) async {

    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    DateTime currentDate = DateTime.now();

    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));
    if (pickedDate != null && pickedDate != currentDate)
      currentDate = pickedDate;
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);

    setState(() {
      formProvider.dateTo.text = formattedDate;
    });
    return formattedDate;
  }

}
