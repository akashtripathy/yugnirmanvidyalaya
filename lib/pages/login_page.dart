import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/navigation_page.dart';
import 'package:yugnirmanvidyalaya/services/api_services.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mob = TextEditingController();
  final otp = TextEditingController();
  late String verId;

  bool isEnable = false;
  bool isOtp = false;
  bool isValidOtp = false;

  ApiServices api = new ApiServices();

  bool validate(context) {
    if (mob.text.length < 10) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter valid Phone no.")));
      return false;
    }
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
      phoneNumber: '+91' + mob.text,
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
            SnackBar(content: Text("Code Send to +91 " + mob.text)));
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
        isValidOtp = true;
        await getToken();
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid OTP!")));
      }
      pd.close();
    }
  }

  getToken() async {
    var apiResult = await api.getToken(mob.text);
    if (apiResult["status"] == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("jwt", apiResult["jwt"]);
      await prefs.setBool("loggedin", true);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Successful')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(apiResult["message"])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Log in",
                  style: TextStyle(
                      fontSize: 40,
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
                      Text("Enter your registered phone no.",
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1,
                              color: MyTheme.myBlack)),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        controller: mob,
                        autofocus: true,
                        scrollPadding: EdgeInsets.zero,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          // errorText: ,
                          counterText: "",

                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          hoverColor: MyTheme.myBlack,
                          hintText: "Phone no.",
                          prefix: Text(
                            "+91 ",
                            style: TextStyle(color: MyTheme.myBlack),
                          ),

                          suffix: otpButton(context),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyTheme.myBlack, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyTheme.myBlack, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Enter OTP",
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1,
                              color: MyTheme.myBlack)),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        onChanged: (value) {
                          if (value.length == 6) {
                            isOtp = true;
                          }
                        },
                        keyboardType: TextInputType.number,
                        controller: otp,
                        maxLength: 6,
                        enabled: isEnable ? true : false,
                        autofocus: true,
                        scrollPadding: EdgeInsets.zero,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, letterSpacing: 5),
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          hoverColor: MyTheme.myBlack,
                          hintText: "OTP",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyTheme.myBlack, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyTheme.myBlack, width: 2),
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
    );
  }

  Widget otpButton(context) {
    return Container(
      height: 25,
      width: 80,
      padding: EdgeInsets.zero,
      child: ElevatedButton(
          onPressed: () {
            bool check = validate(context);
            if (check) {
              isEnable = true;
              getOtp();
            }
            setState(() {});
          },
          child: Text(
            "GET OTP",
            style: TextStyle(
                fontSize: 16,
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

  Widget continueButton(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
          onPressed: () async {
            if (isOtp) {
              await verifyOtp();
              if (isValidOtp) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => NavigationPage()));
              }
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Enter Valid OTP")));
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
}
