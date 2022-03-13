import 'package:flutter/material.dart';
import 'package:project_property/page/Data/propertylist.dart';


class HouseInfo extends StatefulWidget {
 var house;

  HouseInfo({this.house});

  @override
  _HouseInfoState createState() => _HouseInfoState();
}

class _HouseInfoState extends State<HouseInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35, 20, 20, 5),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Text(
              widget.house['descreptionn'],
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(0.6),
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
