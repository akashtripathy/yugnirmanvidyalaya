import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class TeacherView extends StatelessWidget {
  final userData;
  const TeacherView({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: MyTheme.myGrey,
                        backgroundImage: userData["image"] != null
                            ? NetworkImage(userData["image"])
                            : NetworkImage(
                                "https://yugnirmanvidyalaya.in/img/profile_avatar.png"),
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
                              "Name: ${userData["name"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Phone no.: +91${userData["phone_no"]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
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
          SizedBox(height: 15),
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
                        "Subjects Offered:",
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
                      "${userData['subjects_offered']}",
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
    );
  }
}
