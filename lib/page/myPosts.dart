import 'dart:core';


import 'package:flutter/material.dart';
import 'package:project_property/Admin/adminScreen.dart';
import 'package:project_property/newProperty/addNewHome.dart';
import 'package:project_property/ofline_storage/shared_preference.dart';
import 'package:project_property/page/component/Shearch/Search.dart';
import 'package:project_property/user/color/color.dart';
import 'package:project_property/user/login.dart';
import 'package:project_property/user/registration.dart';
import 'package:project_property/user/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../drawers.dart';
import 'Home.dart';
import 'component/home/ButtonBottom.dart';
import 'component/home/appbar.dart';
import 'component/home/property.dart';

import 'component/home/sliderButton.dart';
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

class myPosts extends StatefulWidget {

  static List filter;
  @override
  _myPostsState createState() => _myPostsState();
}

class _myPostsState extends State<myPosts> {

  var id;


  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");


    });

  }
  Future getProperty() async {
    try {
      var data = {
        "iduser": this.id,


      };

      var url = "https://propertymanagment.000webhostapp.com/myposts.php";
      var response = await http.post(Uri.parse(url), body: data);




      return json.decode(response.body);
    } catch (e) {
    //  print("can't upload");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
getData();
getProperty();

   // getProperty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       // drawer:Drawers(),
        backgroundColor: white,
        appBar: null,
        body: FutureBuilder(
          future: getProperty(),

          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
             myPosts.filter = snapshot.data;
             if(  myPosts.filter.isEmpty)
               return Text("المحتوى فارغ وشكراً");
             else{
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      CreateAppBar(label:"my posts"),
                   //   SliderButton(),
                      Property(list: myPosts.filter,icon: Icons.edit,),
                    ],
                  ),
                  ButtonBottom(
                    icon: Icons.home,
                    function: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>Home()));
                    },
                    txt: "Home",
                  ),
                ],
              );}
            } else if (snapshot.hasError)
              return Text("Sorry,there is an Error");
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

}