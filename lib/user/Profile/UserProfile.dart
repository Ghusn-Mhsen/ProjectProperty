import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_property/page/Home.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../registration.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var _email, _lastName, _firstName;




  @override
  void initState() {
    super.initState();

    getUserInformation();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Home()));
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 40,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegPage()));
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 40,
                          )),
                    ),
                  ],
                ),
                width: size.width,
                height: size.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/image/indoor1.jpg',
                        ),
                        fit: BoxFit.cover)
                    // borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(40)),
                    ),
              ),
              SizedBox(
                height: 100,
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(

                      // borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(40)),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.3),
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          "     $_firstName $_lastName   ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.3),
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          "$_email ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            width: 190,
            height: 190,
            top: size.height / 2.8,
            left: size.width / 4,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/image/images/house1.jpeg'),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new ListTile(
                        leading: new Icon(Icons.camera),
                        title: new Text('Camera'),
                        onTap: () {


                          // this is how you dismiss the modal bottom sheet after making a choice
                          Navigator.pop(context);
                        },
                      ),
                      new ListTile(
                        leading: new Icon(Icons.image),
                        title: new Text('Gallery'),
                        onTap: () {

                          // dismiss the modal sheet
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Future<void>  getUserInformation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _firstName = pref.getString("firstName")??"000";
      _lastName = pref.getString("lastName")??"000";
      _email = pref.getString("email")??"000";
    });
  }
}
