import 'package:flutter/material.dart';
import 'package:project_property/user/color/color.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  String text="";
  var onClick;
  ButtonWidget({this.text,this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onClick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangeColors, orangeLightColors],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}




