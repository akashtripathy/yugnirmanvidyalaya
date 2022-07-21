import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:yugnirmanvidyalaya/pages/view_form.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

generateStudentId(context, final student) async {
  ProgressDialog pd = ProgressDialog(context: context);
  pd.show(
      max: 100,
      msg: 'Creating Document...',
      progressBgColor: MyTheme.myBlack,
      backgroundColor: MyTheme.myBlack2);
  final Document pdf = Document(compress: true);
  final logo = await networkImage(
      'https://yugnirmanvidyalaya.in/img/Yug%20Nirman%20Logo%20PNG.png');
  final sign = await imageFromAssetBundle('assets/images/YNV Sign.png');
  final idCard = await imageFromAssetBundle('assets/images/YNV-ID-CARD.png');
  final stuProfilePic = await networkImage(student["image"]);
  final address = await extractAddress(student["address"]);
  pdf.addPage(pw.Page(
      margin: pw.EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      pageFormat: PdfPageFormat.a4,
      orientation: PageOrientation.natural,
      build: (context) => pw.Container(
              child: pw.Stack(children: [
            pw.Image(idCard),
            pw.Container(
              margin: pw.EdgeInsets.fromLTRB(80, 132, 0, 0),
              height: 100,
              width: 90,
              decoration: pw.BoxDecoration(
                  // color: MyTheme.myGrey2,
                  image: pw.DecorationImage(
                      image: stuProfilePic, fit: pw.BoxFit.cover),
                  borderRadius: pw.BorderRadius.all(Radius.circular(8)),
                  border: pw.Border.all(
                      color: PdfColor.fromHex('#000000'), width: 2)),
            ),
            pw.Container(
                // padding: pw.EdgeInsets.fromLTRB(200, 25, 0, 0),
                margin: pw.EdgeInsets.fromLTRB(170, 120, 0, 0),
                width: 400,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "${student["student_name"].toString().toUpperCase()}",
                        style: pw.TextStyle(
                            fontSize: 26,
                            color: PdfColors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "FATHER'S NAME: ${student["father_name"].toString().toUpperCase()}",
                              style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              "DOB: ${student["dob"].toString()}\t\t BLOOD GROUP: ${student["blood_group"].toString().toUpperCase()}",
                              style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              "PHONE: +91 ${student["phone_no"].toString().toUpperCase()}",
                              style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              "ADDRESS: ${address.toUpperCase()}",
                              style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ])
                    ])),
          ]))));
  pd.close();
  String docName =
      "${student["student_name"].toString().toUpperCase()}-${student["dob"].toString()}-YNV-Identity-Card.pdf";
  await for (var page in Printing.raster(await pdf.save(), dpi: 72)) {
    final image = page.toImage(); // ...or page.toPng()
    print(image.toString());
  }
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ViewForm(path: pdf, docName: docName),
    ),
  );
}

extractAddress(final address) {
  final newAddress = address.split(",");
  final newAddress1 = newAddress[0].indexOf('-');
  if (newAddress1 != -1) return newAddress[0].substring(newAddress1 + 1).trim();
}


// pw.Container(
//           // width: 800,
//           height: 356,
//           decoration: pw.BoxDecoration(
//               borderRadius: pw.BorderRadius.all(Radius.circular(10)),
//               border:
//                   pw.Border.all(color: PdfColor.fromHex('#ffeb3b'), width: 3)),
//           child: pw.Column(children: [
//             pw.Container(
//                 alignment: pw.Alignment.center,
//                 decoration: pw.BoxDecoration(
//                   borderRadius: pw.BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10)),
//                   color: PdfColor.fromHex("#ffeb3b"),
//                 ),
//                 padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 40),
//                 child: pw.Row(children: [
//                   pw.Image(logo, width: 90),
//                   pw.SizedBox(width: 20),
//                   pw.Column(children: [
//                     pw.Text(
//                       "YUGNIRMAN VIDYALAYA",
//                       style: pw.TextStyle(
//                           fontSize: 25,
//                           color: PdfColors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     pw.Text(
//                       "CBSE ENGLISH MEDIUM",
//                       style: pw.TextStyle(
//                           fontSize: 18,
//                           color: PdfColors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ]),
//                 ])),
//             pw.SizedBox(height: 10),
//             pw.Text(
//               "IDENTITY CARD",
//               style: pw.TextStyle(
//                   fontSize: 16,
//                   color: PdfColors.black,
//                   fontWeight: FontWeight.bold),
//             ),
//             pw.SizedBox(height: 10),
//             pw.Container(
//                 padding: pw.EdgeInsets.symmetric(horizontal: 25),
//                 child: pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.start,
//                     children: [
//                       pw.Container(
//                         height: 120,
//                         width: 110,
//                         decoration: pw.BoxDecoration(
//                             // color: MyTheme.myGrey2,
//                             image: pw.DecorationImage(
//                                 image: stuProfilePic, fit: pw.BoxFit.cover),
//                             borderRadius:
//                                 pw.BorderRadius.all(Radius.circular(5)),
//                             border: pw.Border.all(
//                                 color: PdfColor.fromHex('#000000'))),
//                       ),
//                       pw.SizedBox(width: 30),
//                       pw.Column(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           children: [
//                             pw.Text(
//                               "NAME: ${student["student_name"].toString().toUpperCase()}",
//                               style: pw.TextStyle(
//                                   fontSize: 18,
//                                   color: PdfColors.black,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Text(
//                               "DOB: ${student["dob"].toString()}",
//                               style: pw.TextStyle(
//                                   fontSize: 18,
//                                   color: PdfColors.black,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Text(
//                               "BLOOD GROUP: ${student["blood_group"].toString().toUpperCase()}",
//                               style: pw.TextStyle(
//                                   fontSize: 18,
//                                   color: PdfColors.black,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Text(
//                               "PHONE: +91 ${student["phone_no"].toString().toUpperCase()}",
//                               style: pw.TextStyle(
//                                   fontSize: 18,
//                                   color: PdfColors.black,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             pw.SizedBox(height: 5),
//                             pw.Text(
//                               "ADDRESS: ${address.toUpperCase()}",
//                               style: pw.TextStyle(
//                                   fontSize: 18,
//                                   color: PdfColors.black,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ])
//                     ])),
//             pw.Container(
//                 alignment: pw.Alignment.bottomRight,
//                 padding: pw.EdgeInsets.fromLTRB(0, 0, 10, 0),
//                 child: pw.Column(children: [
//                   pw.Image(sign, height: 30),
//                   pw.Text(
//                     "PRINCIPAL",
//                     style: pw.TextStyle(
//                         fontSize: 16,
//                         color: PdfColors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ])),
//             pw.SizedBox(height: 10),
//             pw.Container(
//                 alignment: pw.Alignment.center,
//                 decoration: pw.BoxDecoration(
//                   borderRadius: pw.BorderRadius.only(
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10)),
//                   color: PdfColor.fromHex("#ffeb3b"),
//                 ),
//                 padding: pw.EdgeInsets.symmetric(vertical: 10, horizontal: 40),
//                 child: pw.Row(children: [
//                   pw.Text(
//                     "Near MGP College, Nua Sarsara and Near Barhagoda Canel Chowk",
//                     style: pw.TextStyle(
//                         fontSize: 16,
//                         color: PdfColors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ])),
//             pw.SizedBox(height: 10),
//           ]))