import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/logged_out.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class ProfilePage extends StatelessWidget {
  final userData;

  const ProfilePage({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(userData);

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
      print("pref:" + a.toString());
      runApp(MaterialApp(home: LoggedOutPage()));
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
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.myGrey2,
                    ),
                    width: size.width,
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: MyTheme.myGrey,
                                radius: 40,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width - 120,
                                    child: Text(
                                      "Student's Name: ${userData["student_name"]}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Phone no.: ${userData["phone_no"]}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // SizedBox(
                                  //   height: 4,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "DOB: ${userData["dob"]}",
                                  //       style: TextStyle(fontSize: 14),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //     Text(
                                  //       "Gender: ${userData["gender"]}",
                                  //       style: TextStyle(fontSize: 14),
                                  //     )
                                  //   ],
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.myGrey2,
                    ),
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width - 20,
                              child: Text(
                                "Class: ${userData["class"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Blood Group: ${userData["blood_group"]}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "DOB: ${userData["dob"]}",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Gender: ${userData["gender"]}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.myGrey2,
                    ),
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width - 20,
                              child: Text(
                                "Mother's Name: ${userData['mother_name']}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Father's Name: ${userData["father_name"]}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.myGrey2,
                    ),
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width - 20,
                              child: Text(
                                "Address:",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "${userData['address']}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
