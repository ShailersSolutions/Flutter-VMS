import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Guard/guard_main_dashboard.dart';
import 'package:facechk_app/Screen/Guard/guard_preinvitation.dart';
import 'package:facechk_app/Screen/Guard/guard_upcoming.dart';
import 'package:facechk_app/Screen/guardlogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuardMain extends StatefulWidget {
  const GuardMain({Key key}) : super(key: key);

  @override
  _GuardMainState createState() => _GuardMainState();
}

class _GuardMainState extends State<GuardMain> {

  @override
  Widget build(BuildContext context) {
    PreInvitationFormProvider formProvider = Provider.of(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  TextButton(
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
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
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,automaticallyImplyLeading: false,
            backgroundColor: Color(0XFF4FC3F7),
            title: Text("${formProvider.officeUrlModel.name}"),
            actions: [
              IconButton(
                onPressed: () async{
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GuardMainDashboard()));
                },
                icon: Icon(Icons.more_vert,color: Colors.white,),
              )
            ],
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 17),
              indicatorSize: TabBarIndicatorSize.label,

              indicatorWeight: 4,
              tabs: [
                Tab(text: "Upcoming Visitor"),
                Tab(text: "PreInvitation")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GuardUpcomingList(),
              GuardPreInvitation(),
            ],
          ),
        ),
      ),
    );
  }
}
