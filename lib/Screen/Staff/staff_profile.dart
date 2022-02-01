import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Staff/emergency_list.dart';
import 'package:facechk_app/Screen/guardlogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffProfile extends StatefulWidget {
  const StaffProfile({Key key}) : super(key: key);

  @override
  _StaffProfileState createState() => _StaffProfileState();
}

class _StaffProfileState extends State<StaffProfile> {

  var width;
  String companyUrl;

  @override
  void initState() {
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

    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    padding: EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Profile",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400,color: Colors.blue[900]),
                        ),
                        IconButton(
                          onPressed: ()async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.remove('staffId');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GaurdLogin(loginType: "Staff Login",)));
                          },
                          icon: Icon(Icons.logout)
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3, left: 10, right: 5),
                    padding: EdgeInsets.all(0),
                    child: Center(
                      child: formProvider.staffLoginModel.avatar != null ? CircleAvatar(
                        backgroundColor: Colors.blue[500],
                        radius: 70,
                        backgroundImage: NetworkImage("https://vztor.in/$companyUrl/storage/app/public/${formProvider.staffLoginModel.avatar}",),
                      ) :
                      Image.network(
                        "https://clipartart.com/images/facebook-profile-icon-clipart-7.png",
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        details(Icons.person, " : ${formProvider.staffLoginModel.name}"),
                        details(Icons.analytics_outlined, " : ${formProvider.staffLoginModel.roleName}"),
                        details(Icons.email, " : ${formProvider.staffLoginModel.email}"),
                        details(Icons.call, " : ${formProvider.staffLoginModel.mobile}"),
                        divider(),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10, right: 3),
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Office Address",
                            style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                          ),
                        ),
                        details_2('Location:',' ${formProvider.staffLoginModel.locationName}'),
                        details_2('Building:',' ${formProvider.staffLoginModel.buildingName}'),
                        details_2('Department:',' ${formProvider.staffLoginModel.departmentName}'),
                        divider(),
                        Container(
                          margin: EdgeInsets.all(20),
                          height: 60,
                          width: width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyList()));
                            },
                            child: Text("Emergency Contact",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ])),
      ),
    );
  }

  Widget details_2(String text1, String text2){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: RichText(
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: text1, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                TextSpan(text: text2,style: TextStyle(fontSize: 15,color: Colors.black) ),
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

}
