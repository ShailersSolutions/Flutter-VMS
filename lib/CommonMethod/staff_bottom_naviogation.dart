import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Screen/Staff/pre_invitation.dart';
import 'package:facechk_app/Screen/Staff/reports.dart';
import 'package:facechk_app/Screen/Staff/staff_dashboard.dart';
import 'package:facechk_app/Screen/Staff/staff_profile.dart';
import 'package:facechk_app/Screen/Staff/visitor_list.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class StaffBottomNavBar extends StatefulWidget {
  @override
  _StaffBottomNavBarState createState() => _StaffBottomNavBarState();
}

class _StaffBottomNavBarState extends State<StaffBottomNavBar> {
  int selectedIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  static  List _pages = [
    StaffDashboard(),
    VisitorList(),
    PreInvitation(),
    Reports(),
    StaffProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    PreInvitationFormProvider formProvider = Provider.of(context,listen: false);
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
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF4FC3F7),
          title: Text("${formProvider.officeUrlModel.name} (${formProvider.staffLoginModel.locationName})"),
        ),
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: selectedIndex,
            height: 60.0,
            items: <Widget>[
              Icon(Icons.home, size: 30,color: Colors.black,),
              Icon(Icons.align_horizontal_left, size: 30,color: Colors.black,),
              Icon(Icons.compare_arrows, size: 30,color: Colors.black,),
              Icon(Icons.list, size: 30,color: Colors.black,),
              Icon(Icons.person, size: 30,color: Colors.black,),
            ],
            color: Color(0XFFB3E5FC),
            buttonBackgroundColor: Color(0XFFB3E5FC),
            backgroundColor: Color(0XFFFFFFFF),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          body: _pages.elementAt(selectedIndex),
          // body: Container(
          //   color: Colors.blueAccent,
          //   child: Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         Text(selectedIndex.toString(), textScaleFactor: 10.0),
          //         ElevatedButton(
          //           child: Text('Go To Page of index 1'),
          //           onPressed: () {
          //             final CurvedNavigationBarState navBarState =
          //                 _bottomNavigationKey.currentState;
          //             navBarState?.setPage(1);
          //           },
          //         )
          //       ],
          //     ),
          //   ),
          // )
      ),
    );
  }
}