import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:yugnirmanvidyalaya/services/api_services.dart';
import 'package:yugnirmanvidyalaya/widgets/image_pickup.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class HomeNewAdmission extends StatefulWidget {
  const HomeNewAdmission({Key? key}) : super(key: key);

  @override
  _HomeNewAdmissionState createState() => _HomeNewAdmissionState();
}

class _HomeNewAdmissionState extends State<HomeNewAdmission> {
  final _formKey = GlobalKey<FormState>();
  ApiServices api = new ApiServices();
  var date = DateTime.now();
  int selectedValue = 1;

  TextEditingController mob = TextEditingController();
  TextEditingController sname = TextEditingController();
  TextEditingController dob = TextEditingController();
  String gender = "male";
  TextEditingController bloodgroup = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController caste = TextEditingController();
  TextEditingController religion = TextEditingController();
  TextEditingController saadhar = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController faadhar = TextEditingController();
  TextEditingController fedu = TextEditingController();
  TextEditingController foccu = TextEditingController();
  TextEditingController finc = TextEditingController();
  TextEditingController mname = TextEditingController();
  TextEditingController maadhar = TextEditingController();
  TextEditingController medu = TextEditingController();
  TextEditingController moccu = TextEditingController();
  TextEditingController minc = TextEditingController();
  TextEditingController disFrSch = TextEditingController();
  TextEditingController prevsc = TextEditingController();
  TextEditingController cla = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController branch = TextEditingController();
  String? imageUrl;
  String? downloadUrl;

