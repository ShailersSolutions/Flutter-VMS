import 'dart:convert';
import 'dart:io';

import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/RequestManager/RequestManager.dart';
import 'package:facechk_app/Screen/Guard/guard_main_dashboard.dart';
import 'package:facechk_app/Screen/Guard/guard_vistor_details.dart';
import 'package:facechk_app/Screen/guardlogin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyPreInvite extends StatefulWidget {
  var id;
  VerifyPreInvite({this.id});

  @override
  _VerifyPreInviteState createState() => _VerifyPreInviteState();
}

class _VerifyPreInviteState extends State<VerifyPreInvite> {

  var height, width;
  XFile _image;
  final picker = ImagePicker();
  bool loading = false,subLoading = false;
  String clientImg;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    Provider.of<PreInvitationFormProvider>(context, listen: false)
        .preDataVerifyApi(widget.id)
        .then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFF4FC3F7),
        title: Text("${formProvider.officeUrlModel.name}"),
        actions: [
          IconButton(
            onPressed: ()async{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GuardMainDashboard()));
            },
            icon: Icon(Icons.more_vert,color: Colors.white,),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: width,
              margin: EdgeInsets.all(10),
              child: Text("Verify Pre-Invite Visitor",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: loading ? Loading() : Consumer<PreInvitationFormProvider>(
              builder: (context, value, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      textWidget('Visitor Name:  ', value.dataVerify.data.name.capitalize()),
                      textWidget('Visitor Id:  ', value.dataVerify.data.referCode),
                      textWidget('Authentication Pin:  ', value.dataVerify.data.preInvitePin.toString()),
                      RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: "Show Image in camera", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[600],fontSize: 18),),
                              TextSpan(text: "*",style: TextStyle(color: Colors.red,fontSize: 18) ),
                            ]
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          imgFromCamera();
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: height*0.24,
                          width: width*0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              border: Border.all(color: Colors.black,width: 2),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: _image == null ? Text("Tap Here to \nCapture Image",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18
                              ),
                            ) : Image.file(File(_image.path),fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                      subLoading? CircularProgressIndicator() : Container(
                        margin: EdgeInsets.all(20),
                        height: 50,
                        width: width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),),
                          onPressed: () async{
                            if(_image == null){
                              BaseMethod().VMSToastMassage("Please capture image");
                            }else{
                              setState(() {
                                subLoading = true;
                              });
                              await RequestManager().preVisitVerify(widget.id, clientImg).then((value) {
                                setState(() {
                                  subLoading = false;
                                });
                                if(value['status'] == 'success'){
                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (context) => GuardVisitorDetails(userId: value['user_id'].toString(),isKnow: false,)));
                                }
                              });
                            }
                          },
                          child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18),),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          )
        ],
      ),
    );
  }

  imgFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(()  {
        _image = pickedFile;
      });
        List<int> imageBytes = await _image.readAsBytes();
        clientImg = base64.encode(imageBytes);

    } else {
      print('No image selected.');
    }
  }

  Widget textWidget(String text1, String text2){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 8.0,right: 8,bottom:15),
        child: Container(
          width: width,
          child: RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: text1, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                  TextSpan(text: text2,style: TextStyle(color: Colors.black,fontSize: 18) ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
