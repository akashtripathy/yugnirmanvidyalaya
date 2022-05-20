import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/pages/home_new_admission.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';
import 'package:yugnirmanvidyalaya/widgets/view_pdf.dart';

class Academic extends StatelessWidget {
  const Academic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyTheme.myGrey2,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ACADEMIC",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: MyTheme.myBlack),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeNewAdmission()));
                  },
                  child: Container(
                    height: 145,
                    width: 134,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.myBlack2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/Edit.png",
                          height: 70,
                        ),
                        Text(
                          "NEW ADMISSION",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: MyTheme.myWhite),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        var path =
                            "https://firebasestorage.googleapis.com/v0/b/yug-nirman-vidyalaya.appspot.com/o/PDF%2FCURRICULUM.pdf?alt=media&token=cbf88c58-6897-407f-957a-6dbeefa4aa9b";
                        var page = "Curriculum";
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewPdf(
                                  path: path,
                                  page: page,
                                )));
                      },
                      child: Container(
                        height: 70,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.myBlack2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/Book-open.png",
                              height: 30,
                            ),
                            Text(
                              "CURRICULUM",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: MyTheme.myWhite),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        print("fees structure");
                        var path =
                            "https://firebasestorage.googleapis.com/v0/b/yug-nirman-vidyalaya.appspot.com/o/PDF%2FFEE%20STRUCTURE.pdf?alt=media&token=eda6bfea-2a09-4100-934d-061fec63eecc";
                        var page = "Fee Structure";
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewPdf(
                                  path: path,
                                  page: page,
                                )));
                      },
                      child: Container(
                        height: 70,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.myBlack2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/Invoice.png",
                              height: 30,
                            ),
                            Text(
                              "FEE STRUCTURE",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: MyTheme.myWhite),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        var path =
                            "https://firebasestorage.googleapis.com/v0/b/yug-nirman-vidyalaya.appspot.com/o/PDF%2FTIME%20TABLE.pdf?alt=media&token=3ecc1c69-0f49-4e2a-ae58-52837b90443a";
                        var page = "Time Table";
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewPdf(
                                  path: path,
                                  page: page,
                                )));
                      },
                      child: Container(
                        height: 70,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.myBlack2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/Icon.png",
                              height: 30,
                            ),
                            Text(
                              "TIME TABLE",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: MyTheme.myWhite),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        var path =
                            "https://firebasestorage.googleapis.com/v0/b/yug-nirman-vidyalaya.appspot.com/o/PDF%2FABOUT%20US.pdf?alt=media&token=c68b974f-bc70-45f6-b895-4938f1c2066a";
                        var page = "About Us";
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewPdf(
                                  path: path,
                                  page: page,
                                )));
                      },
                      child: Container(
                        height: 70,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.myBlack2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/Award.png",
                              height: 35,
                            ),
                            Text(
                              "ABOUT US",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: MyTheme.myWhite),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
