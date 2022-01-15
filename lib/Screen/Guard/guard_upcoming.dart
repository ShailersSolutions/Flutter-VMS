import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:facechk_app/Screen/Guard/guard_vistor_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuardUpcomingList extends StatefulWidget {
  const GuardUpcomingList({Key key}) : super(key: key);

  @override
  _GuardUpcomingListState createState() => _GuardUpcomingListState();
}

class _GuardUpcomingListState extends State<GuardUpcomingList> {

  var height, width;

  String companyUrl,guardEmail,guardPassword;

  @override
  void initState() {
      getImage();
    super.initState();
  }

  getImage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      companyUrl = prefs.getString('baseUrl');
      guardEmail = prefs.getString('guardEmail');
      guardPassword = prefs.getString('guardPassword');
    });
  }

  Future<void> getData() async{
    getImage();
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
    await RequestManager().guardLogin(guardEmail, guardPassword, formProvider.officeUrlModel.id).then((value) {
      if(value.guardLoginModelClass == "error"){
        BaseMethod().VMSToastMassage("You have entered invalid credentials");
      }else if(value.guardLoginModelClass == "success"){
        context.read<PreInvitationFormProvider>().setGuardLoginDetails(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(10),
      child: Consumer<PreInvitationFormProvider>(
         builder: (context, value, child) {
           return RefreshIndicator(
             child: value.guardLoginModel.data.isEmpty ? Center(child: Text("No Visitor Yet"),)
                 : ListView.builder(
               itemCount: value.guardLoginModel.data.length,
               itemBuilder: (context, index) {
                 var data = value.guardLoginModel.data[index];
                 String formattedDate;
                 if(data.visiteTime != null){
                   formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(data.visiteTime));
                 }

                 return GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => GuardVisitorDetails(
                       userId: data.id.toString(),isKnow: false,)));
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
                               child: Row(
                                 children: [
                                   Flexible(
                                     flex: 6,
                                     child: Container(
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
                                               Icon(Icons.brightness_1,color: Colors.grey),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 8.0),
                                                 child: Text(data.status == null ? "--" : data.status == 1 ?
                                                 "Approve" : data.status == 2 ? "PreInvited" :
                                                 data.status == 3 ? "Blocked" : "Pending",
                                                   style: TextStyle(
                                                       fontSize: 15,
                                                       color: data.status == 1 ?
                                                       Colors.green : data.status == 2 ? Colors.blue :
                                                       data.status == 3 ? Colors.orange : Colors.red
                                                   ),),
                                               ),
                                             ],
                                           ),
                                           Row(
                                             children: [
                                               Icon(Icons.calendar_today,color: Colors.grey),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 8.0),
                                                 child: Text(data.visiteTime == null ? "--" : formattedDate,
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
                                   Flexible(
                                     flex: 4,
                                     child: Image.network(
                                         data.image == null ? 'https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg' :
                                         'https://vztor.in/$companyUrl/storage/app/public/${data.image}'),
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
             onRefresh: getData
           );
         },
      ),
    );
  }
}
