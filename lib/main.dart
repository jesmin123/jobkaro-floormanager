import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/new_task_provider.dart';
import 'package:job_karo_floor_manager/provider/notification_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:job_karo_floor_manager/ui/pages/HomePage.dart';
import 'package:job_karo_floor_manager/ui/pages/change_password.dart';
import 'package:job_karo_floor_manager/ui/pages/finished_detail_page.dart';
import 'package:job_karo_floor_manager/ui/pages/job_details_page.dart';
import 'package:job_karo_floor_manager/ui/pages/login_page.dart';
import 'package:provider/provider.dart';
import './constants/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserProvider userProvider = UserProvider();
  bool isLoggedIN  = await userProvider.checkLoginLocal();
  String initialRoute = LOGIN_PAGE;
  if(isLoggedIN){
    initialRoute =  HOME_PAGE;
  }
  await Future.delayed(Duration(seconds: 1));
  runApp(MyApp(initialRoute: initialRoute,));

}

class MyApp extends StatelessWidget {

  final String initialRoute;

  MyApp({this.initialRoute});

  final routes = <String,WidgetBuilder>{
      HOME_PAGE: (context)=> HomePage(),
      JOB_DETAILS_PAGE :(context)=> JobDetailsPage(),
      LOGIN_PAGE:(context)=>LoginPage(),
      CHANGE_PASSWORD_PAGE:(context)=> ChangePasswordPage(),
      FINISHED_DETAILS_PAGE:(context)=> FinishedDetailPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:  (_)=>NotificationProvider()),
        ChangeNotifierProvider(create:  (_)=>JobCardProvider()),
        ChangeNotifierProvider(create:  (_)=>UserProvider()),
        ChangeNotifierProvider(create:  (_)=>NewtaskProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, appData, child) {
          decideFirstPage(context);
          return MaterialApp(
            title: APP_NAME,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routes: routes,
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
          );
        }
      ),
    );
  }

  decideFirstPage(BuildContext context) async {
    final UserProvider userProvider = Provider.of(context,listen: false);
    bool isLoggedIN = await userProvider.checkLoginLocal();
    if(isLoggedIN){
      return HOME_PAGE;
    }
    return LOGIN_PAGE;
  }


}


