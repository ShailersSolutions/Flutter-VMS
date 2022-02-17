import 'dart:async';

import 'package:facechk_app/ApiService/BaseMethod.dart';
import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
import 'package:facechk_app/Provider/visitor_form_provider.dart';
import 'package:facechk_app/Screen/guardlist.dart';
import 'package:facechk_app/Screen/login_screen.dart';
import 'package:facechk_app/Screen/splash_screen.dart';
import 'package:facechk_app/Screen/visitor_forms.dart';
import 'package:facechk_app/Screen/visitor_page2.dart';
import 'package:facechk_app/Screen/visitor_page5.dart';
import 'package:facechk_app/Screen/visitor_page6.dart';
import 'package:facechk_app/Screen/Staff/staff_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'Screen/visitor_page4.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreInvitationFormProvider()),
        ChangeNotifierProvider(create: (_) => VisitorFormProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {

  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  ConnectivityResult connectivityResult = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> streamSubscription;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try{
      result = await connectivity.checkConnectivity();
    }on PlatformException catch(e){
      print(e.toString());
      return;
    }
    if(!mounted){
      return Future.value(null);
    }
    return updateConnectionState(result);
  }

  Future<void> updateConnectionState(ConnectivityResult result) async{
    setState(() {
      connectivityResult = result;
    });
    if(connectivityResult.name == "none"){
      return showAlertDialog(context);
    }
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();
    streamSubscription = connectivity.onConnectivityChanged.listen(updateConnectionState);
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/': (context) => DetailWithQrCode(),
        '/': (context) => SplashScreen(),
        // '/': (context) => SplashScreen(),
        //  '/': (context) => VisitorDetail(visit_id: 'OTQ='),
        '/LoginScreen': (context) => LoginScreen(),

        '/ SplashScreen': (context) => SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/visitorPage4': (context) => VisitorPage4(),
        '/visitorPage5': (context) => VisitorPage5(),
        '/visitorPage6': (context) => VisitorPage6(),
        // '/guard_dashboard': (context) => GuardDashboard(),
      },
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No Internet Connection available"),
      content: Text("Please check your internet connection and try again"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

