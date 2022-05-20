import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/logged_out.dart';
import 'package:yugnirmanvidyalaya/pages/profile_widgets/admin_view.dart';
import 'package:yugnirmanvidyalaya/pages/profile_widgets/student_view.dart';
import 'package:yugnirmanvidyalaya/pages/profile_widgets/teacher_view.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class ProfilePage extends StatelessWidget {
  final userData;
  final role;

  const ProfilePage({Key? key, this.userData, this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logout() async {
      ProgressDialog pd = ProgressDialog(context: context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      FirebaseAuth auth = FirebaseAuth.instance;
      pd.show(
          max: 100,
          msg: 'Loging out...',
          progressBgColor: MyTheme.myBlack,
          backgroundColor: MyTheme.myBlack2);
      await auth.signOut();
      var a = await prefs.clear();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoggedOutPage()),
          (route) => false);
      pd.close();
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => LoggedOutPage()),
          (route) => false);
    }

    Widget checkUser() {
      if (role == "principal" || role == "admin") {
        return AdminView(userData: userData);
      }
      if (role == "teacher") {
        return TeacherView(userData: userData);
      }
      return StudentView(userData: userData);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyTheme.myBlack,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            // height: 20,
            width: 100,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  logout();
                },
                child: Text(
                  "LOG OUT",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.myWhite),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
          )
        ],
      ),
      body: userData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : checkUser(),
    );
  }
}
