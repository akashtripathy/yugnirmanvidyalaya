import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/add_student.dart';
import 'package:yugnirmanvidyalaya/pages/add_teacher.dart';
import 'package:yugnirmanvidyalaya/pages/admission_requests.dart';
import 'package:yugnirmanvidyalaya/widgets/image_pickup.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class MyDrawer extends StatefulWidget {
  final userData;
  final role;
  const MyDrawer({Key? key, this.userData, this.role}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<String> images = [];
  String? imageUrl;
  String? downloadUrl;

  _updateMyImg(String img) {
    setState(() {
      imageUrl = img;
    });
  }

  getSplashImage() async {
    final storageRef = FirebaseStorage.instance.ref();
    final listResult = await storageRef.child("Splash/images").listAll();
    for (var item in listResult.items) {
      var imUrl = await storageRef.child(item.fullPath).getDownloadURL();
      images.add(imUrl.toString());
    }
    if (!mounted) return;
    setState(() {});
  }

  Future addSplashImage(imgPath, index) async {
    ProgressDialog pd = ProgressDialog(context: context);
    final metadata = SettableMetadata(contentType: "image/jpeg");
    final file = File(imgPath);
    final path = 'Splash/images/splash-yug-nirman-vidyalaya-$index';

    pd.show(
        max: 100,
        msg: 'Image Uploading...',
        progressBgColor: MyTheme.myBlack,
        backgroundColor: MyTheme.myBlack2);

    // await Firebase.initializeApp();
    final _firebaseStorage = FirebaseStorage.instance;
    var snapshot =
        await _firebaseStorage.ref().child(path).putFile(file, metadata);
    await snapshot.ref.getDownloadURL().then((fileURL) {
      setState(() {
        downloadUrl = fileURL;
      });
    });
    pd.close();
  }

  @override
  void initState() {
    getSplashImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.7,
      child: Drawer(
          child: Container(
        padding: EdgeInsets.only(top: 20),
        width: 100,
        color: MyTheme.myBlack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: MyTheme.myGrey,
                  radius: 25,
                  backgroundImage: widget.userData["image"] != null
                      ? NetworkImage(widget.userData["image"])
                      : NetworkImage(
                          "https://yugnirmanvidyalaya.in/img/profile_avatar.png"),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.role.toString().toUpperCase(),
                      style: TextStyle(
                        color: MyTheme.myWhite,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.userData["name"].toString().toUpperCase(),
                      style: TextStyle(color: MyTheme.myWhite, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: MyTheme.myBlack2,
              height: 0.5,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AdmissionRequests())));
              },
              child: Container(
                width: size.width,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  'Admission Requests',
                  style: TextStyle(color: MyTheme.myWhite, fontSize: 18),
                ),
              ),
            ),
            Container(
              color: MyTheme.myBlack2,
              height: 0.2,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddStudent())));
              },
              child: Container(
                width: size.width,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  'Add Student',
                  style: TextStyle(color: MyTheme.myWhite, fontSize: 18),
                ),
              ),
            ),
            Container(
              color: MyTheme.myBlack2,
              height: 0.2,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddTeacher())));
              },
              child: Container(
                width: size.width,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  'Add Teacher',
                  style: TextStyle(color: MyTheme.myWhite, fontSize: 18),
                ),
              ),
            ),
            Container(
              color: MyTheme.myBlack2,
              height: 0.2,
            ),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              height: 150,
              // width: size.width,
              child: images.length > 0
                  ? ListView.builder(
                      itemCount: images.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ImagePickup(
                              parentAction: _updateMyImg,
                              currentImg: images[index],
                            ),
                            Positioned(
                              child: imageUrl != null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 20,
                                      child: IconButton(
                                          onPressed: () {
                                            if (imageUrl != null) {
                                              addSplashImage(imageUrl, index);
                                            }
                                          },
                                          icon: Icon(Icons.done)),
                                    )
                                  : Container(),
                              bottom: 15,
                              right: 5,
                            ),
                          ],
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(color: Colors.white)),
            ),
          ],
        ),
      )),
    );
  }
}
