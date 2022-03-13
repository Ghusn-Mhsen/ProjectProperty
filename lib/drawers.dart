import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:project_property/Admin/adminScreen.dart';
import 'package:project_property/newProperty/addNewHome.dart';
import 'package:project_property/user/login.dart';
import 'package:project_property/user/registration.dart';
import 'package:project_property/user/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ofline_storage/shared_preference.dart';

class Drawers extends StatefulWidget {
  @override
  _DrawersState createState() => _DrawersState();
}

var iduser;

class _DrawersState extends State<Drawers> {
/*Future<int> getData() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      iduser = pref.getString("id");

    }
    );
  }*/
  /* Future<Post> getByPostId() async {
//    String url = 'https://jsonplaceholder.typicode.com/posts/1';
    http.Response futuerPost = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (futuerPost.statusCode == 200) {
      print(futuerPost.body);
      print('fdggfddfgdfgdgffgdfgd');
      return null;
    } else {
      throw Exception('ERROR');
    }
  }
*/
  var scaf = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return

      Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.deepOrange,
                    Colors.orangeAccent,
                  ],
                ),
              ),
              child:SingleChildScrollView
                (
                child: Container(

                  child: SingleChildScrollView(
                    child: Row(

                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 80,
                              height: 80,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                  'images/logo1.png',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(9.0, 0, 9.0, 0),
                            ),
                            Text(
                              'Mohammed Alkhateeb',
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              'mohammadalkhteb880@gmail.com',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                              width: 240,
                            ),
                          ],

                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomListTile(Icons.add_business, 'إضافة عقار', (){

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>addNewHome()));}),
            CustomListTile(Icons.admin_panel_settings, 'Control panal', (){

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>adminScreen()));}),
            CustomListTile(Icons.nightlight_round, 'الوضع الليلي', () {}),
            CustomListTile(Icons.edit, 'تعديل معلومات الحساب', (){

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>RegPage()));}),
            CustomListTile(Icons.delete_forever, 'حذف الحساب',(){
              StorageState.removeData();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>LogPage(type:true)));

            }),


            CustomListTile(Icons.logout, 'تسجيل الخروج',(){

              StorageState.removeData();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>SplashPage()));}),
          ],
        ),
      );
  }


}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
 var onTap;
  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(9.0, 0, 9.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        child: InkWell(
           splashColor: Colors.orangeAccent,
          onTap: this.onTap,

          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

