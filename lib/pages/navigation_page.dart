import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yugnirmanvidyalaya/pages/home_page.dart';
import 'package:yugnirmanvidyalaya/pages/inbox_page.dart';
import 'package:yugnirmanvidyalaya/pages/profile_page.dart';
import 'package:yugnirmanvidyalaya/services/api_services.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  DateTime currentBackPressTime = DateTime.now();
  ApiServices api = new ApiServices();
  var userData;
  var role;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    var apiResult = await api.getUserByToken();
    if (apiResult["status"] == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("role", apiResult["role"]);
      userData = apiResult['user_data'];
      role = apiResult["role"];
    } else {
      print("Fail to fetch user data");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      HomePage(
        userData: userData,
      ),
      InboxPage(),
      ProfilePage(
        userData: userData,
        role: role,
      )
    ];

    onTapped(index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      body: WillPopScope(onWillPop: onWillPop, child: tabs[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        backgroundColor: MyTheme.myBlack,
        currentIndex: _currentIndex,
        selectedItemColor: MyTheme.myYellow,
        unselectedItemColor: MyTheme.myWhite,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/Home.png",
                height: 30,
              ),
              label: "HOME"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/Comment.png",
                height: 30,
              ),
              label: "INBOX"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/User.png",
                height: 30,
              ),
              label: "PROFILE"),
        ],
      ),
    );
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Tap again to exit")));
      return false;
    }
    setState(() {
      SystemNavigator.pop();
    });
    return true;
  }
}
