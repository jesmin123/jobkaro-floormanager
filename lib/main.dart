import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/notification_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:job_karo_floor_manager/ui/pages/HomePage.dart';
import 'package:job_karo_floor_manager/ui/pages/job_details_page.dart';
import 'package:job_karo_floor_manager/ui/pages/login_page.dart';
import 'package:provider/provider.dart';
import './constants/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routes = <String,WidgetBuilder>{
      HOME_PAGE: (context)=> HomePage(),
      JOB_DETAILS_PAGE :(context)=> JobDetailsPage(),
      LOGIN_PAGE:(context)=>LoginPage()
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:  (_)=>NotificationProvider()),
        ChangeNotifierProvider(create:  (_)=>JobCardProvider()),
        ChangeNotifierProvider(create:  (_)=>UserProvider()),
      ],
      child: MaterialApp(
        title: APP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
        debugShowCheckedModeBanner: false,
        initialRoute: LOGIN_PAGE,
      ),
    );
  }


}


