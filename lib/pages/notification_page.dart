import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/utils/PushNotification.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class NotificationPage extends StatefulWidget {
  PushNotification? notificationInfo;
  NotificationPage({Key? key, this.notificationInfo}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  PushNotification? _notificationInfo;
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
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: widget.notificationInfo != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.myGrey2,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.notificationInfo!.title},\n\n${widget.notificationInfo!.body}",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Container(
                child: Text("No new notification"),
              ),
      ),
    );
  }
}
