import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  String url = "https://yugnirmanvidyalaya.in/yug-nirman-vidyalaya/api/user/";

  getToken(phoneNo) async {
    var server = await http.post(Uri.parse(url + "login.php"),
        body: json.encode({"phone_no": phoneNo}));
    return jsonDecode(server.body);
  }

  getUserByToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.get(Uri.parse(url + "get_user_by_token.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()});
    return jsonDecode(server.body);
  }

  // sname,dob,gender,phoneno,religion,nationality,caste,bloodGroup,saadhar,fname,faadhar,foccu,fedu,finc,mname,maadhar,moccu,medu,minc,disFrSch,prevsc,cla,branch,address,imgUrl

  addStudent(stuData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("from api services");
    print(stuData);
    var server = await http.post(Uri.parse(url + "add_student.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()},
        body: json.encode(stuData));
    return jsonDecode(server.body);
  }

  addTeacher(teacherData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("from api services");
    print(teacherData);
    var server = await http.post(Uri.parse(url + "add_teacher.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()},
        body: json.encode(teacherData));
    return jsonDecode(server.body);
  }
}