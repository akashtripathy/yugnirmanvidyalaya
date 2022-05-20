import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/services/api_services.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class StudentView extends StatefulWidget {
  final userData;
  const StudentView({Key? key, this.userData}) : super(key: key);

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  bool isShow = false;
  var classTeacherInfo;
  ApiServices api = ApiServices();

  getTeachersInfo() async {
    var apiResult =
        await api.getTeacherInfoForStudent(widget.userData["class"].toString());
    if (apiResult["status"] == 1) {
      classTeacherInfo = apiResult["teacher_data"];
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeachersInfo();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
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
                          backgroundImage: widget.userData["image"] != null
                              ? NetworkImage(widget.userData["image"])
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
                                "Student's Name: ${widget.userData["student_name"]}",
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
                              "Phone no.: +91${widget.userData["phone_no"]}",
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
                      Container(
                        width: size.width - 20,
                        child: Text(
                          "Class: ${widget.userData["class"]}",
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
                        "Blood Group: ${widget.userData["blood_group"]}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "DOB: ${widget.userData["dob"]}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Gender: ${widget.userData["gender"]}",
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
                          "Mother's Name: ${widget.userData['mother_name']}",
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
                        "Father's Name: ${widget.userData["father_name"]}",
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
                          "Address: ${widget.userData['address']}",
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
                            // width: size.width - 20,
                            // height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Teacher's Info:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                IconButton(
                                    onPressed: () {
                                      isShow = !isShow;
                                      setState(() {});
                                    },
                                    // splashRadius: 25,
                                    icon: isShow
                                        ? Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            // size: 25,
                                          )
                                        : Icon(Icons.keyboard_arrow_up))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                            child: Container(color: Colors.white),
                          ),
                          isShow
                              ? Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          classTeacherInfo != null
                                              ? "Class Teacher: ${classTeacherInfo["name"]}"
                                              : "Not Available",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          classTeacherInfo != null
                                              ? "Phone No: +91 ${classTeacherInfo["phone_no"]}"
                                              : "Not Available",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          classTeacherInfo != null
                                              ? "Subject: ${classTeacherInfo["subject_offered"]}"
                                              : "Not Available",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ]),
                                )
                              : Container()
                        ]))),
          ],
        ),
      ),
    );
  }
}
