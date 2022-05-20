import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/edit_student.dart';
import 'package:yugnirmanvidyalaya/pages/view_student.dart';
import 'package:yugnirmanvidyalaya/services/api_services.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class GetStudents extends StatefulWidget {
  const GetStudents({Key? key}) : super(key: key);

  @override
  State<GetStudents> createState() => _GetStudentsState();
}

class _GetStudentsState extends State<GetStudents> {
  ApiServices api = ApiServices();
  var allStudent;

  getStudents() async {
    var apiResult = await api.getAllStudents();
    if (apiResult["status"] == 1) {
      allStudent = apiResult["data"];
      print(apiResult["data"]);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
    if (mounted) setState(() {});
  }

  deleteStudent(student) async {
    ProgressDialog pd = ProgressDialog(context: context);
    final path =
        'Student/images/${student["student_name"].replaceAll(' ', '') + student["phone_no"].substring(5, 10)}';
    final storageRef = FirebaseStorage.instance.ref();
    final desertRef = storageRef.child(path);
    pd.show(
        max: 100,
        msg: 'Deleting...',
        progressBgColor: MyTheme.myBlack,
        backgroundColor: MyTheme.myBlack2);
    var apiResult = await api.deleteUser(student["phone_no"].toString());
    await desertRef.delete();
    getStudents();
    if (apiResult["status"] == 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(apiResult["message"])));
      pd.close();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(apiResult["message"])));
      pd.close();
    }
    pd.close();
    setState(() {});
  }

  @override
  void initState() {
    getStudents();
    super.initState();
  }

  @override
  void dispose() {
    getStudents();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyTheme.myBlack,
        title: Text(
          "All Students",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Center(
              child: allStudent == null
                  ? Text(
                      "0",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(allStudent.length.toString(),
                      style: TextStyle(color: Colors.white))),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyTheme.myGrey2,
        ),
        width: size.width,
        // height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            allStudent == null
                ? Center(
                    child: CircularProgressIndicator(
                    color: MyTheme.myBlack,
                  ))
                : Container(
                    height: size.height * 0.85,
                    child: ListView.builder(
                        itemCount: allStudent.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      // enableDrag: true,
                                      constraints:
                                          BoxConstraints(minHeight: 20.2),
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return ViewStudent(
                                            stuData: allStudent[index]);
                                      });
                                },
                                onDoubleTap: () async {
                                  await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => EditStudent(
                                      studentData: allStudent[index],
                                    ),
                                  ));
                                  getStudents();
                                },
                                child: CircleAvatar(
                                  backgroundColor: MyTheme.myGrey,
                                  backgroundImage: allStudent[index]["image"] !=
                                          null
                                      ? NetworkImage(allStudent[index]["image"])
                                      : NetworkImage(
                                          "https://yugnirmanvidyalaya.in/img/profile_avatar.png"),
                                  radius: 20,
                                ),
                              ),
                              title: Text(allStudent[index]["student_name"]
                                  .toString()
                                  .toUpperCase()),
                              subtitle: Row(
                                children: [
                                  Text(allStudent[index]["phone_no"]),
                                  SizedBox(width: 20),
                                  Text("Class: ${allStudent[index]["class"]}")
                                ],
                              ),
                              trailing: IconButton(
                                splashRadius: 25,
                                icon: Icon(
                                  Icons.delete,
                                ),
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Alert !'),
                                      content: const Text(
                                          'Are you sure you want to delete ?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('No',
                                              style: TextStyle(
                                                  color: Colors.green)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'OK');
                                            deleteStudent(allStudent[index]);
                                          },
                                          child: const Text('Yes',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                  )
          ]),
        ),
      ),
    );
  }
}
