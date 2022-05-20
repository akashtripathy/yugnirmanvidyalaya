import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class ViewPdf extends StatefulWidget {
  final path;
  final page;
  const ViewPdf({Key? key, this.path, this.page}) : super(key: key);

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.myBlack,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MyTheme.myWhite,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.page,
          style: TextStyle(color: MyTheme.myWhite),
        ),
      ),
      body: widget.path != null
          ? Container(child: SfPdfViewer.network(widget.path))
          : Container(),
    );
  }
}
