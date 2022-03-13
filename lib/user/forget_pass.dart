import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_property/user/Pin_entry.dart';
import 'package:project_property/user/validate/inputUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/ButtonClick.dart';
import 'component/formField.dart';
import 'component/header.dart';
import 'component/richText.dart';
import 'registration.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {

  var mail = TextEditingController();

  var userName = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var scaf = GlobalKey<ScaffoldState>();
  var _token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserToken();
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
                                  controller: userName,
                                  hint: "UserName",
                                  icon: Icons.person,
                                  valid: Check.checkName),
                              TextInput(
                                  controller: mail,
                                  hint: "Email",
                                  icon: Icons.email,
                                  valid: Check.checkMail),
                              Container(
                                margin: EdgeInsets.only(top: 30.0),
                                child: Center(
                                  child: ButtonWidget(
                                    text: "CONFIRM",
                                    onClick: () async{
                                      if (formKey.currentState.validate()) {
                                        print("Valid ");
                                       var req=  await forgetPassUser();
                                        if (req['msg'] == "true")
                                          {
                                            sendMailer(req['key']);
                                             Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => PinEntry(keyy:req['key'],type:true,mail:mail.text,userName: userName.text,)));

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

   forgetPassUser() async {
    var data = {
      "username": userName.text,
      "email": mail.text,


    };
    //print(data);
    try {
      var url = "https://propertymanagment.000webhostapp.com/forgetpass.php";
      var response = await http.post(Uri.parse(url), body: data);
      var req = jsonDecode(response.body);
      print(req);

      if (response.statusCode == 200) {
        // if (req['msg'] == "true") {
        //   showResult('Change Password Successfully');
        // } else if (req == "false") {
        //   showResult('Error in change Password');
        // } else {
        //   showResult('account not found, Please Create new account');
        // }
     }
      return req;
    } catch (e) {}
  }
  Future<void> sendEmails() async {
   final serviceId  ='service_lwaee6n';
   final templateId ='template_bpt3hyj';
   final userId     ='user_QCW2T9m3VF4pXNdFUDPwM';
    try {
      var url = "https://api.emailjs.com/api/v1.0/email/send";
      var response = await http.post(Uri.parse(url), headers: {
      //  'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
          body:{
        'service_id': serviceId,
        'template_id':templateId,
        'user_id':userId,
            'template_params':{
          'user_name': 'Ghassn Mh',
          'user_email':'‪developertest836@gmail.com‬‏',
          'user_subject':'new password',
          'user_message':'this is new password 12345'
            }
      });

    } catch (e) {}
  }


  sendMailer(var value) async {
    String username = 'developerTest836@gmail.com';
    String password = 'forlooppoolrof';

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'MAG Team')
      ..recipients.add('mhghassn@gmail.com')
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'activation Key :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\n'
      ..html = "<h2>Secret Key</h2>\n<p>Hey user! This is  Your activation Key $value </p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());

    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
  void showResult(String msg) {
    // ignore: deprecated_member_use
    scaf.currentState.showSnackBar(
      SnackBar(
        content: Text(msg, textAlign: TextAlign.center),
      ),
    );
  }

  Future<void> getUserToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _token = pref.getString("token") ?? "000";
    });
  }
}
