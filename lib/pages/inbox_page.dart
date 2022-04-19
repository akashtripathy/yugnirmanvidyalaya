import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.myBlack,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Yug Nirman',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Inbox",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Center(child: Text("This feature is currently not available")),
    );
  }
}
