import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/pages/add_student.dart';
import 'package:yugnirmanvidyalaya/pages/add_teacher.dart';
import 'package:yugnirmanvidyalaya/pages/admission_requests.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class MyDrawer extends StatelessWidget {
  final userData;
  final role;
  const MyDrawer({Key? key, this.userData, this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<String> images = [
      "https://i.pinimg.com/originals/cc/18/8c/cc188c604e58cffd36e1d183c7198d21.jpg",
      "https://www.kyoceradocumentsolutions.be/blog/wp-content/uploads/2019/03/iStock-881331810.jpg",
      "https://resources.matcha-jp.com/resize/720x2000/2020/04/23-101958.jpeg"
    ];
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
                  backgroundImage:
                      AssetImage('assets/images/avatar.png'), //TODO
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.toString().toUpperCase(),
                      style: TextStyle(
                        color: MyTheme.myWhite,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      userData["name"].toString().toUpperCase(),
                      style: TextStyle(color: MyTheme.myWhite, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: MyTheme.myWhite,
              height: 2,
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
              color: MyTheme.myWhite,
              height: 0.5,
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
              color: MyTheme.myWhite,
              height: 0.5,
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
              color: MyTheme.myWhite,
              height: 0.5,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              height: 150,
              width: size.width,
              child: ListView.builder(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Stack(alignment: Alignment.center, children: [
                      Container(
                        width: 160,
                        height: 100,
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            color: MyTheme.myBlack2,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 100,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_a_photo,
                              color: MyTheme.myWhite.withOpacity(0.5),
                              size: 70,
                            )),
                      ),
                    ]);
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
