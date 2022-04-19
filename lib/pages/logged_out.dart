import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/pages/login_page.dart';
import 'package:yugnirmanvidyalaya/pages/new_admission.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class LoggedOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height * 1.0;
    var width = MediaQuery.of(context).size.width * 1.0;

    return Material(
      child: Container(
        margin: EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: MyTheme.myGrey,
              radius: 65,
              backgroundImage: AssetImage("assets/images/LOGO.jpeg"),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "YUG NIRMAN\nVIDYALAYA",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  height: 1),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "CBSE ENGLISH MEDIUM",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "An Institute to Develope Humanity Inside Human And Change to a New Era",
              style: TextStyle(
                color: MyTheme.myBlack,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(child: Container()),
            Container(
              height: 50,
              width: width - 60,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "LOG IN",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.myBlack),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: MyTheme.myWhite,
                      side: BorderSide(width: 1, color: MyTheme.myBlack),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: width - 60,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewAdmission()));
                  },
                  child: Text(
                    "NEW ADMISSION",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.myWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: MyTheme.myBlack,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
            ),
          ],
        ),
      ),
    );
  }
}
