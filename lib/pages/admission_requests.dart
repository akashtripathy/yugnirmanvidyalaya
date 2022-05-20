import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/add_student.dart';
import 'package:yugnirmanvidyalaya/services/api_services.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class AdmissionRequests extends StatefulWidget {
  const AdmissionRequests({Key? key}) : super(key: key);

  @override
  State<AdmissionRequests> createState() => _AdmissionRequestsState();
}

class _AdmissionRequestsState extends State<AdmissionRequests> {
  ApiServices api = new ApiServices();
  var studentsData;

  Future getAdmissionRequests() async {
    var apiResult = await api.admissionRequests();
    if (apiResult["status"] == 1) {
      studentsData = apiResult["data"];
    } else {
      print("fail to fetch data");
    }
    if (mounted) setState(() {});
  }

  deleteARequest(aRequest) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
        max: 100,
        msg: 'Deleting...',
        progressBgColor: MyTheme.myBlack,
        backgroundColor: MyTheme.myBlack2);
    var apiResult =
        await api.deleteAdmissionRequest(aRequest["phone_no"].toString());
    getAdmissionRequests();
    if (apiResult["status"] == 1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(apiResult["message"])));
      pd.close();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(apiResult["message"])));
      pd.close();
    }
    pd.close();
  }

  @override
  void initState() {
    getAdmissionRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.myBlack,
          leading: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Admission Requests",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: studentsData == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: studentsData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2),
                              border: Border.all(
                                  width: 1.0, color: MyTheme.myBlack)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: size.width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Student's Name: ${studentsData[index]["student_name"]}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Phone no.: +91 ${studentsData[index]["phone_no"]}",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                IconButton(
                                    onPressed: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Alert !'),
                                          content: const Text(
                                              'Are you sure you want to delete ?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context, 'OK');
                                                deleteARequest(
                                                    studentsData[index]);
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    splashRadius: 25,
                                    icon: Icon(
                                      Icons.delete,
                                      size: 30,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => AddStudent(
                                                    newStudentData:
                                                        studentsData[index],
                                                  )));
                                    },
                                    splashRadius: 25,
                                    icon: Icon(
                                      Icons.send_rounded,
                                      size: 30,
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }));
  }
}
