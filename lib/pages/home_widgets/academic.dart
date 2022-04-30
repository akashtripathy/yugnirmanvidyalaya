import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/pages/home_new_admission.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

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
                        print("syllabus");
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
                              "SYLLABUS",
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
                        print("time table");
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
                        print("about us");
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
