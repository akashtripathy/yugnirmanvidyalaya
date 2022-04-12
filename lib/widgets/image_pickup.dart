import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class ImagePickup extends StatefulWidget {
  final ValueChanged<String> parentAction;
  const ImagePickup({Key? key, required this.parentAction}) : super(key: key);

  @override
  State<ImagePickup> createState() => _ImagePickupState();
}

class _ImagePickupState extends State<ImagePickup> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future cameraImage() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 12);
    setState(() {
      if (photo != null) {
        _image = File(photo.path);
        widget.parentAction(photo.path);
      }
    });
  }

  Future galleryImage() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 12);
    setState(() {
      if (photo != null) {
        _image = File(photo.path);
        widget.parentAction(photo.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      width: size.width,
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: 100,
          height: 110,
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              color: MyTheme.myBlack2,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: _image == null
                  ? DecorationImage(
                      image: AssetImage('assets/images/avatar.png'))
                  : DecorationImage(
                      image: FileImage(_image!), fit: BoxFit.fill)),

          // child: ClipRRect(
          //   borderRadius: BorderRadius.all(Radius.circular(10)),
          //   child: FileImage(_image),
          // ),
        ),
        Container(
          width: 160,
          height: 100,
          child: IconButton(
              onPressed: () {
                chooseImage(context);
              },
              icon: Icon(
                Icons.add_a_photo,
                color: MyTheme.myWhite.withOpacity(0.5),
                size: 70,
              )),
        ),
      ]),
    );
  }

  chooseImage(context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 190,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    galleryImage();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    child: Text(
                      'Gallery',
                      style: TextStyle(fontSize: 16, color: MyTheme.myBlack),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cameraImage();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    margin: EdgeInsets.only(top: 1),
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Text(
                      'Camera',
                      style: TextStyle(fontSize: 16, color: MyTheme.myBlack),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: MyTheme.myBlack2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