  Future<bool> validation() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        print("Form is not filled");
        // getData();
      });
      return false;
    }
    getData();
    return true;
  }

  Future uploadImg(imgPath) async {
    ProgressDialog pd = ProgressDialog(context: context);
    final metadata = SettableMetadata(contentType: "image/jpeg");
    final file = File(imgPath);
    final path =
        'Student/images/${sname.text.replaceAll(' ', '') + mob.text.substring(5, 10)}';

    pd.show(
        max: 100,
        msg: 'Image Uploading...',
        progressBgColor: MyTheme.myBlack,
        backgroundColor: MyTheme.myBlack2);

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

  getData() async {
    ProgressDialog pd = ProgressDialog(context: context);
    if (imageUrl != null) {
      await uploadImg(imageUrl);

      pd.show(
          max: 100,
          msg: 'Data adding...',
          progressBgColor: MyTheme.myBlack,
          backgroundColor: MyTheme.myBlack2);

      var stuData = ({
        "phone_no": mob.text,
        "name": sname.text,
        "dob": dob.text,
        "gender": gender,
        "blood_group": bloodgroup.text,
        "nationality": nationality.text,
        "caste": caste.text,
        "religion": religion.text,
        "aadhar_no": saadhar.text,
        "class": cla.text,
        "distance": disFrSch.text,
        "previous_school": prevsc.text,
        "image": downloadUrl,
        "address": address.text,
        "school_branch": branch.text,
        "father_name": fname.text,
        "father_aadhar_no": faadhar.text,
        "father_education": fedu.text,
        "father_occupation": foccu.text,
        "father_annual_income": finc.text,
        "mother_name": mname.text,
        "mother_aadhar_no": maadhar.text,
        "mother_education": medu.text,
        "mother_occupation": moccu.text,
        "mother_annual_income": minc.text
      });

      var apiResult = await api.newAdmission(stuData);
      if (apiResult["status"] == 1) {
        pd.close();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Data Added Successfully')));
      } else {
        pd.close();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something went wrong: Data did't added")));
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
    nationality.text = "Indian";
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
                    "New Admission",
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
                    // width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name,
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          controller: sname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is blank";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Name",
                            labelText: "Student's Name",
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
                                width: MediaQuery.of(context).size.width * 0.5 -
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
                                            mode: CupertinoDatePickerMode.date,
                                            onDateTimeChanged:
                                                (DateTime newDateTime) {
                                              setState(() {
                                                date = newDateTime;
                                                dob = TextEditingController(
                                                    text: date.day.toString() +
                                                        "-" +
                                                        date.month.toString() +
                                                        "-" +
                                                        date.year.toString());
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
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    30,
                                child: TextFormField(
                                  // controller: gender,
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
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    30,
                                child: TextFormField(
                                  controller: bloodgroup,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Blood Group is blank";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  enabled: true,
                                  autofocus: true,
                                  scrollPadding: EdgeInsets.zero,
                                  decoration: InputDecoration(
                                    labelText: "Blood Group",
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
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    30,
                                child: TextFormField(
                                  controller: nationality,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Nationality is blank";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  enabled: true,
                                  autofocus: true,
                                  scrollPadding: EdgeInsets.zero,
                                  decoration: InputDecoration(
                                    labelText: "Nationality",
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    30,
                                child: TextFormField(
                                  controller: caste,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Caste is blank";
                                    }
                                    return null;
                                  },
                                  enabled: true,
                                  autofocus: true,
                                  scrollPadding: EdgeInsets.zero,
                                  decoration: InputDecoration(
                                    labelText: "Caste",
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
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    30,
                                child: TextFormField(
                                  controller: religion,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Religion is blank";
                                    }
                                    return null;
                                  },
                                  enabled: true,
                                  autofocus: true,
                                  scrollPadding: EdgeInsets.zero,
                                  decoration: InputDecoration(
                                    labelText: "Religion",
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
                          controller: saadhar,
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Aadhar no. is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Aadhar no.",
                            labelText: "Student's Aadhar No.",
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
                          controller: fname,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            hintText: "Name",
                            labelText: "Father's Name",
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
                        TextFormField(
                          controller: faadhar,
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Aadhar no. is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Aadhar no.",
                            labelText: "Father's Aadhar No.",
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
                        TextFormField(
                          controller: fedu,
                          keyboardType: TextInputType.text,
                          maxLength: 12,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Educational Qualification is blank";
                          //   }
                          // },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: "Educational Qualification",
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
                        TextFormField(
                          controller: foccu,
                          keyboardType: TextInputType.text,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Occupation is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: "Occupation",
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
                        TextFormField(
                          controller: finc,
                          keyboardType: TextInputType.text,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Annual Income is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: "Annual Income",
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
                          height: 40,
                        ),
                        TextFormField(
                          controller: mname,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            hintText: "Name",
                            labelText: "Mother's Name",
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
                        TextFormField(
                          controller: maadhar,
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Aadhar no. is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Aadhar no.",
                            labelText: "Mother's Aadhar No.",
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
                        TextFormField(
                          controller: medu,
                          keyboardType: TextInputType.text,
                          maxLength: 12,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Educational Qualification is blank";
                          //   }
                          // },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: "Educational Qualification",
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
                        TextFormField(
                          controller: moccu,
                          keyboardType: TextInputType.text,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Occupation is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: "Occupation",
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
                        TextFormField(
                          controller: minc,
                          keyboardType: TextInputType.text,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Annual Income is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: "Annual Income",
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
                          height: 40,
                        ),
                        TextFormField(
                          controller: disFrSch,
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Distance should not be blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Distance",
                            labelText: "Distance from school(in KM)",
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
                        TextFormField(
                          controller: prevsc,
                          keyboardType: TextInputType.text,
                          maxLength: 12,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "This should not blank";
                          //   }
                          // },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: "Previous school(if any)",
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
                        TextFormField(
                          controller: cla,
                          keyboardType: TextInputType.text,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Fill this !";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: "Class for Admission",
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
                        TextFormField(
                          controller: branch,
                          keyboardType: TextInputType.text,
                          // maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This should not blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Nua Sarsara or Barhagoda",
                            labelText: "Branch",
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
                          height: 40,
                        ),
                        TextFormField(
                          controller: address,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Address is blank";
                            }
                            return null;
                          },
                          enabled: true,
                          autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Address",
                            labelText: "Full Address",
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
                        // SizedBox(height: 10),
                        Center(child: ImagePickup(parentAction: _updateMyImg)),
                        SizedBox(height: 80),
                        continueButton(context),
                      ],
                    ),
                  ),
                ],
              ),
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
