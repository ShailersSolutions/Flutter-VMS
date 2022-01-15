import 'package:date_time_picker/date_time_picker.dart';
import 'package:facechk_app/CommonMethod/common_form.dart';
import 'package:facechk_app/CommonMethod/dropDown_common.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class EmergencyForm extends StatefulWidget {
  bool isEdit = false;
  var id;
  EmergencyForm({this.isEdit,this.id});

  @override
  _EmergencyFormState createState() => _EmergencyFormState();
}

class _EmergencyFormState extends State<EmergencyForm> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

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
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(widget.isEdit ? "Edit Emergency Contact" :"Add Emergency Contact",
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 25,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextForm(
                      text: "Name",
                      controller: formProvider.emerName,
                      enable: true,
                    ),
                    CommonTextForm(
                      text: "Email",
                      controller: formProvider.emerEmail,
                      enable: true,
                    ),
                    CommonTextForm(
                      text: "Phone",
                      controller: formProvider.emerVerifyPhone,
                      enable: true,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10,30,10,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            child: loading ? Center(child: CircularProgressIndicator()) : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),),
                              onPressed: () {
                                if(widget.isEdit){
                                  setState(() {
                                    loading = true;
                                  });
                                  formProvider.editEmergencyContactApi(widget.id).then((val) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.of(context).pop();
                                  });
                                }else{
                                  print("adding");
                                  setState(() {
                                    loading = true;
                                  });
                                  formProvider.addEmergencyContactApi().then((value){
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.of(context).pop();
                                  });
                                }
                              },
                              child: Text(widget.isEdit ? "Edit" :"Create",style: TextStyle(color: Colors.white),),
                            ),
                          ),
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
