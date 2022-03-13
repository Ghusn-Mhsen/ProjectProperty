import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:project_property/page/Home.dart';
import 'package:http/http.dart' as http;
import 'package:project_property/user/confirmNewPass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinEntry extends StatefulWidget {
  final keyy;
  final type;
  final fName;
  final lName;

  final mail;
  final userName;
  final pass;
 PinEntry({this.keyy,this.type,this.mail,this.userName,this.fName,this.lName,this.pass});
  @override
  _PinEntryState createState() => _PinEntryState();
}

class _PinEntryState extends State<PinEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PinEntryTextField(
          fieldWidth: 60.0,
          fontSize: 20.0,
          onSubmit: (String pin){
            if(widget.type == true)
              {

                if(widget.keyy.toString() == pin)
                {

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConfirmPass(userName: widget.userName,mail: widget.mail,)));
                }
              }else
                {
                  if(widget.keyy.toString() == pin)
                  {
                    print("kkkkkkk");
                    var req = registerUser();
                    //print(req);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Home()));
                  }
                }

            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Pin"),
                    content: Text('Pin entered is $pin'),
                  );
                }
            ); //end showDialog()

          }, // end onSubmit
        ),
      ),
    );
  }
  registerUser() async {
    var data = {
      "first_name": widget.fName.toString(),
      "last_name": widget.lName.toString(),
      "username": widget.userName.toString(),
      "email": widget.mail.toString(),
      "password": widget.pass.toString(),
    };

    try {
      var url = "https://propertymanagment.000webhostapp.com/register.php";
      var response = await http.post(Uri.parse(url), body: data);
      var req = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (req['msg'] == "account already exists") {
        //  showResult('account already exists, Please login');
        } else {
          if (req['msg'] == "true") {
            setData(req["id"], req["first_name"], req["last_name"], req["email"],req['token']);

          }
        }
      }
      print(req);
      return req;
    } catch (e) {
      print(e.toString());
    }
  }

  void setData(String id, String firstName, String lastName, String email,String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("id", id);
    pref.setString("firstName", firstName);
    pref.setString("lastName", lastName);
    pref.setString("email", email);
    pref.setString("token", token);


  }
}
