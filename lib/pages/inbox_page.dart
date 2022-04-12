import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Yug Nirman'),
            Text(
              "Inbox",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: Center(child: Text("This feature is currently not available")),
    );
  }
}
