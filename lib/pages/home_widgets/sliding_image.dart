import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yugnirmanvidyalaya/widgets/theme.dart';

class SlidingImage extends StatefulWidget {
  final List<String> images;
  const SlidingImage({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<SlidingImage> createState() => _SlidingImageState();
}

class _SlidingImageState extends State<SlidingImage> {
  int _pos = 0;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (Timer t) {
      if (!mounted) return;
      setState(() {
        _pos = (_pos + 1) % widget.images.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyTheme.myGrey,
          borderRadius: BorderRadius.all(Radius.circular(9))),
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        child: Image.network(
          widget.images[_pos],
          height: 180,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
