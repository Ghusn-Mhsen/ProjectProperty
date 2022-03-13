import 'package:flutter/material.dart';
import 'package:project_property/user/color/color.dart';


// ignore: must_be_immutable
class RichTxt extends StatelessWidget {
  String strOne = "";
  String strTwo = "";
  var onClick;

  RichTxt({this.onClick, this.strOne, this.strTwo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: strOne,
                style: TextStyle(color: Colors.black)),

            TextSpan(
                text: strTwo,
                style: TextStyle(color: orangeColors)),

          ]),
        ),
      ),
    );
  }
}

