import 'package:flutter/material.dart';
import 'package:project_property/newProperty/addNewHome.dart';
import 'package:project_property/page/Data/propertylist.dart';
import 'package:project_property/page/Home.dart';
import 'package:project_property/user/color/color.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:project_property/API.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project_property/propertydetails/property.dart';

import 'package:project_property/Basic Ui/PropertyDetail.dart';
import 'package:project_property/Admin/PropertyDetailAdmin.dart';


import '../../Details.dart';

class Property extends StatefulWidget {
var list;
var icon;
var fun;

  Property( {this.list,this.icon,this.fun});
  @override
  _PropertyState createState() => _PropertyState();
}


class _PropertyState extends State<Property> {

  @override
  Widget build(BuildContext context) {
    //print(widget.list);
    return Expanded(
        child: ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        if(widget.list.length!=0)
        return propertyItem(index);
      },
    ));
  }

  Widget propertyItem(int index) {
    Size size = MediaQuery.of(context).size;
          if(index==0)
            return Center(
              child: Text(""),
            );
          else{
    var hhouse = widget.list[index];

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsPage(house: hhouse,icon: this.widget.icon,fun: (){ Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>Home()));})));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Container(
          height: 300,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      height: 210,
                      width: size.width,
                      fit: BoxFit.cover,
                      image:  NetworkImage("https://propertymanagment.000webhostapp.com/uploads/${hhouse['imagee']}"),
                    ),
                  ),

                  Positioned(
                    right: size.width/30,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(

                        color: white,
                        icon: true
                            ? Icon(
                               this.widget.icon,
                                color: red,
                          size: 30,
                              )
                            : Icon(
                                Icons.favorite_border_rounded,
                                color: black,
                          size: 30,
                              ),
                        onPressed: () {
                          this.widget.icon==Icons.favorite? setState(() {
                            // house.isFav = !house.isFav;

                          }):(){};

                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('\$${hhouse['price']}',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Text('${hhouse['llocation']}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                    ),),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('\$ 3 bedrooms / ',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ),),
                  //SizedBox(width: 20,),
                  Expanded(
                    child: Text('\$ 3 bathrooms/',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                      fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ),),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );}
  }

}
