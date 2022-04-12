import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:yugnirmanvidyalaya/services/api_services.dart';
import 'package:yugnirmanvidyalaya/widgets/image_pickup.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({Key? key}) : super(key: key);

  @override
  _AddTeacherState createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final _formKey = GlobalKey<FormState>();
  ApiServices api = new ApiServices();
  var date = DateTime.now();
  int selectedValue = 2;

  TextEditingController name = TextEditingController();
  TextEditingController dob = TextEditingController();
  String gender = "female";
  TextEditingController mob = TextEditingController();
  TextEditingController subjectsOffered = TextEditingController();
  TextEditingController qualificaions = TextEditingController();
  String? imageUrl;
  String? downloadUrl;

  Future<bool> validation() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        print("Form is not filled");
      });
      return false;
    }
    addTeacherData();
    return true;
  }

  Future uploadImg(imgPath) async {
    ProgressDialog pd = ProgressDialog(context: context);
    final metadata = SettableMetadata(contentType: "image/jpeg");
    final file = File(imgPath);
    final path =
        'Teacher/images/${name.text.replaceAll(' ', '') + mob.text.substring(5, 10)}';

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

  addTeacherData() async {
    ProgressDialog pd = ProgressDialog(context: context);
    if (imageUrl != null) {
      await uploadImg(imageUrl);

      pd.show(
          max: 100,
          msg: 'Data adding...',
          progressBgColor: MyTheme.myBlack,
          backgroundColor: MyTheme.myBlack2);
      var teacherData = ({
        "phone_no": mob.text,
        "teacher_name": name.text,
        "dob": dob.text,
        "gender": gender,
        "subjects_offered": subjectsOffered.text,
        "qualifications": qualificaions.text,
        "image": downloadUrl
      });
      var apiResult = await api.addTeacher(teacherData);
      if (apiResult["status"] == 1) {
        pd.close();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(apiResult["message"])));
      } else {
        pd.close();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(apiResult["message"])));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Select student image")));
    }
  }

  _updateMyImg(String img) {
    setState(() {
      imageUrl = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Teacher",
                      style: TextStyle(
                          fontSize: 35,
                          letterSpacing: 1,
                          color: MyTheme.myBlack,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: name,
                            keyboardType: TextInputType.name,
                            enabled: true,
                            autofocus: true,
                            scrollPadding: EdgeInsets.zero,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name is blank";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Name",
                              labelText: "Teacher's Name",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyTheme.myBlack, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyTheme.myBlack, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          30,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: dob,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "DOB is blank";
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      showCupertinoModalPopup<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return _buildBottomPicker(
                                            CupertinoDatePicker(
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              onDateTimeChanged:
                                                  (DateTime newDateTime) {
                                                setState(() {
                                                  date = newDateTime;
                                                  dob = TextEditingController(
                                                      text:
                                                          date.day.toString() +
                                                              "-" +
                                                              date.month
                                                                  .toString() +
                                                              "-" +
                                                              date.year
                                                                  .toString());
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    keyboardType: TextInputType.datetime,
                                    enabled: true,
                                    autofocus: true,
                                    scrollPadding: EdgeInsets.zero,
                                    decoration: InputDecoration(
                                      hintText: "DD-MM-YYYY",
                                      labelText: "Date Of Birth",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyTheme.myBlack, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyTheme.myBlack, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          30,
                                  child: TextFormField(
                                    readOnly: true,
                                    keyboardType: TextInputType.text,
                                    enabled: true,
                                    autofocus: true,
                                    scrollPadding: EdgeInsets.zero,
                                    decoration: InputDecoration(
                                      suffixIcon: _dropDownMenu(),
                                      labelText: "Gender",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyTheme.myBlack, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyTheme.myBlack, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: mob,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Phone no. is blank";
                              } else if (value.length < 10) {
                                return "Enter valid Phone no.";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            autofocus: true,
                            scrollPadding: EdgeInsets.zero,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              hoverColor: MyTheme.myBlack,
                              hintText: "Phone no.",
                              labelText: "Enter Phone no.",
                              prefix: Text(
                                "+91 ",
                                style: TextStyle(color: MyTheme.myBlack),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyTheme.myBlack, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyTheme.myBlack, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: subjectsOffered,
                            keyboardType: TextInputType.text,
                            enabled: true,
                            autofocus: true,
                            scrollPadding: EdgeInsets.zero,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Subject is blank";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Subject1, Subject2, Subject3...",
                              labelText: "Subjects Offered",
                              helperText:
                                  "NOTE: Add subeject separated by comma",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyTheme.myBlack, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyTheme.myBlack, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: qualificaions,
                            keyboardType: TextInputType.text,
                            enabled: true,
                            autofocus: true,
                            scrollPadding: EdgeInsets.zero,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Qualification is blank";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText:
                                  "Qualification1, Qualification2, Qualification3...",
                              labelText: "Qualifications",
                              helperText:
                                  "NOTE: Add qualification separated by comma",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyTheme.myBlack, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyTheme.myBlack, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          ImagePickup(parentAction: _updateMyImg),
                          SizedBox(height: 40),
                          continueButton(context)
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropDownMenu() {
    return DropdownButton(
        value: selectedValue,
        items: [
          DropdownMenuItem(
            child: Text("Male"),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text("Female"),
            value: 2,
          ),
          DropdownMenuItem(child: Text("Others"), value: 3),
        ],
        onChanged: (value) {
          setState(() {
            selectedValue = int.parse(value.toString());
            if (selectedValue == 1) {
              gender = "male";
            } else if (selectedValue == 2) {
              gender = 'female';
            } else {
              gender = "other";
            }
          });
        });
  }

  Widget continueButton(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            validation();
            setState(() {});
          },
          child: Text(
            "CONTINUE",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MyTheme.myWhite),
          ),
          style: ElevatedButton.styleFrom(
              primary: MyTheme.myBlack,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: Colors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22.0,
        ),
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    );
  }
}
