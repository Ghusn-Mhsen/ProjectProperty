import 'package:flutter/material.dart';
import 'package:project_property/page/Data/buttonData.dart';
import 'package:project_property/user/color/color.dart';


class SliderButton extends StatefulWidget {
  @override
  _SliderButtonState createState() => _SliderButtonState();
}

class _SliderButtonState extends State<SliderButton> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 30.0, top: 10, bottom: 30),
      child: Container(
        height: size.height * 0.06,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: btnInfo.length,
            itemBuilder: (context, index) {
              return button(context, index);
            }),
      ),
    );
  }

  Widget button(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: size.width * 0.26,
            decoration: BoxDecoration(
              color: selected == index ? darkBlue : Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text(btnInfo[index],style: TextStyle(
              color: selected == index ?white :black,fontWeight: FontWeight.bold),
            )
            ),
          ),
        ),
      ),
    );
  }
}
