import 'package:flutter/material.dart';
import 'package:project_property/user/color/color.dart';

class HeaderText extends StatelessWidget { // ignore: must_be_immutable
  String txt=" ";
  HeaderText({this.txt});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangeColors, orangeLightColors],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                txt,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Center(
            child: Image.asset('images/logo1.png'),
          ),
        ],
      ),
    );
  }
}
