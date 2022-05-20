import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/pages/add_student.dart';
import 'package:yugnirmanvidyalaya/pages/add_teacher.dart';
import 'package:yugnirmanvidyalaya/pages/admission_requests.dart';
import 'package:yugnirmanvidyalaya/pages/home_page.dart';
import 'package:yugnirmanvidyalaya/pages/logged_out.dart';
import 'package:yugnirmanvidyalaya/pages/login_page.dart';
import 'package:yugnirmanvidyalaya/pages/navigation_page.dart';
import 'package:yugnirmanvidyalaya/pages/new_admission.dart';
import 'package:yugnirmanvidyalaya/pages/notification_page.dart';
import 'package:yugnirmanvidyalaya/pages/notificationservice/local_notification_service.dart';
import 'package:yugnirmanvidyalaya/pages/profile_page.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  Widget page = LoggedOutPage();

  bool? isLoggedin = prefs.getBool("loggedin") == null ? false : true;

  if (prefs.containsKey("loggedin") && isLoggedin) {
    page = NavigationPage();
  }
  runApp(MyApp(page));
}

class MyApp extends StatelessWidget {
  final Widget page;
  MyApp(this.page);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Yug Nirman Vidyalaya',
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darTheme(context),
      home: page,
      routes: {
        "/admissionrequests": (context) => AdmissionRequests(),
        "/addteacher": (context) => AddTeacher(),
        "/addstudent": (context) => AddStudent(),
        "/newadmission": (context) => NewAdmission(),
        "/navigation": (context) => NavigationPage(),
        "/home": (context) => HomePage(),
        "/notification": (context) => NotificationPage(),
        "/profile": (context) => ProfilePage(),
        "/loggedout": (context) => LoggedOutPage(),
        "/login": (context) => LoginPage(),
      },
    );
  }
}
