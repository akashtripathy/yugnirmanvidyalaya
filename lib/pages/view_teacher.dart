import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class ViewTeacher extends StatelessWidget {
  final teacherData;
  const ViewTeacher({Key? key, this.teacherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // height: size.height - 100,
          // width: size.width - 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: MyTheme.myWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: MyTheme.myGrey,
                      backgroundImage: teacherData["image"] != null
                          ? NetworkImage(teacherData["image"])
                          : NetworkImage(
                              "https://yugnirmanvidyalaya.in/img/profile_avatar.png"),
                      radius: 30,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teacherData["teacher_name"].toString().toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text("+91 " + teacherData["phone_no"],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: size.width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: MyTheme.myGrey2,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: MyTheme.myGrey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gender: ${teacherData['gender']}  "),
                      SizedBox(height: 5),
                      Text("Qualifications : ${teacherData['qualifications']}"),
                      SizedBox(height: 5),
                      Text(
                          "Subjects Offered: ${teacherData['subjects_offered']}"),
                      SizedBox(height: 5),
                      Text("Class Teacher of: ${teacherData['class_teacher']}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
