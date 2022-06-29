import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class ViewForm extends StatefulWidget {
  final path;
  final docName;
  const ViewForm({Key? key, this.path, this.docName}) : super(key: key);

  @override
  State<ViewForm> createState() => _ViewFormState();
}

class _ViewFormState extends State<ViewForm> {
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
          widget.docName,
          style: TextStyle(color: MyTheme.myWhite),
        ),
      ),
      body: widget.path != null
          ? PdfPreview(
              build: (format) => widget.path.save(),
              pdfFileName: widget.docName,
            )
          : Container(),
    );
  }
}
