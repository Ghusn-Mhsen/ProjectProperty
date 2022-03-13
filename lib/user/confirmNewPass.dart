import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_property/page/Home.dart';
import 'package:project_property/user/validate/inputUser.dart';
import 'component/ButtonClick.dart';
import 'component/formField.dart';
import 'component/header.dart';
import 'component/richText.dart';
import 'registration.dart';
class ConfirmPass extends StatefulWidget {
  final userName;
  final mail;
  ConfirmPass({this.userName,this.mail});
  @override
  _ConfirmPassState createState() => _ConfirmPassState();
}

class _ConfirmPassState extends State<ConfirmPass> {
  var pass = TextEditingController();



  final formKey = GlobalKey<FormState>();

  var scaf = GlobalKey<ScaffoldState>();




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
                HeaderText(txt: "forgeet Pass"),
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
                                  controller: pass,
                                  hint: "New Password",
                                  icon: Icons.vpn_key,
                                  valid: Check.checkPass),
                              Container(
                                margin: EdgeInsets.only(top: 30.0),
                                child: Center(
                                  child: ButtonWidget(
                                    text: "CONFIRM",
                                    onClick: () async{
                                      if (formKey.currentState.validate()) {
                                        print("Valid ");
                                        var req=  await forgetPass2();
                                        if (req== "true")
                                        {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => Home()));

                                        }


                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //     builder: (context) => Home()));
                                      } else {
                                        print("Not Valid");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              RichTxt(
                                strOne: "A New member ? ",
                                strTwo: "create account ",
                                onClick: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RegPage()));
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

  forgetPass2() async {
    var data = {
      "username":widget.userName.toString(),
      "email": widget.mail.toString(),
      "pass" : pass.text,
    };
    print(data);
    try {
      var url = "https://propertymanagment.000webhostapp.com/forgetpassNew.php";
      var response = await http.post(Uri.parse(url), body: data);
   print(response.body);
      var req = jsonDecode(response.body);
      print("lllll");
      print(req);

      if (response.statusCode == 200) {
        if (req == "true") {
          showResult('Change Password Successfully');
        } else if (req == "false") {
          showResult('Error in change Password');
        } else {
          showResult('account not found, Please Create new account');
        }
      }

      return req;
    } catch (e) {}
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
