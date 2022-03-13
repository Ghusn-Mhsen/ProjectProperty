import 'package:flutter/material.dart';
import 'package:project_property/user/color/color.dart';


// ignore: must_be_immutable
class ButtonBottom extends StatefulWidget {
  var icon,function;
  String txt;
  ButtonBottom({this.icon,this.function,this.txt});
  @override
  _ButtonBottomState createState() => _ButtonBottomState();
}

class _ButtonBottomState extends State<ButtonBottom> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.function,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: size.width * 0.4,
          height: 60,
          decoration: BoxDecoration(
            color: darkBlue,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.6),
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
               widget.icon,
                size: 30,color: white,
              ),
              SizedBox(width: 7),
              Text(
                widget.txt,
                style: TextStyle(fontWeight: FontWeight.w600, color: white,fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }
}
