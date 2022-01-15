import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Staff/pre_invitation_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';

class PreInvitation extends StatefulWidget {
  const PreInvitation({Key key}) : super(key: key);

  @override
  _PreInvitationState createState() => _PreInvitationState();
}

class _PreInvitationState extends State<PreInvitation> {

  var height,width;
  bool loading = false;
  @override
  void initState() {
    setState(() {
      loading = true;
    });
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    formProvider.preInvitationApi().then((value){
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
    formProvider.preInvitationApi().then((value){
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pre Invitation List",
                  style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 25,
                      fontWeight: FontWeight.w400
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 45,
                    width: 33,

                    child: IconButton(
                      icon: Icon(Icons.add_circle,color: Colors.blue[400],),
                      iconSize: 30,
                      onPressed: () {
                        formProvider.clearPreInvitationData();
                        preInvitationForm();
                      },
                    )
                  ),
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
                child: loading? Loading() : value.preInvitationList.isEmpty ? Center(
                  child: Text("No Visitors Yet",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                ) : Container(

                  child: ListView.builder(
                    itemCount: value.preInvitationList.length,
                    itemBuilder: (context, index) {
                      var data = value.preInvitationList[index];
                      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(data.preVisitDateTime));
                      return GestureDetector(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => VisitorDetailStaff()));
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
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text(data.name == null ? "--" : data.name.capitalize(),
                                                style: TextStyle(
                                                    fontSize: 17,fontWeight: FontWeight.w500
                                                ),),
                                            ),
                                          ],
                                        ),
                                        Align (
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              " #   ${data.referCode == null ? "--" : data.referCode}",
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
                                            Icon(Icons.calendar_today,color: Colors.grey),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Text(formattedDate,
                                                style: TextStyle(
                                                    fontSize: 15
                                                ),),
                                            ),
                                          ],
                                        )
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
                onRefresh: getData,
              )
            );
          },
        ),
      ],
    );
  }

  void refreshData() {
    setState(() {
      loading = true;
    });
    Provider.of<PreInvitationFormProvider>(context, listen: false)
        .preInvitationApi()
        .then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  void preInvitationForm() {
    Route route = MaterialPageRoute(builder: (context) => PreInvitationForm());
    Navigator.push(context, route).then(onGoBack);
  }

}
