import 'package:facechk_app/ApiService/Loading.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Staff/emergency_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facechk_app/ApiService/BaseMethod.dart';

class EmergencyList extends StatefulWidget {
  const EmergencyList({Key key}) : super(key: key);

  @override
  _EmergencyListState createState() => _EmergencyListState();
}

class _EmergencyListState extends State<EmergencyList> {

  var height,width;
  bool loading = false;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    Provider.of<PreInvitationFormProvider>(context, listen: false)
        .emergencyListApi()
        .then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

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
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Emergency Contact List",
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
                            formProvider.clearEmergencyData();
                            emergencyFormForAdd();
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => PreInvitationForm()));
                          },
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Consumer<PreInvitationFormProvider>(
              builder: (context, value, child) {
                return loading? Loading() : value.emergencyData.isEmpty ? Center(
                  child: Text("No Emergency Contact Yet",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                ) : Container(
                  child: ListView.builder(
                    itemCount: value.emergencyData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          value.setEmergencyData(value.emergencyData[index].name,
                              value.emergencyData[index].mobile,value.emergencyData[index].email);
                            emergencyFormForEdit(value.emergencyData[index].id);


                        },
                        child: Container(
                          height: height*0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          margin: EdgeInsets.all(15),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                details("Name : ", value.emergencyData[index].name.capitalize()),
                                details("Mobile : ", value.emergencyData[index].mobile),
                                details("Email : ", value.emergencyData[index].email),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget details(String text,String text2){
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

  void refreshData() {
    setState(() {
      loading = true;
    });
    Provider.of<PreInvitationFormProvider>(context, listen: false)
        .emergencyListApi()
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

  void emergencyFormForAdd() {
    Route route = MaterialPageRoute(builder: (context) => EmergencyForm(isEdit: false,));
    Navigator.push(context, route).then(onGoBack);
  }

  void emergencyFormForEdit(var id) {
    Route route = MaterialPageRoute(builder: (context) => EmergencyForm(isEdit: true,id: id,));
    Navigator.push(context, route).then(onGoBack);
  }

}
