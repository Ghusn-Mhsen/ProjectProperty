import 'package:flutter/material.dart';
import 'package:project_property/page/Data/propertylist.dart';
import 'package:project_property/user/color/color.dart';

class  ListButton extends StatefulWidget {
 var house;
  ListButton({this.house});
  @override
  _ListButtonState createState() => _ListButtonState();
}

class _ListButtonState extends State<ListButton> {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: size.height * 0.12,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return button(context, index);
            }),
      ),
    );
  }
  Widget button(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;

    return  Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: size.width * 0.24,
            decoration: BoxDecoration(
              border:Border.all(color: black,width: 1),
              color: Colors.white70.withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(child: Text('      ${5}\nbathrooms',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
        ),
      );
  }
}

