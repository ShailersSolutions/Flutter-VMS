import 'package:facechk_app/Provider/pre_invite_form_provider.dart';
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

import 'Screen/Visitor_detail.dart';

import 'Screen/visitor_page4.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreInvitationFormProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

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
}
