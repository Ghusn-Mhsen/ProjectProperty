import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_property/ofline_storage/shared_preference.dart';
import 'package:project_property/page/Home.dart';
import 'package:project_property/user/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'color/color.dart';

class SplashPage extends StatefulWidget {


  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var id ;
  var firstName ;
  var lastName ;
  var email ;
  @override
  void initState() {
    getData();

    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: GestureDetector(
          onTap: () {

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>check()? Home() : RegPage()));
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [orangeColors, orangeLightColors],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter),
            ),
            child: Center(
              child: Image.asset('images/logo1.png'),
            ),
          ),
        ),
      ),
    );
  }

 getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      firstName = pref.getString("firstName");
      lastName = pref.getString("lastName");
      email = pref.getString("email");
     // StorageState.removeData();


    });

  }

  bool check() {

    if (id == null|| firstName==null  ||lastName==null || email==null)
     { return false;}
    else
      return true;
  }
}
