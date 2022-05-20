import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/widgets/form_pdf.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class ViewStudent extends StatelessWidget {
  final stuData;
  const ViewStudent({Key? key, this.stuData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // height: size.height - 100,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: MyTheme.myWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: MyTheme.myGrey,
                          backgroundImage: stuData["image"] != null
                              ? NetworkImage(stuData["image"])
                              : NetworkImage(
                                  "https://yugnirmanvidyalaya.in/img/profile_avatar.png"),
                          radius: 30,
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: size.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stuData["student_name"]
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text("+91 " + stuData["phone_no"],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          orderPdfView(context, stuData);
                        },
                        icon: Icon(Icons.download))
                  ],
                ),
                SizedBox(height: 20),
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
                      Text(
                          "DOB: ${stuData['dob']}     Gender: ${stuData['gender']}"),
                      SizedBox(height: 5),
                      Text(
                          "Blood Group: ${stuData['blood_group']}     Class: ${stuData['class']}"),
                      SizedBox(height: 5),
                      Text(
                          "Caste: ${stuData['caste']}     Religion: ${stuData['relogion']}"),
                      SizedBox(height: 5),
                      Text(
                          "Nationality: ${stuData['nationality']}    Aadhar: ${stuData['aadhar_no']}"),
                    ],
                  ),
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
                      Text("Father's Name: ${stuData['father_name']}  "),
                      SizedBox(height: 5),
                      Text(
                          "Father's Aadhar No : ${stuData['father_aadhar_no']}"),
                      SizedBox(height: 5),
                      Text(
                          "Father's Occupation: ${stuData['father_occupation']}"),
                      SizedBox(height: 5),
                      Text(
                          "Father's Education: ${stuData['father_edu_qualification']}"),
                      SizedBox(height: 5),
                      Text(
                          "Father's Income: ${stuData['father_annual_income']}"),
                    ],
                  ),
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
                      Text("Mother's Name: ${stuData['mother_name']}"),
                      SizedBox(height: 5),
                      Text(
                          "Mother's Aadhar No : ${stuData['mother_aadhar_no']}"),
                      SizedBox(height: 5),
                      Text(
                          "Mother's Occupation: ${stuData['mother_occupation']}"),
                      SizedBox(height: 5),
                      Text(
                          "Mother's Education: ${stuData['mother_edu_qualification']}"),
                      SizedBox(height: 5),
                      Text(
                          "Mother's Income: ${stuData['mother_annual_income']}"),
                    ],
                  ),
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
                      Text("Branch: ${stuData['school_branch']}"),
                      SizedBox(height: 5),
                      Text("Address: ${stuData['address']}"),
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
