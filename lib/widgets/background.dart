import 'dart:async';
import 'package:flutter/material.dart';

class BodyBackground extends StatefulWidget {
  final Widget child;

  const BodyBackground({Key? key, required this.child}) : super(key: key);

  @override
  _BodyBackgroundState createState() => _BodyBackgroundState();
}

class _BodyBackgroundState extends State<BodyBackground>
    with TickerProviderStateMixin {
  late List<Color> colorList;
  late List<Alignment> alignmentList;
  int index = 0;
  late Color bottomColor;
  late Color topColor;
  late Alignment begin;
  late Alignment end;

  @override
  void initState() {
    super.initState();
    colorList = [
      Color.fromARGB(255, 214, 215, 221),
      Color.fromARGB(255, 194, 192, 196),
      Color.fromARGB(255, 188, 198, 207),
      Color.fromARGB(255, 241, 241, 242),
      Color.fromARGB(255, 217, 214, 219),
    ];
    alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
    bottomColor = Color(0xff092646);
    topColor = Color(0xff410D75);
    begin = Alignment.bottomCenter;
    end = Alignment.topCenter;

    Timer(Duration(microseconds: 0), () {
      setState(() {
        bottomColor = Color(0xff33267C);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 2),
          onEnd: () {
            setState(() {
              index = index + 1;
              bottomColor = colorList[index % colorList.length];
              topColor = colorList[(index + 1) % colorList.length];
            });
          },
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: [bottomColor, topColor],
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}
