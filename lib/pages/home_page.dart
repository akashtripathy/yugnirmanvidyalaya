import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/home_widgets/academic.dart';
import 'package:yugnirmanvidyalaya/pages/home_widgets/payments.dart';
import 'package:yugnirmanvidyalaya/pages/home_widgets/sliding_image.dart';
import 'package:yugnirmanvidyalaya/pages/notification_page.dart';
import 'package:yugnirmanvidyalaya/widgets/drawer.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class HomePage extends StatefulWidget {
  final userData;
  const HomePage({Key? key, this.userData}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    "https://yugnirmanvidyalaya.in/img/yugnirman%20vidyalaya-1.jpeg",
    "https://yugnirmanvidyalaya.in/img/yugnirman%20vidyalaya-2.jpeg",
    "https://yugnirmanvidyalaya.in/img/yugnirman%20vidyalaya-3.jpeg"
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isAuth = false;
  var role;

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
    // print("role:" + role.toString()); TODO
    if (role == "teacher" || role == "admin" || role == "principal") {
      setState(() {
        isAuth = true;
      });
    }
    // print("isAuth:" + isAuth.toString()); TODO
  }

  @override
  void initState() {
    checkRole();
    super.initState();
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
                backgroundImage: AssetImage("assets/images/LOGO.jpeg"), //TODO
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
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              splashRadius: 25,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
              },
              icon: Icon(Icons.notifications, color: Colors.white),
              splashRadius: 25,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: CircleAvatar(
                backgroundColor: MyTheme.myGrey,
                radius: 18,
                backgroundImage: AssetImage('assets/images/avatar.png'),
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
