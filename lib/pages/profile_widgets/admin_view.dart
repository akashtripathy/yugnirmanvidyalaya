import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/edit_teacher.dart';
import 'package:yugnirmanvidyalaya/pages/view_teacher.dart';
import 'package:yugnirmanvidyalaya/services/api_services.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class AdminView extends StatefulWidget {
  final userData;
  const AdminView({Key? key, this.userData}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  ApiServices api = new ApiServices();
  var allTeachers;
  bool isShow = false;

  getTeachers() async {
    var apiResult = await api.getAllTeachers();
    if (apiResult["status"] == 1) {
      allTeachers = apiResult["data"];
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
    if (mounted) setState(() {});
  }

  deleteTeacher(teacher) async {
    ProgressDialog pd = ProgressDialog(context: context);
    final path =
        'Teacher/images/${teacher["teacher_name"].replaceAll(' ', '') + teacher["phone_no"].substring(5, 10)}';
    final storageRef = FirebaseStorage.instance.ref();
    final desertRef = storageRef.child(path);
    pd.show(
        max: 100,
        msg: 'Deleting...',
        progressBgColor: MyTheme.myBlack,
        backgroundColor: MyTheme.myBlack2);
    var apiResult = await api.deleteUser(teacher["phone_no"].toString());
    await desertRef.delete();
    getTeachers();
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
    getTeachers();
    super.initState();
  }

  // @override
  // void dispose() {
  //   getTeachers();
  //   super.dispose();
  // }

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
                              "Name: ${widget.userData["name"]}",
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
          SizedBox(height: 40),
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
                            "Teachers:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
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
                        ? allTeachers == null
                            ? Center(child: Text("No Teacher data"))
                            : Container(
                                height: size.height * 0.45,
                                child: ListView.builder(
                                    itemCount: allTeachers.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 7),
                                        child: ListTile(
                                          leading: GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  // enableDrag: true,
                                                  constraints: BoxConstraints(
                                                      minHeight: 20.2),
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return ViewTeacher(
                                                        teacherData:
                                                            allTeachers[index]);
                                                  });
                                            },
                                            onDoubleTap: () async {
                                              await Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    EditTeacher(
                                                  teacherData:
                                                      allTeachers[index],
                                                ),
                                              ));
                                              getTeachers();
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: MyTheme.myGrey,
                                              backgroundImage: allTeachers[
                                                          index]["image"] !=
                                                      null
                                                  ? NetworkImage(
                                                      allTeachers[index]
                                                          ["image"])
                                                  : NetworkImage(
                                                      "https://yugnirmanvidyalaya.in/img/profile_avatar.png"),
                                              radius: 20,
                                            ),
                                          ),
                                          title: Text(allTeachers[index]
                                              ["teacher_name"]),
                                          subtitle: Text(
                                              allTeachers[index]["phone_no"]),
                                          trailing: IconButton(
                                            splashRadius: 25,
                                            icon: Icon(
                                              Icons.delete,
                                            ),
                                            onPressed: () {
                                              showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: const Text('Alert !'),
                                                  content: const Text(
                                                      'Are you sure you want to delete ?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child: const Text('No',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .green)),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'OK');
                                                        deleteTeacher(
                                                            allTeachers[index]);
                                                      },
                                                      child: const Text('Yes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red)),
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
                        : Container()
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Future<String?> alertBox() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert !'),
        content: const Text('Are you sure you want to delete ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
