import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_property/page/Home.dart';
import 'package:http/http.dart' as http;
import '../../myPosts.dart';


class CreateAppBar extends StatelessWidget {
var label;
CreateAppBar({this.label});

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 20),
      child: Container(
        height: size.height * 0.26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon:Icon(Icons.sort_rounded), onPressed: () {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) =>myPosts()));}),

                IconButton(
                    icon:Icon(Icons.refresh_rounded), onPressed: () {
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) =>Home()));           //      Home.download+=25;
                    })
            //    icon(Icons.insights_rounded),
              ],
            ),
            SizedBox(height: 20,),
            Text("Property App",style: TextStyle(color:Colors.grey,fontSize: 18,),),
            SizedBox(height: 10,),
            Text(label,style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),),
            SizedBox(height: 30,),
            Divider(height: 4,color:Colors.grey,),
          ],
        ),

      ),
    ) ;
  }
  Widget icon(var icon)
  {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color:Colors.black.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon),
    );
  }
}