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
    var server = await http.post(Uri.parse(url + "add_student.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()},
        body: json.encode(stuData));
    return jsonDecode(server.body);
  }

  getAllStudents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.get(Uri.parse(url + "get_all_students.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()});
    return jsonDecode(server.body);
  }

  updateStudent(stuData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.put(Uri.parse(url + "update_student.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()},
        body: json.encode(stuData));
    return jsonDecode(server.body);
  }

  addTeacher(teacherData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.post(Uri.parse(url + "add_teacher.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()},
        body: json.encode(teacherData));
    return jsonDecode(server.body);
  }

  getAllTeachers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.get(Uri.parse(url + "get_all_teachers.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()});
    return jsonDecode(server.body);
  }

  updateTeacher(teacherData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.put(Uri.parse(url + "update_teacher.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()},
        body: json.encode(teacherData));
    return jsonDecode(server.body);
  }

  newAdmission(stuDataTemp) async {
    var server = await http.post(Uri.parse(url + "new_admission.php"),
        body: json.encode(stuDataTemp));
    return jsonDecode(server.body);
  }

  admissionRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.get(Uri.parse(url + "admission_requests.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()});
    return jsonDecode(server.body);
  }

  deleteUser(phoneNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.delete(Uri.parse(url + "delete_user.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()},
        body: json.encode({"phone_no": phoneNo}));
    return jsonDecode(server.body);
  }

  deleteAdmissionRequest(phoneNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.delete(
        Uri.parse(url + "delete_admission_request.php"),
        headers: {"Authorization": prefs.getString("jwt").toString()},
        body: json.encode({"phone_no": phoneNo}));
    return jsonDecode(server.body);
  }

  getTeacherInfoForStudent(cla) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = await http.get(
        Uri.parse(url + "get_teacher_info_for_student.php?class=$cla"),
        headers: {"Authorization": prefs.getString("jwt").toString()});
    return jsonDecode(server.body);
  }
}
