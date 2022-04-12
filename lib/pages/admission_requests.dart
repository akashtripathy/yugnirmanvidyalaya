import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class AdmissionRequests extends StatelessWidget {
  const AdmissionRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 25,
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Admission Requests"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2),
                  border: Border.all(width: 1.0, color: MyTheme.myBlack)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Student's Name: Akash Tripathy",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Phone no.: +91 8249784125",
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
      ),
    );
  }
}
