import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
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
    ProgressDialog pd = ProgressDialog(context: context);
    // pd.show(
    //     max: 100,
    //     msg: 'Fetching data...',
    //     progressBgColor: MyTheme.myBlack,
    //     backgroundColor: MyTheme.myBlack2);
    var apiResult = await api.admissionRequests();
    if (apiResult["status"] == 1) {
      studentsData = apiResult["data"];
      print(studentsData);
      // pd.close();
    } else {
      print("fail to fetch data");
      // pd.close();
    }
    setState(() {});
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
            ? Center(child: Text("Currently there is no request"))
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    splashRadius: 25,
                                    icon: Icon(
                                      Icons.delete,
                                      size: 30,
                                    )),
                                IconButton(
                                    onPressed: () {},
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
