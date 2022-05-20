import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/view_form.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

orderPdfView(context, final student) async {
  ProgressDialog pd = ProgressDialog(context: context);
  pd.show(
      max: 100,
      msg: 'Creating Document...',
      progressBgColor: MyTheme.myBlack,
      backgroundColor: MyTheme.myBlack2);
  final Document pdf = Document(compress: true);
  final logo = await networkImage(
      'https://yugnirmanvidyalaya.in/img/Yug%20Nirman%20Logo%20PNG.png');
  final stuProfilePic = await networkImage(student["image"]);
  pdf.addPage(
    pw.Page(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.natural,
        build: (context) => pw.Container(
              padding: pw.EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              color: PdfColor.fromHex("#d4fc8f"),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(children: [
                    pw.Image(logo, width: 100),
                    pw.SizedBox(width: 20),
                    pw.Column(children: [
                      pw.Text(
                        "YUGNIRMAN VIDYALAYA",
                        style: pw.TextStyle(
                            fontSize: 20,
                            color: PdfColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      pw.Text(
                        "CBSE ENGLISH MEDIUM",
                        style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      pw.Text(
                        "\u{00BB} Near Barahagoda Canal Chowk",
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Text(
                        "\u{00BB} Near MGP College, Nua Sarsara",
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                        ),
                      ),
                    ]),
                  ]),
                  pw.SizedBox(height: 20),
                  pw.Center(
                      child: pw.Text(
                    "ADMISSION FORM",
                    style: pw.TextStyle(
                        fontSize: 25,
                        color: PdfColors.black,
                        fontWeight: FontWeight.bold),
                  )),
                  pw.SizedBox(height: 10),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "Admission No.:         ",
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.black),
                        ),
                        pw.Text(
                          "Form No.:           ",
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.black),
                        ),
                      ]),
                  pw.SizedBox(height: 30),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                            height: 120,
                            width: 110,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.black)),
                            child: pw.Text("Photo of\nFather",
                                style: pw.TextStyle(
                                    fontSize: 14, color: PdfColors.grey))),
                        pw.Container(
                            height: 120,
                            width: 110,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.black)),
                            child: pw.Text("Photo of\nMother",
                                style: pw.TextStyle(
                                    fontSize: 14, color: PdfColors.grey))),
                        pw.Container(
                            height: 120,
                            width: 110,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.black)),
                            child: student["image"] == null
                                ? pw.Text("Photo of\nFather",
                                    style: pw.TextStyle(
                                        fontSize: 14, color: PdfColors.grey))
                                : pw.Image(stuProfilePic, fit: pw.BoxFit.cover))
                      ]),
                  pw.SizedBox(height: 60),
                  pw.Text(
                    "We,\n desire ${student["father_name"].toString().toUpperCase()} and ${student["mother_name"].toString().toUpperCase()} to have our son/daughter/ward whose particular are given below admitted as a day scholor in your school:",
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Container(
                    child: pw.Column(
                        // mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "INFORMATION OF THE STUDENT",
                            style: pw.TextStyle(
                                fontSize: 16,
                                color: PdfColors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            "Student's Name: ${student["student_name"].toString().toUpperCase()}",
                            style: pw.TextStyle(
                                fontSize: 14, color: PdfColors.black),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Gender: ${student["gender"].toString().toUpperCase()}",
                            style: pw.TextStyle(
                                fontSize: 14, color: PdfColors.black),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Date of Birth: ${student["dob"].toString()}",
                            style: pw.TextStyle(
                                fontSize: 14, color: PdfColors.black),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Blood Group: ${student["blood_group"].toString().toUpperCase()}\t\t Caste: ${student["caste"].toString().toUpperCase()} \t\t Nationality: ${student["nationality"].toString().toUpperCase()} \t\t Reigion: ${student["relogion"].toString().toUpperCase()}",
                            style: pw.TextStyle(
                                fontSize: 14, color: PdfColors.black),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            "Aadhar No.: ${student["aadhar_no"].toString().toUpperCase()}\t\t Mobile No: ${student["phone_no"].toString().toUpperCase()} ",
                            style: pw.TextStyle(
                                fontSize: 14, color: PdfColors.black),
                          ),
                        ]),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Container(
                      child: pw.Column(
                          // mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        pw.Text(
                          "RESIDENTIAL ADDRESS",
                          style: pw.TextStyle(
                              fontSize: 16,
                              color: PdfColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "${student["address"].toString().toUpperCase()}",
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Distance from school(in KMs): ${student["distance"].toString().toUpperCase()} KM",
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          "Emargency Contact No (Mobile No.): ",
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          "Previous School (if Any): ${student["previous_school"].toString().toUpperCase()}",
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.black),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          "Class for which admission is sought: ${student["class"].toString().toUpperCase()}",
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.black),
                        ),
                      ])),
                ],
              ),
            )),
  );

  pdf.addPage(pw.Page(
    margin: pw.EdgeInsets.zero,
    pageFormat: PdfPageFormat.a4,
    build: (context) => pw.Container(
        padding: pw.EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        color: PdfColor.fromHex("#d4fc8f"),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                    pw.Text(
                      "FAMILY INFORMATION",
                      style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      "Father/Gaurdian: ",
                      style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Name: ${student["father_name"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Date of Birth: ",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Educational Qualification: ${student["father_edu_qualification"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Occupation: ${student["father_occupation"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Designation.: ",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Annual Income.: ${student["father_annual_income"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Aadhar No.: ${student["father_aadhar_no"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      "Mother/Gaurdian: ",
                      style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Name: ${student["mother_name"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Date of Birth: ",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Educational Qualification: ${student["mother_edu_qualification"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Occupation: ${student["mother_occupation"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Designation.: ",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Annual Income.: ${student["mother_annual_income"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Aadhar No.: ${student["mother_aadhar_no"].toString().toUpperCase()}",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                  ])),
              pw.SizedBox(height: 60),
              pw.Text(
                "I hearby clerify that the information given in the admission form is complete and accurate. I understand and agree this misrepresentation or omission of facts will justify the denial of admission, the cancellatin of admission or expulsion and I will deposit my outstanding fees within two installments, School will be not responsible for any accidents while coming to school.\n\n I have read and do hereby consent to the term and conditions of the institute.",
                style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
              ),
              pw.SizedBox(height: 50),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "Signature of Mother",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.Text(
                      "Signature of Father",
                      style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
                    ),
                    pw.Text(
                      "Head Of the Institution",
                      style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold),
                    ),
                  ])
            ])),
  ));
  // final String dir = (await getApplicationDocumentsDirectory()).path;
  // final String path = '$dir/report.pdf';
  // final File file = File(path);
  // await file.writeAsBytes((await pdf.save()));
  pd.close();
  String docName =
      "${student["student_name"].toString().toUpperCase()}-${student["dob"].toString()}-YNV-Application-Form.pdf";
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ViewForm(path: pdf, docName: docName),
    ),
  );
}

pw.Widget divider(double width) {
  return pw.Container(
    height: 3,
    width: width,
    decoration: pw.BoxDecoration(
      color: PdfColors.grey,
    ),
  );
}

tableRow(List<String> attributes, pw.TextStyle textStyle) {
  return pw.TableRow(
    children: attributes
        .map(
          (e) => pw.Text(
            "  " + e,
            style: textStyle,
          ),
        )
        .toList(),
  );
}

pw.Widget textRow(List<String> titleList, pw.TextStyle textStyle) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: titleList
        .map(
          (e) => pw.Text(
            e,
            style: textStyle,
          ),
        )
        .toList(),
  );
}

pw.TextStyle textStyle1() {
  return pw.TextStyle(
    color: PdfColors.grey800,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
}

pw.TextStyle textStyle2() {
  return pw.TextStyle(
    color: PdfColors.grey,
    fontSize: 22,
  );
}

pw.Widget spaceDivider(double height) {
  return pw.SizedBox(height: height);
}
