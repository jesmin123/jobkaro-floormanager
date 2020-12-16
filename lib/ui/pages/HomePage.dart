
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_greetings/flutter_greetings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:job_karo_floor_manager/constants/dimen.dart';
import 'package:job_karo_floor_manager/constants/strings.dart';
import 'package:job_karo_floor_manager/provider/job_card_provider.dart';
import 'package:job_karo_floor_manager/provider/notification_provider.dart';
import 'package:job_karo_floor_manager/provider/user_provider.dart';
import 'package:job_karo_floor_manager/ui/tab_views/addnew_tab.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import '../../constants/app_font_style.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../tab_views/assigned_tab.dart';
import '../tab_views/finished_tab.dart';
import '../tab_views/pause_request_tab.dart';
import '../tab_views/addnew_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController _tabController;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    getSupportingData();
    _tabController = new TabController(vsync: this, length:4);
    _tabController.addListener(_handleTabSelection);
  }

  getSupportingData(){

    final UserProvider userProvider = Provider.of(context,listen: false);
    final NotificationProvider notificationProvider = Provider.of(context,listen: false);
    final JobCardProvider jobCardProvider = Provider.of(context,listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      jobCardProvider.initData(userProvider);
    });
  }

  void _handleTabSelection() {
    final UserProvider userProvider = Provider.of(context,listen: false);
    final NotificationProvider notificationProvider = Provider.of(context,listen: false);
    final JobCardProvider jobCardProvider = Provider.of(context,listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      jobCardProvider.initData(userProvider);
    });
  }

  @override
  Widget build(BuildContext context) {

    final UserProvider userProvider = Provider.of(context);
    final JobCardProvider jobCardProvider = Provider.of(context);

    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        leading: IconButton(icon: Icon(LineAwesomeIcons.bars, color: APP_WHITE_COLOR,size: ICON_SIZE,),onPressed: ()=>showDrawer(context)),
        actions: [
          IconButton(icon: Icon(LineAwesomeIcons.refresh,color: APP_WHITE_COLOR,size: ICON_SIZE,),onPressed: ()=>jobCardProvider.initData(userProvider),),
          IconButton(icon: Icon(LineAwesomeIcons.bell,color: APP_WHITE_COLOR,size: ICON_SIZE,),onPressed: ()=>showDrawer(context),)
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(124),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text:YonoGreetings.showGreetings()+", \n",style: AppFontStyle.regularTextStyle(APP_BLACK_COLOR)),
                          TextSpan(text:' \t \t  \t ' + userProvider.user.name,style: AppFontStyle.regularHeadingTextStyle(APP_WHITE_COLOR)),
                        ]
                      ),
                    ),
                    DigitalClock(
                      digitAnimationStyle: Curves.bounceIn,
                      hourMinuteDigitDecoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                      ),
                      secondDigitDecoration:  BoxDecoration(
                        color: PRIMARY_COLOR,
                      ),
                      is24HourTimeFormat: false,
                      areaDecoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                      ),
                      hourMinuteDigitTextStyle: AppFontStyle.regularHeadingTextStyle(APP_WHITE_COLOR),
                      amPmDigitTextStyle: AppFontStyle.headingTextStyle(APP_WHITE_COLOR),
                    ),
                  ],
                ),
              ),
              TabBar(
                tabs: <Widget>[
                  Tab(text: PENDING,),
                  Tab(text: ASSIGNED,),
                  Tab(text: PAUSE_REQUEST,),
                  Tab(text: FINISHED,),
                ],
                labelStyle: AppFontStyle.regularTextStyle(APP_BLACK_COLOR),
                controller: _tabController,
                dragStartBehavior: DragStartBehavior.down,
                indicatorColor: APP_WHITE_COLOR,
                labelColor: APP_WHITE_COLOR,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                unselectedLabelColor: APP_BLACK_COLOR,
                onTap: (x){
                  jobCardProvider.initData(userProvider);
                },
              ),
              SizedBox(height: 12,)
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 240,
              child: DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.close,size: ICON_SIZE,color: Colors.white,), onPressed: ()=>closeDrawer(context)),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(image: CachedNetworkImageProvider('https://www.adbasis.com/images/divita-a65623c8.jpg'),fit:  BoxFit.cover)
                ),
              ),
            ),
            Column(
              children: [
                Text(userProvider.user.name, style: AppFontStyle.headingTextStyle(PRIMARY_COLOR, textSize: 20.0),),
                Text('Field Manager', style: AppFontStyle.labelTextStyle3(APP_GREY_COLOR),),
                Text('Emp Code :'+ userProvider.user.empCode, style: AppFontStyle.labelTextStyle3(APP_GREY_COLOR),),
                Text('Mobile No :'+ userProvider.user.mobile, style: AppFontStyle.labelTextStyle3(APP_GREY_COLOR),),
              ],
            ),
            ListTile(
                leading: Icon(LineAwesomeIcons.lock ,size: ICON_SIZE,),
                title: Text('Change Password'),
                onTap: (){
                  Navigator.pushNamed(context, CHANGE_PASSWORD_PAGE);
                }
            ),
            ListTile(
                leading: Icon(LineAwesomeIcons.sign_out, size: ICON_SIZE),
                title: Text('Logout'),
                onTap: (){
                  return showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Logging Out", style: AppFontStyle.headingTextStyle(APP_BLACK_COLOR),),
                              SizedBox(height: LINE_HEIGHT*0.5,),
                              Text("Are you sure you want to log out?", style: AppFontStyle.labelTextStyle(APP_BLACK_COLOR), textAlign: TextAlign.center,),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel", style: AppFontStyle.headingTextStyle(PRIMARY_COLOR,textSize: 16.0),)
                                  ),
                                  VerticalDivider(width: 25,thickness: 16,),
                                  FlatButton(
                                      onPressed: (){

                                        logOut(userProvider);
                                        Navigator.pushNamed(context, LOGIN_PAGE);
                                      },
                                      child: Text("Yes", style: AppFontStyle.headingTextStyle(PRIMARY_COLOR, textSize: 16.0),)
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                  );
                }
            ),

          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
                children: [
                AddnewTab(),
                AssignedTab(),
                PauseRequestTab(),
                FinishedTab()
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }

  logOut(UserProvider userProvider) {
    userProvider.logout();
  }

  closeDrawer(BuildContext context) {
    Navigator.pop(context);
  }

  showDrawer(BuildContext context) {
    _drawerKey.currentState.openDrawer();
  }


}
