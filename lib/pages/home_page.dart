import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/get_students.dart';
import 'package:yugnirmanvidyalaya/pages/home_widgets/academic.dart';
import 'package:yugnirmanvidyalaya/pages/home_widgets/payments.dart';
import 'package:yugnirmanvidyalaya/pages/home_widgets/sliding_image.dart';
import 'package:yugnirmanvidyalaya/pages/notification_page.dart';
import 'package:yugnirmanvidyalaya/pages/notificationservice/local_notification_service.dart';
import 'package:yugnirmanvidyalaya/utils/PushNotification.dart';
import 'package:yugnirmanvidyalaya/widgets/drawer.dart';
import 'package:yugnirmanvidyalaya/widgets/notification_badge.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class HomePage extends StatefulWidget {
  final userData;
  const HomePage({Key? key, this.userData}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/yug-nirman-vidyalaya.appspot.com/o/Splash%2Fimages%2Fsplash-yug-nirman-vidyalaya-0?alt=media&token=7b2813c5-fc43-4442-8c3c-a463fe218e3d",
    "https://firebasestorage.googleapis.com/v0/b/yug-nirman-vidyalaya.appspot.com/o/Splash%2Fimages%2Fsplash-yug-nirman-vidyalaya-1?alt=media&token=7b2813c5-fc43-4442-8c3c-a463fe218e3d",
    "https://firebasestorage.googleapis.com/v0/b/yug-nirman-vidyalaya.appspot.com/o/Splash%2Fimages%2Fsplash-yug-nirman-vidyalaya-2?alt=media&token=7b2813c5-fc43-4442-8c3c-a463fe218e3d",
    "https://firebasestorage.googleapis.com/v0/b/yug-nirman-vidyalaya.appspot.com/o/Splash%2Fimages%2Fsplash-yug-nirman-vidyalaya-3?alt=media&token=7b2813c5-fc43-4442-8c3c-a463fe218e3d"
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isAuth = false;
  var role;
  late int _totalNotifications;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;
  String deviceToken = "";

  checkRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
        max: 100,
        msg: 'Please wait...',
        progressBgColor: MyTheme.myBlack,
        backgroundColor: MyTheme.myBlack2);
    role = prefs.getString('role');
    if (role == null) {
      await Future.delayed(const Duration(seconds: 3));
    }
    pd.close();
    role = prefs.getString('role');
    if (role == "teacher" || role == "admin" || role == "principal") {
      setState(() {
        isAuth = true;
      });
    }
  }

  Future<void> getDeviceToken() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceToken = token.toString();
    // print("Token: $deviceToken");
  }

  @override
  void initState() {
    _totalNotifications = 0;
    checkRole();
    getDeviceToken();
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );

          setState(() {
            _notificationInfo = notification;
            _totalNotifications++;
          });
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    NotificationPage(notificationInfo: _notificationInfo),
              ),
            );
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          // print(message.notification!.title);
          // print(message.notification!.body);
          // print("message.data11 ${message.data}");

          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );

          setState(() {
            _notificationInfo = notification;
            _totalNotifications++;
          });
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NotificationPage(),
              ),
            );
          }
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );

          setState(() {
            _notificationInfo = notification;
            _totalNotifications++;
          });
          // print(message.notification!.title);
          // print(message.notification!.body);
          // print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          toolbarHeight: 100.0,
          automaticallyImplyLeading: true,
          backgroundColor: MyTheme.myBlack,
          leading: GestureDetector(
            onTap: () {
              if (isAuth == true) {
                _scaffoldKey.currentState!.openDrawer();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: CircleAvatar(
                backgroundColor: MyTheme.myGrey,
                radius: 25,
                backgroundImage: AssetImage("assets/images/LOGO.jpeg"),
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Yug Nirman",
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Vidyalaya",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
            ],
          ),
          actions: [
            isAuth
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => GetStudents())));
                    },
                    icon: Icon(
                      Icons.people_alt,
                      color: Colors.white,
                    ),
                    splashRadius: 25,
                  )
                : Container(),
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage(
                                  notificationInfo: _notificationInfo,
                                )));
                    setState(() {});
                  },
                  icon: Icon(Icons.notifications, color: Colors.white),
                  splashRadius: 25,
                ),
                Positioned(
                    top: 17,
                    right: 8,
                    child: _totalNotifications != 0
                        ? NotificationBadge(
                            totalNotifications: _totalNotifications)
                        : Container())
              ],
            ),
            isAuth
                ? Container()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: CircleAvatar(
                      backgroundColor: MyTheme.myGrey,
                      radius: 18,
                      backgroundImage: widget.userData != null &&
                              widget.userData["image"] != null
                          ? NetworkImage(widget.userData["image"])
                          : NetworkImage(
                              "https://yugnirmanvidyalaya.in/img/profile_avatar.png"),
                    ),
                  ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SlidingImage(images: images),
              SizedBox(
                height: 20,
              ),
              Academic(),
              SizedBox(
                height: 20,
              ),
              Payments()
            ],
          ),
        ),
      ),
      drawer: isAuth == false
          ? null
          : MyDrawer(
              userData: widget.userData,
              role: role,
            ),
    );
  }
}
