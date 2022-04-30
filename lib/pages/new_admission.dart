import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:yugnirmanvidyalaya/services/api_services.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class NewAdmission extends StatefulWidget {
  const NewAdmission({Key? key}) : super(key: key);

  @override
  _NewAdmissionState createState() => _NewAdmissionState();
}

class _NewAdmissionState extends State<NewAdmission> {
  bool isOtp = false;
  bool isFormValidate = false;
  final _formKey = GlobalKey<FormState>();
  var date = DateTime.now();
  int selectedValue = 2;
  ApiServices api = new ApiServices();
  late String verId;

  TextEditingController phoneNo = TextEditingController();
  TextEditingController sname = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController mname = TextEditingController();
  TextEditingController dob = TextEditingController();
  String gender = "female";
  TextEditingController otp = TextEditingController();

  validation() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        print("Form is not filled");
      });
      return false;
    }
    isFormValidate = true;
    return true;
  }

  getOtp() async {
    ProgressDialog pd = ProgressDialog(context: context);
    FirebaseAuth auth = FirebaseAuth.instance;
    pd.show(
        max: 100,
        msg: 'Sending OTP...',
        progressBgColor: MyTheme.myBlack,
        backgroundColor: MyTheme.myBlack2);
    await auth.verifyPhoneNumber(
      phoneNumber: '+91' + phoneNo.text,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        pd.close();
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Phone no. is not valid")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something went wrong!")));
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Code Send to +91 " + phoneNo.text)));
        verId = verificationId;
        pd.close();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOtp() async {
    ProgressDialog pd = ProgressDialog(context: context);
    FirebaseAuth auth = FirebaseAuth.instance;
    pd.show(
        max: 100,
        msg: 'Please wait...',
        progressBgColor: MyTheme.myBlack,
        backgroundColor: MyTheme.myBlack2);
    if (otp.text.length == 6) {
      PhoneAuthCredential cradential = PhoneAuthProvider.credential(
          verificationId: verId, smsCode: otp.text);
      try {
        await auth.signInWithCredential(cradential);
        await addNewAdmission();
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid OTP!")));
      }
      pd.close();
    }
  }

  addNewAdmission() async {
    ProgressDialog pd = ProgressDialog(context: context);
    var stuDataTemp = ({
      "phone_no": phoneNo.text,
      "name": sname.text,
      "dob": dob.text,
      "gender": gender,
      "father_name": fname.text,
      "mother_name": mname.text
    });

    pd.show(
        max: 100,
        msg: 'Data adding...',
        progressBgColor: MyTheme.myBlack,
        backgroundColor: MyTheme.myBlack2);

    var apiResult = await api.newAdmission(stuDataTemp);

    if (apiResult["status"] == 1) {
      pd.close();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Register Successfully! Kindly Contact School')));
    } else {
      pd.close();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong: Registration Fail !")));
    }
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
                          controller: sname,
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
                                  controller: dob,
                                  readOnly: true,
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
                          height: 60,
                        ),
                        TextFormField(
                          controller: phoneNo,
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
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            // errorText: ,
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

                            suffixIcon: otpButton(context),
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
                          controller: otp,
                          onChanged: (value) {
                            if (value.length > 5) {
                              isOtp = true;
                            }
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          // enabled: true,
                          // autofocus: true,
                          scrollPadding: EdgeInsets.zero,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            hoverColor: MyTheme.myBlack,
                            hintText: "OTP",
                            labelText: "Enter OTP",
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
          onPressed: () async {
            if (isOtp) {
              await verifyOtp();
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationPage()));
            }
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

  Widget otpButton(context) {
    return Container(
      height: 25,
      width: 80,
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          onPressed: () {
            validation();
            if (isFormValidate) {
              getOtp();
            }
            setState(() {});
          },
          child: Text(
            "GET OTP",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: MyTheme.myWhite),
          ),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              primary: MyTheme.myBlack,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
    );
  }
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
