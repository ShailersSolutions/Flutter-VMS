import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/CommonMethod/common_form.dart';
import 'package:facechk_app/CommonMethod/dropDown_common.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:io' as Io;

class PreInvitationForm extends StatefulWidget {
  const PreInvitationForm({Key key}) : super(key: key);

  @override
  _PreInvitationFormState createState() => _PreInvitationFormState();
}

class _PreInvitationFormState extends State<PreInvitationForm> {

  bool loading = false;
  PickedFile _picker;
  String image ;

  @override
  void initState() {
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);
    formProvider.locationApi();

    super.initState();
  }

  String fileNameProfile;
  String valueChanged1 = DateTime.now().toString();
  String valueSaved1 = '';

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFF4FC3F7),
        title: Text("${formProvider.officeUrlModel.name} (${formProvider.staffLoginModel.locationName})"),
      ),
      body: Column(
        children: [

          Expanded(
            flex: 10,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Send Pre Invitation",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 25,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    Container(
                        height: 120,width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(70),
                            border: Border.all(color: Colors.black)
                        ),
                        child: image == null ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          backgroundImage: NetworkImage("https://clipartart.com/images/facebook-profile-icon-clipart-7.png",),
                        )
                            : CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          backgroundImage: FileImage(File(image)),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: ()async{
                          PickedFile images = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          if (images != null) {
                            setState(() {
                              image = images.path ;
                            });
                          }
                        },
                        child: Text("Click here to upload Image",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                        ),),
                      ),
                    ),
                    CommonTextForm(
                      text: "Visitor Phone",
                      controller: formProvider.verifyPhone,
                      enable: true,
                    ),
                    CommonTextForm(
                      text: "Visitor Email",
                      controller: formProvider.email,
                      enable: true,
                    ),
                    CommonTextForm(
                      text: "Visitor Name",
                      controller: formProvider.name,
                      enable: true,
                    ),

                    Consumer<PreInvitationFormProvider>(
                      builder: (context, value, child) {
                        return Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10,20,10,0),
                              child: Container(
                                  padding: EdgeInsets.only(
                                    left: 7,
                                    right: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        dropdownColor: Colors.white,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 36,
                                        isExpanded: true,
                                        value: value.locationId,
                                        hint: Text('Select Your Location'),
                                        items: value.locationList.map((e) {
                                          return DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(
                                              e.name.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: ( val) {
                                          setState(() {
                                            value.locationId = val;
                                            value.buildingId = null;
                                            value.departmentId = null;
                                            value.buildingApi(value.locationId).then((val){
                                              print("building list");
                                            //  print(val);
                                              print(value.buildingList);
                                            });
                                          });
                                        }),
                                  )
                              )
                          ),
                        );
                      },
                    ),
                    Consumer<PreInvitationFormProvider>(
                      builder: (context, value, child) {
                        return Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10,20,10,0),
                              child: Container(
                                  padding: EdgeInsets.only(
                                    left: 7,
                                    right: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        dropdownColor: Colors.white,
                                        icon: Icon(Icons.arrow_drop_down,color: value.buildingList.isEmpty ? Colors.white: Colors.black,),
                                        iconSize: 36,
                                        isExpanded: true,
                                        value: value.buildingId,
                                        hint: Text(value.buildingList.isEmpty ? "No building added" :'Select Your Building'),
                                        items: value.buildingList.map((e) {
                                          return DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(
                                              e.name.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: ( val) {
                                          setState(() {
                                            value.buildingId = val;
                                            print(value.buildingId);
                                            value.departmentId = null;
                                            value.departmentApi(value.buildingId);
                                          });
                                        }),
                                   )
                              )
                          ),
                        );
                      },
                    ),
                    Consumer<PreInvitationFormProvider>(
                      builder: (context, value, child) {
                        return Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10,20,10,0),
                              child: Container(
                                  padding: EdgeInsets.only(
                                    left: 7,
                                    right: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child:DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        dropdownColor: Colors.white,
                                        icon: Icon(Icons.arrow_drop_down,color: value.departmentList.isEmpty ? Colors.white: Colors.black,),
                                        iconSize: 36,
                                        isExpanded: true,
                                        value: value.departmentId,
                                        hint: Text(value.departmentList.isEmpty ? "No department added" :'Select Your Department'),
                                        items: value.departmentList.map((e) {
                                          return DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(
                                              e.name.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: ( val) {
                                          setState(() {
                                            value.departmentId = val;
                                            value.officerId = null;
                                            value.officerApi(value.departmentId);
                                          });
                                        }),
                                  )
                              )
                          ),
                        );
                      },
                    ),
                    Consumer<PreInvitationFormProvider>(
                      builder: (context, value, child) {
                        return Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10,20,10,0),
                              child: Container(
                                  padding: EdgeInsets.only(
                                    left: 7,
                                    right: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child:DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        dropdownColor: Colors.white,
                                        icon: Icon(Icons.arrow_drop_down,color: value.officerList.isEmpty ? Colors.white: Colors.black,),
                                        iconSize: 36,
                                        isExpanded: true,
                                        value: value.officerId,
                                        hint: Text(value.officerList.isEmpty ? "No Officer added" :'Select Your Officer'),
                                        items: value.officerList.map((e) {
                                          return DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(
                                              e.name.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: ( val) {
                                          setState(() {
                                            value.officerId = val;
                                          });
                                        }),
                                  )
                              )
                          ),
                        );
                      },
                    ),
                    Container(
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
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",

                        onChanged: (val) {
                          setState(() {
                            formProvider.dateTime = val;
                            print(formProvider.dateTime);
                          });
                        },

                     //   onSaved: (val) => setState(() => valueSaved1 = val),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10,30,10,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Back",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          loading ? Center(child: CircularProgressIndicator(),) : SizedBox(
                            height: 60,
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),),
                              onPressed: () {
                                if(image == null){
                                  BaseMethod().VMSToastMassage("Select Image");
                                }else if(formProvider.verifyPhone.text == ""){
                                  BaseMethod().VMSToastMassage("Please enter the mobile number");
                                }else if(formProvider.email.text == ""){
                                  BaseMethod().VMSToastMassage("Please enter the email");
                                }else if(formProvider.name.text == ""){
                                  BaseMethod().VMSToastMassage("Please enter the name");
                                }else if(formProvider.locationId == null){
                                  BaseMethod().VMSToastMassage("Select location");
                                }else if(formProvider.dateTime == ""){
                                  BaseMethod().VMSToastMassage("Please select pre visit date time");
                                }else if(formProvider.officerId == null){
                                  BaseMethod().VMSToastMassage("Select Officer");
                                }else{
                                  setState(() {
                                    loading = true;
                                  });
                                  formProvider.addPreInvitationApi(image).then((value){
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.of(context).pop();
                                    BaseMethod().VMSToastMassage("Pre Invitation sent successfully");
                                  });
                                }
                              },
                              child: Text("Send",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



}
