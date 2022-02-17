
import 'package:date_time_picker/date_time_picker.dart';
import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/CommonMethod/image_preview.dart';
import 'package:facechk_app/Constants/enum.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitorDetailStaff extends StatefulWidget {

  bool isReport = false, isVisitorList = false;
  String userId;
  VisitorDetailStaff({this.isReport,this.userId,this.isVisitorList});

  @override
  _VisitorDetailStaffState createState() => _VisitorDetailStaffState();
}

class _VisitorDetailStaffState extends State<VisitorDetailStaff> {


  bool loading = false, aLoading = false, rLoading = false, reLoading = false;
  String companyUrl, status = "Action";
  var statusType;
  String dateTime = DateTime.now().toString();

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    print("visitor id ${widget.userId}");
    Provider.of<PreInvitationFormProvider>(context, listen: false)
        .visitorDetailByIdApi(widget.userId)
    .then((value) {
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

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);

    return Consumer<PreInvitationFormProvider>(
      builder: (context, value, child) {
        var data = value.visitorDetailByIdModel;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0XFF4FC3F7),automaticallyImplyLeading: false,
            title: Text("${formProvider.officeUrlModel.name} (${formProvider.staffLoginModel.locationName})"),
            actions: [
              widget.isVisitorList || widget.isReport ? SizedBox() : data.status == 0 ? aLoading ? SizedBox()
                  : Container(
                width: 120,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Status>(
                      dropdownColor: Color(0XFF4FC3F7),
                      icon: Icon(Icons.more_vert,color: Colors.white,),
                      hint: Text(status,style: TextStyle(color: Colors.white),),
                      style: TextStyle(
                        color: Colors.white
                      ),
                      iconSize: 30,
                      isExpanded: true,
                      value: statusType,
                      items: Status.values.map((Status status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(
                            statusName(status),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (Status val) {
                        setState(()  {
                          statusType = val ;
                          if(statusId(val) == 1){
                            print("approve");
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Container(

                                      child: AlertDialog(
                                        title: Text("Are you sure want to approve?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Submit"),
                                            onPressed: () async{
                                              RequestManager().approve(data.officerId.toString(), data.id.toString()).then((approve) {
                                                setState(() {
                                                  if(approve['status'] == "success"){
                                                    aLoading = true;
                                                    Navigator.of(context).pop();
                                                    BaseMethod().VMSToastMassage("Request Approved");
                                                  }
                                                });
                                              });
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );

                          }else if(statusId(val) == 2){
                            print("reject");
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Container(

                                      child: AlertDialog(
                                        title: Text("Are you sure want to reject?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Submit"),
                                            onPressed: () async{
                                              RequestManager().reject(data.officerId.toString(), data.id.toString()).then((reject) {
                                                setState(() {
                                                  if(reject['status'] == "success"){
                                                    aLoading = true;
                                                    Navigator.of(context).pop();
                                                    BaseMethod().VMSToastMassage("Request Rejected");
                                                  }
                                                });
                                              });
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );

                          }else if(statusId(val) == 3){
                            print("reschedule");
                            showDialog(
                              context: context,

                              builder: (context) {

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Container(

                                      child: AlertDialog(
                                        title: Text("Enter date"),
                                        content: Container(
                                          height: 70,
                                          margin: const EdgeInsets.only(left: 10, right: 10,top: 20),
                                          padding: const EdgeInsets.all(5),
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                          child: DateTimePicker(
                                            type: DateTimePickerType.dateTimeSeparate,
                                            dateMask: 'yyyy-MMM-d',
                                            initialValue: '',
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                            dateHintText: 'Date',
                                            timeHintText: "Hour",

                                            onChanged: (val) {
                                              setState(() {
                                                dateTime = val;
                                                print(dateTime);
                                              });
                                            },
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Submit"),
                                            onPressed: () async{
                                              if(dateTime.isEmpty){
                                                BaseMethod().VMSToastMassage("Enter Date");
                                              }else{
                                                RequestManager().reSchedule(data.officerId.toString(), data.id.toString(), dateTime).then((reject) {
                                                  setState(() {
                                                    if(reject['status'] == "success"){
                                                      aLoading = true;
                                                      Navigator.pop(context);
                                                      BaseMethod().VMSToastMassage("Visitor ReScheduled Successfully");
                                                      // setState(() {
                                                      //   loading = true;
                                                      // });
                                                      // Provider.of<PreInvitationFormProvider>(context, listen: false)
                                                      //     .visitorDetailByIdApi(widget.userId)
                                                      //     .then((value) {
                                                      //   setState(() {
                                                      //     loading = false;
                                                      //   });
                                                      // });
                                                      // getImage();
                                                    }
                                                  });
                                                });
                                              }
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        });
                      }),
                ),
              ) : SizedBox()
            ],
          ),
          body: loading ? Center(child: Loading()) :
          SingleChildScrollView(
              child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Visitor Details ",
                            style: TextStyle(fontSize: 20, color: Colors.blue[900],fontWeight: FontWeight.w500),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    widget.isReport == true ? SizedBox() : Container(
                      child: RichText(
                        text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: "Appointment Slip & Status: ", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 19),),
                              TextSpan(text: data.status == 1 || data.status == 2 ? "Approve" : "Pending",style: TextStyle(
                                  color: data.status == 1|| data.status == 2 ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,fontSize: 19) ),
                            ]
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3, left: 10, right: 5),
                      padding: EdgeInsets.all(0),
                      child: Center(
                        child: data.image == null
                            ? Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKcZqTSRXvx6x_kG8JG9YmMmHsK3bCv1zyTA&usqp=CAU",
                          height: 150,
                          width: 150,
                        )
                            : CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 60,
                          backgroundImage: NetworkImage("https://vztor.in/$companyUrl/storage/app/public/${data.image}"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    divider(),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          details(Icons.person, " : ${data.name.capitalize()}"),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                " #    : ${data.referCode == null ? "NA" : data.referCode}",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ),
                          details(Icons.analytics_outlined, " : ${data.services == null ? "NA" : data.services}"),
                          details(Icons.email, " : ${data.email == null ? "NA" : data.email}"),
                          details(Icons.call, " : ${data.mobile == null ? "NA" : data.mobile}"),
                          details(Icons.wc_outlined, " : ${data.gender == null ? "NA" : data.gender}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              details(Icons.account_balance_wallet,
                                  " : ${data.documentType == null ? "NA" : data.documentType == "dl" ? "Driving Licence" :
                                  data.documentType == "adhar_card" ? "Aadhar Card" :
                                  data.documentType == "govt_id_pf" ? "Govt Identity Proof" :
                                  data.documentType == "Pancard" ? "Pan Card" : ""}"),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => ImagePreview(
                                            imageUrl: data.attachmant != null ? "https://vztor.in/$companyUrl/storage/app/public/${data.attachmant}" :
                                            "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg",
                                          )));
                                    },
                                    child: Icon(Icons.visibility)),
                              ),
                            ],
                          ),
                          divider(),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10, right: 3),
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Visitor Address ",
                              style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                            ),
                          ),
                          details_2('Organisation Name : ', '${data.organizationName == null ? "NA" : data.organizationName}'),
                          details_2('City : ', '${data.city == null ? "NA" : data.city.name}'),
                          details_2('State : ', '${data.state == null ? "NA" : data.state.name}'),
                          details_2('Country : ', '${data.country == null ? "NA" : data.country.name}'),
                          divider(),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10, right: 3),
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Appointment With",
                              style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                            ),
                          ),
                          details(Icons.person, " : ${data.officerDetail == null ? "NA" : data.officerDetail.name}"),
                          details(Icons.analytics_outlined, " : ${data.officerDepartment == null ? "NA" : data.officerDepartment.name}"),
                          details(Icons.email, " : ${data.officerDetail == null ? "NA" : data.officerDetail.email}"),
                          details(Icons.call, " : ${data.officerDetail == null ? "NA" : data.officerDetail.mobile}"),
                          divider(),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10, right: 3),
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Visiting Office Address",
                              style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                            ),
                          ),
                          details_2('Location : ','${data.location == null ? "NA" : data.location.name}'),
                          details_2('Building : ','${data.building == null ? "NA" : data.building.name}'),
                          details_2('City : ','${data.orgaCity == null ? "NA" : data.orgaCity.name}'),
                          details_2('State : ','${data.orgaState == null ? "NA" : data.orgaState.name}'),
                          details_2('Country : ','${data.orgaCountry == null ? "NA" : data.orgaCountry.name}'),
                          details_2('Pincode : ','${data.orgaPincode == null ? "NA" : data.orgaPincode}'),
                          divider(),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 10, right: 3),
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Covid Declaration :",
                              style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                            ),
                          ),
                          details_2('Vaccinated : ','${data.vaccine == null ? "NA" : data.vaccine.capitalize()}'),
                          details_2('Dose : ','${data.vaccineCount == null ? "NA" : data.vaccineCount}'),
                          details_2('Vaccine Name : ','${data.vaccineName == null ? "NA" : data.vaccineCount}'),
                          details_2('Current Temperature : ','${data.temprature == null ? "NA" : data.temprature}'),
                          details_2('Travelled in past 14 days out side India : ','${data.travelledStates == null ? "NA" : data.travelledStates.capitalize()}'),
                          details_2('Got in touch of any Covid +ve patient : ','${data.patient == null ? "NA" : data.patient.capitalize()}'),
                          details_2('Any health issue : ', '${data.symptoms == null ? "NA" : data.symptoms.capitalize()}'),

                        ],
                      ),
                    ),
                    divider(),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 3),
                      padding: EdgeInsets.all(0),
                      child: Text(
                        "QR Code ",
                        style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    value.qrCode.qrCode == null ? SizedBox() : QrImage(
                      data: value.qrCode.qrCode,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]))
        );
      },
    );
  }

  Widget details(IconData icon, String text){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Icon(icon),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget details_2(String text,String text2){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: RichText(
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16),),
                TextSpan(text: text2,style: TextStyle(color: Colors.black,fontSize: 16) ),
              ]
          ),
        ),
      ),
    );
  }

  Widget divider(){
    return Container(
      margin: EdgeInsets.only(top: 3, left: 20, right: 20),
      child: Divider(
        height: 10.0,
        indent: 5.0,
        thickness: 1,
        color: Colors.black87,
      ),
    );
  }
}
