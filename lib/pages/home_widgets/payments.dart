import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class Payments extends StatelessWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyTheme.myGrey2,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PATMENTS",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: MyTheme.myBlack),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    print("Phone pe");
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Image.asset(
                            "assets/images/Phone-pe-logo.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "Phone Pe",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: MyTheme.myBlack),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("Google pay");
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Image.asset(
                            "assets/images/Google-Pay-logo.png",
                          ),
                        ),
                      ),
                      Text(
                        "Google Pay",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: MyTheme.myBlack),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("Paytm");
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Image.asset(
                            "assets/images/Paytm-Logo.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        "Paytm",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: MyTheme.myBlack),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
