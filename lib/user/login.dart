import 'package:flutter/material.dart';

import 'package:project_property/ofline_storage/shared_preference.dart';
import 'package:project_property/page/Home.dart';
import 'package:project_property/user/splash_screen.dart';
import 'package:project_property/user/validate/inputUser.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'component/ButtonClick.dart';
import 'component/formField.dart';
import 'component/header.dart';
import 'component/richText.dart';
import 'forget_pass.dart';

class LogPage extends StatefulWidget {
  bool type;

  LogPage({this.type});

  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  var pass = TextEditingController();
  var mail = TextEditingController();
  var iduser;
  final formKey = GlobalKey<FormState>();

  var scaf = GlobalKey<ScaffoldState>();
  var id, firstName, lastName, email;

  void setData(String id, String firstName, String lastName, String email,
      String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("id", id);
    pref.setString("firstName", firstName);
    pref.setString("lastName", lastName);
    pref.setString("email", email);
    pref.setString("token", token);
  }

  @override
  void initState() {
    getId();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaf,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height + 130,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                HeaderText(txt: "Login"),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              TextInput(
                                  controller: mail,
                                  hint: "Email",
                                  icon: Icons.email,
                                  valid: Check.checkMail),
                              TextInput(
                                  controller: pass,
                                  hint: "Password",
                                  icon: Icons.vpn_key,
                                  valid: Check.checkPass),
                              Container(
                                margin: EdgeInsets.only(top: 30.0),
                                child: Center(
                                  child: ButtonWidget(
                                    text: "Login",
                                    onClick: () async {
                                      if (formKey.currentState.validate()) {
                                        print("Valid ");
                                        print(widget.type);
                                        var req = await loginrUser();
                                        if (req['msg'] == "true") {
                                          if (widget.type == false) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()));
                                          } else {
                                            var del = await deleteAccount();

                                            if (del == "Data Deleted") {
                                              StorageState.removeData();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SplashPage()));
                                            }
                                          }
                                        }
                                      } else {
                                        print("Not Valid");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              RichTxt(
                                strOne: "",
                                strTwo: "Forget Password",
                                onClick: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ForgetPass()));
                                },
                              ),
                              RichTxt(
                                strOne: "",
                                strTwo: "Back",
                                onClick: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  loginrUser() async {
    var data = {'email': mail.text, 'password': pass.text};
    try {
      var url = "https://10.0.2.2/myproject/sing/login.php";
      var response = await http.post(Uri.parse(url), body: data);
      var req = jsonDecode(response.body);
      print(req);
      if (response.statusCode == 200) {
        if (req['msg'] == "true") {
          StorageState.removeData();
          setData(req["id"], req["first_name"], req["last_name"], req["email"],req['token']);

          showResult('account already exists');
        } else if(req['msg'] == "incorrect email") {
          showResult('email not found, Please Create new account');
        }
        else{
          showResult('password not found, Please Create new account');
        }
      }
      return req;
    } catch (e) {
      print(e.toString());
    }
  }
  // loginrUser() async {
  //   var data = {"email": mail.text, "password": pass.text};
  //   try {
  //     var url = "https://propertymanagment.000webhostapp.com/login.php";
  //     var response = await http.post(Uri.parse(url), body: data);
  //     var req = jsonDecode(response.body);
  //     print(req);
  //     if (response.statusCode == 200) {
  //       if (req['msg'] == "true") {
  //         StorageState.removeData();
  //         setData(req["id"], req["first_name"], req["last_name"], req["email"],
  //             req["token"]);
  //
  //         showResult('account already exists');
  //       } else {
  //         showResult('account not found, Please Create new account');
  //       }
  //     }
  //     return req;
  //   } catch (e) {}
  // }

  deleteAccount() async {
    var data = {"id": iduser};
    print("id is : ");
    print(data["id"]);
    try {
      var url = "https://propertymanagment.000webhostapp.com/DeleteData.php";

      var response = await http.post(Uri.parse(url), body: data);

      var req = response.body;

      if (response.statusCode == 200) {
        if (req == "Data Deleted")
          //  showResult('account deleted successfully!');
          showResult('account deleted successfully!');
      } else {
        showResult('error in delete account');
      }
      return req;
    } catch (e) {}
  }

  Future<int> getId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      iduser = pref.getString("id");
    });
  }

  void showResult(String msg) {
    // ignore: deprecated_member_use
    scaf.currentState.showSnackBar(
      SnackBar(
        content: Text(msg, textAlign: TextAlign.center),
      ),
    );
  }
}
